local windows = package.config:sub(1, 1) == "\\"

package.path = table.concat({
	"./?";
	"./?.lua";

	windows
		and (os.getenv("USERPROFILE").."\\.colorspec\\?")
		or (os.getenv("HOME").."/.colorspec/?");
	windows
		and (os.getenv("USERPROFILE").."\\.colorspec\\?.lua")
		or (os.getenv("HOME").."/.colorspec/?.lua");

	windows
		and "C:\\colorspec\\?"
		or "/usr/share/colorspec/?";
	windows
		and "C:\\colorspec\\?.lua"
		or "/usr/share/colorspec/?.lua";

	not windows
		and "/usr/local/share/colorspec/?";
	not windows
		and "/usr/local/share/colorspec/?.lua";

}, ';')

-- command line args
local arg = arg or {...}
-- a list of format tables
local formats = {}
-- a list of open input file objects
local infiles = {}
-- list of input file names, matchin the files in "infiles"
local infilenames = {}
-- maps keys to names according to formats
local keys = {}

setmetatable(keys, {
	__index = function(self, k, v)
		for _, format in ipairs(formats) do
			if format[k] then
				return format[k]
			end
		end
	end
})

local function xopen(name)
	local f, err = io.open(name, "r")
	if not f then
		io.stderr:write(err, '\n')
		os.exit(1)
	end
	return f
end

local onlyfiles = false
for _, a in ipairs(arg) do
	if a == '--' then
		onlyfiles = true
	elseif onlyfiles then
		table.insert(infilenames, a)
		table.insert(infiles, xopen(a))
	elseif a:match '^-%F.' then
		local formatfile = a:match '^%-F(.+)$'
		local formattable = require(formatfile)
		table.insert(formats, formattable)
	elseif a:match '^%-I.' then
		local dir = a:match '^%-I(.+)$'
		package.path = package.path..";"..dir..'/?'
		package.path = package.path..";"..dir..'/?.lua'
	elseif a == '-' then
		table.insert(infilenames, "<stdin>")
		table.insert(infiles, io.stdin)
	else
		table.insert(infilenames, a)
		table.insert(infiles, xopen(a))
	end
end

if #infiles == 0 then
	infilenames = {"<stdin>"}
	infiles = {io.stdin}
end

local colors = {
	black = 0,
	red = 1,
	green = 2,
	yellow = 3,
	blue = 4,
	magenta = 5,
	purple = 5,
	cyan = 6,
	white = 7,
	default = 9,
}

local modifiers = {
	bold = 1,

	underlined = 4,
	underline = 4,

	italic = 3,

	crossed = 9,
	strikethrough = 9,

	inverse = 7,
	invert = 7,
	inverted = 7,
	reverse = 7,
	reversed = 7,
}

local FOREGROUND = 0
local BACKGROUND = 10
local DIM = 30
local BRIGHT = 90

local linenum = 0
local filename = "?"

local function getline()
	for i, f in ipairs(infiles) do
		linenum = 1
		filename = infilenames[i]
		for line in f:lines() do
			coroutine.yield(line)
			linenum = linenum + 1
		end
		f:close()
	end
end

local function info(...)
	io.stderr:write(filename, ':', linenum, '\t', table.concat {...}, '\n')
end

local function doline(spec)
	local result = {}
	local k1 = DIM
	local k2 = FOREGROUND
	for token in spec:gmatch '(%S+)' do
		if token == 'on' then
			k2 = BACKGROUND
			k1 = DIM
		elseif token == 'bright' then
			k1 = BRIGHT
		elseif modifiers[token] then
			table.insert(result, modifiers[token])
		elseif colors[token] then -- 4 bit colors
			table.insert(result, colors[token] + k1 + k2)
		elseif token:match '^%d+$' then -- 8 bit colors
			table.insert(result, (k2==BACKGROUND and '48' or '38')..';5;'..token)
		elseif token:match '^#%x%x%x%x%x%x$' then -- 24 bit color
			table.insert(result, (k2==BACKGROUND and '48' or '38')..';2;'..token:gsub('#(..)(..)(..)', function(r, g, b)
				return tonumber(r, 16)..';'..tonumber(g, 16)..';'..tonumber(b, 16)
			end))
		else
			info('unknown color/modifier: ', token)
		end
	end
	return table.concat(result, ';')
end

local result = {}

for line in coroutine.wrap(getline) do
	if line:match '^%s*$' or line:match '^%s*#' then
		goto continue
	end
	local key, rest = line:match('^(.-):(.+)$')
	if not key and rest then
		info "bad syntax"
		goto continue
	end
	local resolved = keys[key] or keys[string.lower(key)]
	if not resolved then
		info("unknown key: ", key)
		goto continue
	end
	table.insert(result, resolved .. "=" .. doline(rest))
	::continue::
end

print(table.concat(result, ':'))
