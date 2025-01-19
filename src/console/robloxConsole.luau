local asciitable = require(script.Parent.Parent.Parent:WaitForChild('packages'):WaitForChild('asciitable'))
local consoleType = require(script.Parent.Parent:WaitForChild('type'))
local robloxConsole = {} :: consoleType.ConsoleImpl

local count= {}
local time: { [string]: number }  = {}
local group = 0

local function stringPrototypeRepeatFormat(str: string, num: number)
    local result = ''
    for i=1, num do
        result ..= str
    end
    return result
end

function robloxConsole.log(...)
    print(...)
end

function robloxConsole.error(...)
    warn(...)
end

function robloxConsole.warn(...)
    warn(...)
end

function robloxConsole.assert(value, ...)
    if value then
        return
    end
    robloxConsole.error('Assertion failed:', ...)
end

function robloxConsole.count(label)
    count[label or 'default'] = count[label or 'default'] or 1
    robloxConsole.log(`{label and label or 'default'}: {count[label or 'default']}`)
    count[label or 'default'] += 1
end

function robloxConsole.countReset(label)
    count[label or 'default'] = 1
end

robloxConsole.debug = robloxConsole.log

function robloxConsole.dir(object, opetions)
    opetions = opetions or {}

    if (opetions :: any).colors then
        robloxConsole.log(object)
        return
    end

    print(stringPrototypeRepeatFormat('  ', group) .. object :: any .. '\n')
end

robloxConsole.dirxml = robloxConsole.log

function robloxConsole.group(...)
    robloxConsole.log(...)
    group += 1
end

function robloxConsole.groupEnd()
    group = math.abs(group - 1)
end

robloxConsole.info = robloxConsole.log

function robloxConsole.table(table)
    robloxConsole.log(asciitable.table(table))
end

function robloxConsole.time(label)
    label = label or 'default'

    if time[label or 'default'] then
        return
    end

    time[label or 'default'] = os.clock()
end

function robloxConsole.timeLog(label, ...)
    if not time[label or 'default'] then
        return
    end
    robloxConsole.log(label or 'default:', math.floor((os.clock() - time[label or 'default']) * 1000) / 1000, ...)
end

function robloxConsole.timeEnd(label)
    if not time[label or 'default'] then
        return
    end

    robloxConsole.timeLog(label)

    time[label or 'default'] = nil
end

function robloxConsole.tree(top, child)
    robloxConsole.log(asciitable.tree(top, child :: any))
end

return robloxConsole