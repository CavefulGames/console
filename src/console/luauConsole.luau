local chalk_luau = require('../../luau_packages/chalk_luau')
local consoleType = require('../type')
local format = require('../format')

local luauConsole = {} :: consoleType.ConsoleImpl

function luauConsole.log(...)
    local args = table.pack(...)
    local res = ''
    for i=1, args.n do
        res ..= format.formatColorText(args[i]) .. ' '
    end
    print(res)
end

function luauConsole.error(...)
    local args = table.pack(...)
    local res = ''
    for i=1, args.n do
        res ..= format.formatColorTextWithSelectColor(chalk_luau.red, args[i]) .. ' '
    end
    print(res)
end

function luauConsole.warn(...)
    local args = table.pack(...)
    local res = ''
    for i=1, args.n do
        res ..= format.formatColorTextWithSelectColor(chalk_luau.rgb(255, 165, 0), args[i]) .. ' '
    end
    print(res)
end

return luauConsole