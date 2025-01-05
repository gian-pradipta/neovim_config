local M = {}
--- @return string[]|nil lines

local function get_regular_v_text(srow, erow, scol, ecol)
	if vim.fn.mode() == 'v' then
		if srow < erow or (srow == erow and scol <= ecol) then
			return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
		else
			return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
		end
	end
end

local function get_visual_line_text(srow, erow, scol, ecol)
	if vim.fn.mode() == 'V' then
		if srow > erow then
			return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
		else
			return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
		end
	end
end


local function get_visual_block_text(srow, erow, scol, ecol)
	if vim.fn.mode() == '\22' then
		local lines = {}
		if srow > erow then
			srow, erow = erow, srow
		end
		if scol > ecol then
			scol, ecol = ecol, scol
		end
		for i = srow, erow do
			table.insert(
			lines,
			vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1]
			)
		end
		return lines
	end
end

function M.get_visual_selection_text()
	local _, srow, scol = unpack(vim.fn.getpos('v'))
	local _, erow, ecol = unpack(vim.fn.getpos('.'))
	if vim.fn.mode() == 'V' then
		return get_visual_line_text(srow, erow, scol, ecol);
	end
	if vim.fn.mode() == 'v' then
		return get_regular_v_text(srow, erow, scol, ecol);
	end
	if vim.fn.mode() == '\22' then
		return get_visual_block_text(srow, erow, scol, ecol);
	end
	return vim.fn.mode()
end

function M.ltrim(line)
    line = string.gsub(line, "^%s+", "")
    return line
end


return M
