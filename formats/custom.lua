return setmetatable({}, {
	-- map any name to itself to silence warnings
	__index = function(_, k)
		return k
	end
})
