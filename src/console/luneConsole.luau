local chalk_luau = require('../../luau_packages/chalk_luau')
local consoleType = require('../type')
local format = require('../format')
local stdio = require('@lune/stdio')

local luneConsole = {} :: consoleType.ConsoleImpl
luneConsole.__index = luneConsole

function luneConsole.log(...)
    stdio.write(stdio.format(format.formatColorText(...)) .. '\n')
end

function luneConsole.error(...)
    stdio.ewrite(stdio.format(format.formatColorTextWithSelectColor(chalk_luau.red, ...)) .. '\n')
end

function luneConsole.warn(...)
    stdio.ewrite(stdio.format(format.formatColorTextWithSelectColor(chalk_luau.rgb(255, 165, 0), ...)) .. '\n')
end

return luneConsole