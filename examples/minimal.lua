#!/usr/bin/env lua

local lgi = require 'lgi'
local DCS = lgi.require('OpenDCS', '0.1')

local object = DCS.Object { id = 'test' }
print("Object hash: " .. object:get_hash())
