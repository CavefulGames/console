local asciitable = require('../luau_packages/asciitable')
local consoleType = require('./type')
local chalk = require('../luau_packages/chalk_luau')
local format = require('./format')

local isRoblox = game and true or false
local isLune = (_VERSION :: string):sub(1, 4) == "Lune"
local isLuau = not (isLune or isRoblox)

export type ConsoleImpl = consoleType.ConsoleImpl

local console = {} :: ConsoleImpl
console.__index = console


return console