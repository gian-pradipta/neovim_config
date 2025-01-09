local M = {}

function M.get_length(t)
	local count = 0;
	for _, dat in ipairs(t) do
		count = count + 1
	end
	return count
end

function M.map(t, func)
	local new_table = {}
	for _, val in ipairs(t) do
		local new_val = func(val)
		table.insert(new_table, new_val)
	end
	return new_table
end

function M.filter(t, func)
	local new_table = {}
	for _, val in ipairs(t) do
		if func(val) then
			table.insert(new_table, val)
		end
	end
	return new_table
end

function M.indexOf(t, val)
	for i, value in ipairs(t) do
		if (val == value) then return i end
	end
	return -1
end

return M
