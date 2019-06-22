"""
Shortcut for cleaning hosts that have been replace if I forgot
"""

from thefuck.utils import for_app


@for_app('ssh', at_least=1)
def match(command):
    """Match all the SSH errors"""
    return (
        'WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!' in command.output or
        'differs from the key for the IP address' in command.output
    )


def get_new_command(command):
    """replace"""
    return command.script.replace('ssh', 'cleanhost', 1)


enabled_by_default = True
