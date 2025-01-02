local M = {}

local function set_normal_mode()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

function M.set_mode(mode)
	set_normal_mode()
	local key = ""
	if (mode == "n") then
		key = ""
	elseif (mode == "v") then
		key = "v"
	elseif (mode == "i") then
		key = "i"
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), "n", false)
end

return M
