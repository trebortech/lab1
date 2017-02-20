from __future__ import absolute_import
from socket import error as socket_error

# Import salt libs
import salt.utils
import logging
import time

log = logging.getLogger(__name__)

# Define the module's virtual name
__virtualname__ = 'checks'


def __virtual__():
    return __virtualname__


def http(name, **kwargs):

    time.sleep(5)
    for x in range(0, 10):
        try:
            data = __salt__['http.query'](name, **kwargs)
            break

        except socket_error:
            data = 'nogo'

    return data
