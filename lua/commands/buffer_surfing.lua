local len = require("utils.table_utils").get_length
local indexOf = require("utils.table_utils").indexOf
local map = require("utils.table_utils").map
local buff_util = require("utils.buffer_utils")

local M = {}
local toggle_mode = true

local function cleanup()
	toggle_mode = true
end

local function get_curr_line()
	local pos = vim.api.nvim_win_get_cursor(0)
	local line = pos[1]
	return line
end

function M.exit()
	cleanup()
	vim.api.nvim_win_close(0, true)
end

function M.select_file()
	local cmd = ""
	if (toggle_mode) then
		cmd = ":b#"
	else
		local buffs = buff_util.get_buffs()
		local i = get_curr_line()
		cmd = ":b " .. buffs[i]
	end
	M.exit()
	vim.cmd(cmd)
end

local function handle_movement()
	toggle_mode = false
	local buffs = buff_util.get_buffs()
	local buffnow = buffs[get_curr_line()]
	local nextbfnr = buff_util.get_next_buff(buffnow);
	local nextbfi = indexOf(buffs, nextbfnr)
	vim.cmd(":" .. nextbfi)
	print(nextbfnr)
end

function M.handler()
	handle_movement()
end

local function open_window(buf)
	local options = buff_util.get_buffs()
	local width = 100
	local height = len(options) + 3
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	return vim.api.nvim_open_win(buf, true, {
		title = "buffers",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
end

function M.create_menu()
    local buf = vim.api.nvim_create_buf(false, true)
    local options = buff_util.get_buffs()
    options = map(options, function (option)
    	return vim.api.nvim_buf_get_name(option)
    end)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, options)
    open_window(buf)
    local curr_buff = buff_util.get_curr_listed_buff()
    local curr_buff_i = indexOf(buff_util.get_buffs(), curr_buff)
    print(curr_buff_i)
    vim.cmd(":" .. curr_buff_i)
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":lua require('commands.buffer_surfing').exit()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "p", ":lua require('commands.buffer_surfing').handler()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "<C-p>", ":lua require('commands.buffer_surfing').select_file()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", ":lua require('commands.buffer_surfing').select_file()<CR>", { noremap = true, silent = true })

    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
end

return M
