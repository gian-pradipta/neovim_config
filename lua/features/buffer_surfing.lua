local len = require("utils.table").get_length
local indexOf = require("utils.table").indexOf
local map = require("utils.table").map
local set_mode = require("utils.misc").set_mode
local buff_util = require("utils.buffer")

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
		local buffs = _G.BUFFER_ARRAY
		local i = get_curr_line()
		cmd = ":b " .. buffs[i]
	end
	M.exit()
	vim.cmd(cmd)
end

local function handle_movement()
    vim.api.nvim_buf_set_option(0, "modifiable", true)
	toggle_mode = false
	local buffs = buff_util.get_buffs()
	local buffnow = buffs[get_curr_line()]
	local nextbfnr = buff_util.get_next_buff(buffnow);
	local nextbfi = indexOf(buffs, nextbfnr)
	vim.cmd(":" .. nextbfi)
    local options = _G.BUFFER_ARRAY
    options = map(options, function (option)
    	return "  " .. vim.api.nvim_buf_get_name(option)
    end)
    options[nextbfi] = "> " .. string.sub(options[nextbfi], 2, -1)
    text_now = options
    vim.api.nvim_buf_set_lines(0, 0, -1, false, options)
    vim.api.nvim_buf_add_highlight(0, -1, "Search", nextbfi - 1, 1, -1)
	print(nextbfnr)
    vim.api.nvim_buf_set_option(0, "modifiable", false)
end

function M.handler()
	handle_movement()
end

local function open_window(buf)
	local options = _G.BUFFER_ARRAY
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
    local options = _G.BUFFER_ARRAY
    options = map(options, function (option)
    	return "  " .. vim.api.nvim_buf_get_name(option)
    end)
    options[1] = "> " .. string.sub(options[1], 2, -1)
    open_window(buf)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, options)
    vim.api.nvim_buf_add_highlight(0, -1, "Search", 1 - 1, 1, -1)
    local curr_buff = buff_util.get_curr_listed_buff
    local curr_buff_i = indexOf(options, curr_buff)
    print(curr_buff_i)
    vim.cmd(":" .. curr_buff_i)
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":lua require('features.buffer_surfing').exit()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "p", ":lua require('features.buffer_surfing').handler()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "<C-p>", ":lua require('features.buffer_surfing').select_file()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", ":lua require('features.buffer_surfing').select_file()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

return M
