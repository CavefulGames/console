local chalk = require("../luau_packages/chalk_luau")

local colors = {
	red = chalk.red,
	green = chalk.green,
	yello = chalk.yellow,
	white = chalk.white,
	bold = chalk.bold,
}

local colorFormatStruct = setmetatable({
	string = colors.white,
	number = colors.yello,
	boolean = colors.yello,
	["nil"] = colors.white :: any .. colors.bold,
}, {})

local tableColorFormatStruct = setmetatable({
	string = colors.green,
	number = colors.yello,
	boolean = colors.yello,
	["nil"] = colors.white :: any .. colors.bold,
}, {})

local function getArgumentCodepointOrder(tab: { [number]: any })
	table.sort(tab, function(a, b)
		if typeof(a) == "number" and typeof(b) == "number" then
			return a < b
		end
		if typeof(a) == "number" then
			return true
		end
		if typeof(b) == "number" then
			return false
		end
		return tostring(a) < tostring(b)
	end)
	return tab
end

local function isArray(arr: { [any]: any })
	for k, v in arr do
		if typeof(k) == "number" then
			continue
		end
		return false
	end
	return true
end

local function simpleFormatNomal(s: any)
	return typeof(s) == "string" and `'{s}'` or tostring(s)
end

local function nomalTypeColor(nomal: any, useTable: boolean?): string
	return (useTable and tableColorFormatStruct or colorFormatStruct)[typeof(nomal)](
		nomal == nil and "nil" or tostring(nomal)
	)
end

local function no(a)
	return a
end

local function get_object_or_array_len(arrOrObj)
	local result = 0
	for k, v in arrOrObj do
		result += 1
	end
	return result
end

local formatObject

local function formatArray(arr: { [number]: any }, useColor: boolean): string
	local result = "{ "

	arr = getArgumentCodepointOrder(arr)

	for i=1, #arr do
		result ..= (useColor and nomalTypeColor(
			simpleFormatNomal(
				typeof(arr[i]) == "table"
						and (isArray(arr[i]) and formatArray(arr[i], useColor) or formatObject(arr[i], useColor))
					or arr[i]
			),
			true
		) or simpleFormatNomal(
			typeof(arr[i]) == "table"
					and (isArray(arr[i]) and formatArray(arr[i], useColor) or formatObject(arr[i], useColor))
				or arr[i]
		)) .. (i == #arr and "" or ", ")
	end

	return result .. " }"
end

function formatObject(obj: { [any]: any }, useColor: boolean): string
	local result = "{ "
	local i = 1

	for k, v in obj do
		result ..= `[{simpleFormatNomal(k)}] = ` .. (useColor and nomalTypeColor(
			simpleFormatNomal(
				typeof(v) == "table" and (isArray(v) and formatArray(v, useColor) or formatObject(v, useColor)) or v
			),
			true
		) or simpleFormatNomal(
			typeof(v) == "table" and (isArray(v) and formatArray(v, useColor) or formatObject(v, useColor)) or v
		)) .. (i == get_object_or_array_len(obj) and "" or ", ")
		i += 1
	end

	return result .. " }"
end

local function formatColorText<T...>(...: T...): T...
	local args = table.pack(...)
	local result = {}
	for i = 1, args.n do
		if typeof(args[i]) == "table" then
			result[#result + 1] = isArray(args[i] :: any) and formatArray(args[i] :: any, true)
				or formatObject(args[i] :: any, true)
			continue
		end
		result[#result + 1] = nomalTypeColor(args[i])
	end

	return table.unpack(result :: any)
end

local function formatColorTextWithSelectColor<T...>(color: chalk.StyLer, ...: T...): T...
	local args = table.pack(...)
	local result = {}
	for i = 1, args.n do
		if typeof(args[i]) == "table" then
			result[#result + 1] = color(
				isArray(args[i] :: any) and formatArray(args[i] :: any, false) or formatObject(args[i] :: any, false)
			)
			continue
		end
		result[#result + 1] = color(args[i] :: any)
	end

	return table.unpack(result :: any)
end

return {
	colors = colors,
	colorFormatStruct = colorFormatStruct,
	tableColorFormatStruct = tableColorFormatStruct,
	formatColorText = formatColorText,
	formatColorTextWithSelectColor = formatColorTextWithSelectColor,
}
