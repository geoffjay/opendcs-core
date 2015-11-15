#!/usr/bin/env lua

local lgi = require 'lgi'
local GObject = lgi.require('GObject')
local DCS = lgi.require('OpenDCS')

-- this won't work yet, a DCS object is an interface
local object = DCS.Object.new()
object.hash = 0
print object.hash
