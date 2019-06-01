from thefuck.utils import for_app

@for_app('ssh', at_least=1)
def match(command):
    return (
        'WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!' in command.output
    )

def get_new_command(command):
    return command.script.replace('ssh', 'cleanhost', 1)

enabled_by_default = True
