#!/usr/bin/env lua5.3

return {
	error = 'error',
	errors = 'error',

	warning = 'warning',
	warnings = 'warning',
	warn = 'warning',

	note = 'note',
	notes = 'note',

	path = 'path',
	paths = 'path',

	locus = 'locus',
	location = 'locus',
	source = 'locus',

	quote = 'quote',
	quotes = 'quote',

	['fixit-insert'] = 'fixit-insert',
	['suggested insert'] = 'fixit-insert',
	['suggested insertion'] = 'fixit-insert',
	['suggest insertion'] = 'fixit-insert',
	['suggested add'] = 'fixit-insert',
	['suggested addition'] = 'fixit-insert',
	['suggest addition'] = 'fixit-insert',

	['fixit-delete'] = 'fixit-insert',
	['suggested delete'] = 'fixit-insert',
	['suggested remove'] = 'fixit-insert',
	['suggest remove'] = 'fixit-insert',
	['suggested deletion'] = 'fixit-insert',
	['suggest deletion'] = 'fixit-insert',

	['diff-filename'] = 'diff-filename',

	['diff-hunk'] = 'diff-filename',

	['diff-delete'] = 'diff-filename',
	['diff deleted'] = 'diff-filename',
	['diff removed'] = 'diff-filename',

	['diff-insert'] = 'diff-filename',
	['diff inserted'] = 'diff-filename',
	['diff insertion'] = 'diff-filename',
	['diff added'] = 'diff-filename',
	['diff addition'] = 'diff-filename',

	['type-diff'] = 'type-diff',
}
