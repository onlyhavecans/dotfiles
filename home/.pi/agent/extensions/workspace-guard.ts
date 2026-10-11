/**
 * Workspace Guard Extension
 *
 * Confines file tools (read/write/edit/ls/find/grep) and bash commands to:
 *   - the current workspace (ctx.cwd at tool-call time), and
 *   - /tmp (shared scratchpad), and
 *   - any extra roots listed in ~/.pi/agent/extensions/workspace-guard.json
 *     as { "allowedRoots": ["/some/dir"] }
 *
 * Enforcement is in tool_call (hard block), plus a system prompt rule so the
 * model knows the boundary up front and doesn't waste turns on blocked calls.
 *
 * Limits: bash is checked heuristically (absolute paths, ~ paths, and ".."
 * segments in the command text). It cannot see paths built at runtime, e.g.
 * `cd $(dirname /x)` or `python -c "open(...)"`. For real OS-level isolation
 * use examples/extensions/sandbox (bubblewrap/sandbox-exec) or a container.
 *
 * Commands: /workspace-guard shows the active roots.
 */

import { existsSync, readFileSync, realpathSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, isAbsolute, join, resolve, sep } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const FILE_TOOLS = new Set(["read", "write", "edit", "ls", "find", "grep"]);
const ALWAYS_OK_DEVICES = new Set(["/dev/null", "/dev/stdin", "/dev/stdout", "/dev/stderr"]);

function loadExtraRoots(): string[] {
	const path = join(homedir(), ".pi", "agent", "extensions", "workspace-guard.json");
	if (!existsSync(path)) return [];
	try {
		const parsed = JSON.parse(readFileSync(path, "utf-8"));
		return Array.isArray(parsed?.allowedRoots) ? parsed.allowedRoots.map(String) : [];
	} catch {
		return [];
	}
}

function expandHome(p: string): string {
	if (p === "~") return homedir();
	if (p.startsWith("~/")) return join(homedir(), p.slice(2));
	return p;
}

/** Resolve symlinks for the longest existing prefix, so links can't escape. */
function canonical(p: string): string {
	let current = resolve(p);
	const tail: string[] = [];
	while (!existsSync(current)) {
		const parent = dirname(current);
		if (parent === current) break;
		tail.unshift(current.slice(parent.length + (parent.endsWith(sep) ? 0 : 1)));
		current = parent;
	}
	try {
		current = realpathSync(current);
	} catch {
		/* keep as-is */
	}
	return tail.length ? join(current, ...tail) : current;
}

function isInside(target: string, root: string): boolean {
	return target === root || target.startsWith(root.endsWith(sep) ? root : root + sep);
}

function allowedRoots(cwd: string): string[] {
	const roots = [cwd, "/tmp", ...loadExtraRoots()].map((r) => canonical(expandHome(r)));
	return [...new Set(roots)];
}

function isAllowed(p: string, cwd: string, roots: string[]): boolean {
	if (ALWAYS_OK_DEVICES.has(p)) return true;
	const abs = canonical(isAbsolute(expandHome(p)) ? expandHome(p) : resolve(cwd, expandHome(p)));
	return roots.some((root) => isInside(abs, root));
}

/** Pull path-like tokens out of a shell command, ignoring URLs. */
function pathsInCommand(command: string): string[] {
	const noUrls = command.replace(/[a-zA-Z][a-zA-Z0-9+.-]*:\/\/\S+/g, " ");
	const tokens = noUrls.split(/[\s'"`;|&<>(){}=]+/).filter(Boolean);
	return tokens.filter(
		(t) => t.startsWith("/") || t === "~" || t.startsWith("~/") || t.split("/").includes(".."),
	);
}

const RULES = `
WORKSPACE BOUNDARY (enforced by policy, not a suggestion):
- You may only read, write, search, and execute inside the current workspace directory, or inside /tmp.
- /tmp is the only shared scratchpad. Use it for temporary files, scratch output, and anything that must live outside the workspace.
- Do not access any other path: no parent directories above the workspace, no home-directory dotfiles, no system paths (/etc, /usr, /var, /root, other users' homes), no absolute paths outside the allowed roots, and no ".." escapes.
- Do not use cd, symlinks, or shell tricks to reach outside these roots.
- If a task seems to require a path outside these roots, stop and ask the user instead of trying.
- Blocked tool calls are final for that path. Do not retry with a different spelling of the same path.
`;

export default function (pi: ExtensionAPI) {
	pi.on("before_agent_start", async (event, ctx) => {
		const roots = allowedRoots(ctx.cwd);
		return {
			systemPrompt: `${event.systemPrompt}\n${RULES}\nAllowed roots right now:\n${roots.map((r) => `- ${r}`).join("\n")}\n`,
		};
	});

	pi.on("tool_call", async (event, ctx) => {
		const cwd = ctx.cwd;
		const roots = allowedRoots(cwd);
		const block = (reason: string) => {
			if (ctx.hasUI) ctx.ui.notify(`workspace-guard: ${reason}`, "warning");
			return { block: true, reason };
		};

		if (FILE_TOOLS.has(event.toolName)) {
			const raw = (event.input.path as string | undefined) ?? ".";
			if (!isAllowed(raw, cwd, roots)) {
				return block(`path "${raw}" is outside the workspace and /tmp. Allowed: ${roots.join(", ")}`);
			}
			return undefined;
		}

		if (event.toolName === "bash") {
			const command = String(event.input.command ?? "");
			for (const p of pathsInCommand(command)) {
				if (!isAllowed(p, cwd, roots)) {
					return block(`command references "${p}", which is outside the workspace and /tmp`);
				}
			}
		}

		return undefined;
	});

	pi.registerCommand("workspace-guard", {
		description: "Show the directories workspace-guard allows",
		handler: async (_args, ctx) => {
			ctx.ui.notify(`Allowed roots:\n${allowedRoots(ctx.cwd).join("\n")}`, "info");
		},
	});
}
