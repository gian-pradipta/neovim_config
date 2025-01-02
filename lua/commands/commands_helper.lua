local M = {}

function M.get_buffs()
	local filter = require("utils.table_utils").filter
	local bufs = filter(vim.api.nvim_list_bufs(), function (buf)
		return vim.api.nvim_buf_get_option(buf, 'buflisted')
	end)
	return bufs
end

function M.get_buff_index(buff_number)
	local buffs = M.get_buffs()
	local indexOf = require("utils.table_utils").indexOf
	return indexOf(buffs, buff_number)
end

function M.get_next_buff()
	local get_length = require("utils.table_utils").get_length
	local indexOf = require("utils.table_utils").indexOf
	local bufs = require("commands.commands_helper").get_buffs()
	local curr_buf = vim.api.nvim_get_current_buf()
	local curr_i = indexOf(bufs, curr_buf)
	local buffs_len = get_length(bufs)
	local next_i = curr_i + 1
	if next_i > buffs_len then
		next_i = buffs_len
	end
	local next_buf = bufs[next_i]
	return next_buf
end

return M
