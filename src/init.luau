local isRoblox = game and true or false
local isLune = (_VERSION :: string):sub(1, 4) == "Lune"

if isRoblox then
    local robloxConsoleType = require(script:WaitForChild('type'))
    export type ConsoleImpl = robloxConsoleType.ConsoleImpl
    return require(script:WaitForChild('console'):WaitForChild('robloxConsole')) :: ConsoleImpl
end

local luauConsoleType = require('./type')
export type ConsoleImpl = luauConsoleType.ConsoleImpl
return if isLune then
        require('./console/luneConsole') :: ConsoleImpl
    else
        require('./console/luauConsole') :: ConsoleImpl