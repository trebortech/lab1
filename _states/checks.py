import logging

# Import salt libs
import salt.utils

log = logging.getLogger(__name__)

# Define the module's virtual name
__virtualname__ = 'checks'


def __virtual__():
    return __virtualname__


def http(name, status):

    ret = {'name': name,
           'changes': {},
           'result': True,
           'comment': ''}

    kwargs = {}
    kwargs['status'] = True

    __salt__['mine.send']('checks.http', name, **kwargs)

    ret['comment'] = 'http status updated'

    return ret
