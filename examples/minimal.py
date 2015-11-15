#!/usr/bin/python3

from gi.repository import GLib
from gi.repository import OpenDCS

import sys

class DcsExample(object):
    def __init__(self):
        self.dcsobject = OpenDCS.Object()
        self.dcsobject.set_property('id', 'test')
        print("Object hash: ", self.dcsobject.get_property('hash'))

if __name__ == "__main__":
    DcsExample()
