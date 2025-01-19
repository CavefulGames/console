local isRoblox = game and true or false
local isLune = (_VERSION :: string):sub(1, 4) == "Lune"

if isRoblox then
    local robloxConsoleType = require(script:WaitForChild('types'):WaitForChild('robloxType'))
    return require(script:WaitForChild('console'):WaitForChild('robloxConsole')) :: robloxConsoleType.ConsoleImpl
end

local luauConsoleType = require('./types/luauType')
return if isLune then
        require('./console/luneConsole') :: luauConsoleType.ConsoleImpl
    else
        require('./console/luauConsole') :: luauConsoleType.ConsoleImpl