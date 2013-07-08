#!/usr/bin/env python
import os
from os.path import expanduser, join, ismount
from string import Template
import re

mount_point = join(expanduser('~'), 'bunkey')
keydir = join(mount_point, 'sshkeys')
keys_re = re.compile(r'(pem|rsa|dsa)$')

def get_execute_item(label, command):
    template = Template("""
	<item label="$label">
	    <action name="Execute">
		<execute>$command</execute>
	    </action>
	</item>
    """)
    return template.substitute(label=label, command=command)

def get_seperator(label=None):
    if label is None:
	return "<separator />"
    else:
	return "<separator label=\"" + label + "\" />"

def get_keys_list(directory, regex):
    files = os.listdir(directory)
    files.sort()
    return [ f for f in files for m in [regex.search(f)] if m ]

def main():
    if not ismount(mount_point):
	mount = "/bin/mount " + mount_point
	print get_execute_item("Mount Drive", mount)
    else:
	umount = "/bin/umount " + mount_point
	print get_execute_item("UnMount Drive", umount)
	print get_seperator()

	for key in get_keys_list(keydir, keys_re):
	    keycmd = "ssh-add -t 2h " + join(keydir, key)
	    print get_execute_item(key, keycmd)


if __name__ == '__main__':
    print "<openbox_pipe_menu>"
    main()
    print "</openbox_pipe_menu>"
