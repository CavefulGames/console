local asciitable = require('../../luau_packages/asciitable')
local chalk_luau = require('../../luau_packages/chalk_luau')
local consoleType = require('../type')
local format = require('../format')
local stdio = require('@lune/stdio')

local count= {}
local time: { [string]: number }  = {}
local group = 0

local luneConsole = {} :: consoleType.ConsoleImpl

function luneConsole.log(...)
    stdio.write(format.stringPrototypeRepeatFormat('  ', group) .. stdio.format(format.formatColorText(...)) .. '\n')
end

function luneConsole.error(...)
    stdio.ewrite(format.stringPrototypeRepeatFormat('  ', group) .. stdio.format(format.formatColorTextWithSelectColor(chalk_luau.red, ...)) .. '\n')
end

function luneConsole.warn(...)
    stdio.ewrite(format.stringPrototypeRepeatFormat('  ', group) .. stdio.format(format.formatColorTextWithSelectColor(chalk_luau.rgb(255, 165, 0), ...)) .. '\n')
end

function luneConsole.assert(value, ...)
    if value then
        return
    end
    luneConsole.error('Assertion failed:', ...)
end

function luneConsole.count(label)
    count[label or 'default'] = count[label or 'default'] or 1
    luneConsole.log(`{label and label or 'default'}: {count[label or 'default']}`)
    count[label or 'default'] += 1
end

function luneConsole.countReset(label)
    count[label or 'default'] = 1
end

luneConsole.debug = luneConsole.log

function luneConsole.dir(object, opetions)
    opetions = opetions or {}

    if (opetions :: any).colors then
        luneConsole.log(object)
        return
    end

    stdio.write(format.stringPrototypeRepeatFormat('  ', group) .. stdio.format(format.formatColorTextWithSelectColor(format.colors.white, object)) .. '\n')
end

luneConsole.dirxml = luneConsole.log

function luneConsole.group(...)
    luneConsole.log(...)
    group += 1
end

function luneConsole.groupEnd()
    group = math.abs(group - 1)
end

luneConsole.info = luneConsole.log

function luneConsole.table(table)
    luneConsole.log(asciitable.table(table))
end

function luneConsole.time(label)
    label = label or 'default'

    if time[label or 'default'] then
        return
    end

    time[label or 'default'] = os.clock()
end

function luneConsole.timeLog(label, ...)
    if not time[label or 'default'] then
        return
    end
    luneConsole.log(label or 'default:', math.floor((os.clock() - time[label or 'default']) * 1000) / 1000, ...)
end

function luneConsole.timeEnd(label)
    if not time[label or 'default'] then
        return
    end

    luneConsole.timeLog(label)

    time[label or 'default'] = nil
end

function luneConsole.tree(top, child)
    luneConsole.log(asciitable.tree(top, child :: any))
end

return luneConsole