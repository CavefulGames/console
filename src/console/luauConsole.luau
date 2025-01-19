local asciitable = require('../../luau_packages/asciitable')
local chalk_luau = require('../../luau_packages/chalk_luau')
local consoleType = require('../type')
local format = require('../format')

local count= {}
local time: { [string]: number }  = {}
local group = 0

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

function luauConsole.assert(value, ...)
    if value then
        return
    end
    luauConsole.error('Assertion failed:', ...)
end

function luauConsole.count(label)
    count[label or 'default'] = count[label or 'default'] or 1
    luauConsole.log(`{label and label or 'default'}: {count[label or 'default']}`)
    count[label or 'default'] += 1
end

function luauConsole.countReset(label)
    count[label or 'default'] = 1
end

luauConsole.debug = luauConsole.log

function luauConsole.dir(object, opetions)
    opetions = opetions or {}

    if (opetions :: any).colors then
        luauConsole.log(object)
        return
    end

    print(format.stringPrototypeRepeatFormat('  ', group) .. format.formatColorTextWithSelectColor(format.colors.white, object) :: any .. '\n')
end

luauConsole.dirxml = luauConsole.log

function luauConsole.group(...)
    luauConsole.log(...)
    group += 1
end

function luauConsole.groupEnd()
    group = math.abs(group - 1)
end

luauConsole.info = luauConsole.log

function luauConsole.table(table)
    luauConsole.log(asciitable.table(table))
end

function luauConsole.time(label)
    label = label or 'default'

    if time[label or 'default'] then
        return
    end

    time[label or 'default'] = os.clock()
end

function luauConsole.timeLog(label, ...)
    if not time[label or 'default'] then
        return
    end
    luauConsole.log(label or 'default:', math.floor((os.clock() - time[label or 'default']) * 1000) / 1000, ...)
end

function luauConsole.timeEnd(label)
    if not time[label or 'default'] then
        return
    end

    luauConsole.timeLog(label)

    time[label or 'default'] = nil
end

function luauConsole.tree(top, child)
    luauConsole.log(asciitable.tree(top, child :: any))
end

return luauConsole