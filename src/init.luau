local isRoblox = game and true or false
local isLune = (_VERSION :: string):sub(1, 4) == "Lune"

export type ConsoleImpl = {
    __index: ConsoleImpl,
    log: (data: any, ...any) -> (),
    error: (data: any, ...any) -> (),
    warn: (data: any, ...any) -> (),
}

return (if isRoblox then 
        require(script:WaitForChild('console'):WaitForChild('robloxConsole')) :: any 
    elseif isLune then
        require('./console/luneConsole') :: any
    else
        require('./console/luauConsole') :: any
) :: ConsoleImpl