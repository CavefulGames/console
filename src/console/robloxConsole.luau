local consoleType = require(script.Parent.Parent:WaitForChild('type'))

local luneConsole = {} :: consoleType.ConsoleImpl
luneConsole.__index = luneConsole

function luneConsole.log(...)
    print(...)
end

function luneConsole.error(...)
    warn(...)
end

function luneConsole.warn(...)
    warn(...)
end

return luneConsole