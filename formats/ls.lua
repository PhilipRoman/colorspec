#!/usr/bin/env lua5.3

return setmetatable({
	no = 'no',
	default = 'no',

	fi = 'fi',
	normal = 'fi',
	files = 'fi',
	file = 'fi',

	di = 'di',
	dir = 'di',
	directory = 'di',
	directories = 'di',
	folder = 'di',
	folders = 'di',

	ln = 'ln',
	symlink = 'ln',
	symlinks = 'ln',
	link = 'ln',
	links = 'ln',
	['symbolic link'] = 'ln',
	['symbolic links'] = 'ln',

	pi = 'pi',
	pipe = 'pi',
	pipes = 'pi',
	fifo = 'pi',
	fifos = 'pi',
	['named pipe'] = 'pi',
	['named pipes'] = 'pi',

	so = 'so',
	socket = 'so',
	sockets = 'so',

	['do'] = 'do',
	door = 'do',
	doors = 'do',

	bd = 'bd',
	block = 'bd',
	blocks = 'bd',
	['block device'] = 'bd',
	['block devices'] = 'bd',

	cd = 'cd',
	['character device'] = 'cd',
	['character devices'] = 'cd',
	['char device'] = 'cd',
	['char devices'] = 'cd',

	['or'] = 'or',
	orphan = 'or',
	orphans = 'or',
	['orphan symlink'] = 'or',
	['orphan symlinks'] = 'or',

	mi = 'mi',
	missing = 'mi',
	['missing file'] = 'mi',
	['missing files'] = 'mi',

	su = 'su',
	setuid = 'su',
	uid = 'su',
	['set uid'] = 'su',

	sg = 'sg',
	setgid = 'sg',
	gid = 'sg',
	['set gid'] = 'sg',

	tw = 'tw',
	['sticky other writable'] = 'tw',

	ow = 'ow',
	['other writable'] = 'ow',

	st = 'st',
	['sticky'] = st,

	ex = 'ex',
	executable = 'ex',
	executables = 'ex',
	exec = 'ex',
	exe = 'ex',
	['executable files'] = 'ex',
	['executable file'] = 'ex',
}, {
	-- map keys with wildcards to themselves
	__index = function(_, k)
		if k:match '[*.?]' then
			return k
		end
	end
})
