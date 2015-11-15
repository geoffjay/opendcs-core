#!/usr/bin/python3

from gi.repository import GLib
from gi.repository import OpenDCS

import sys

class DcsExample(object):
    def __init__(self):
        self.dcsobject = OpenDCS.Object.new()
        self.dcsobject.set_hash(0)
        print >>sys.stderr, self.dcsobject.get_hash()

if __name__ == "__main__":
    DcsExample()
