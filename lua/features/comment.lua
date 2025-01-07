local ltrim = require("utils.string").ltrim
local len = require("utils.table").get_length
local get_curr_listed_buff = require("utils.buffer").get_curr_listed_buff
local get_visual_selection_text = require("utils.string").get_visual_selection_text
local set_mode = require "utils.misc".set_mode
local M = {}

local function is_line_commented(sym,line)
    local sindex = line:find("%S")
    line = string.sub(line, sindex, #line + 1)
    local firstchars = string.sub(line, 1, #sym)
    if (firstchars ~= sym) then
        return false
    end
    return true
end

local function is_block_commented(sym,lines)
    for _, line in ipairs(lines) do
        if (not is_line_commented(sym, line)) then
            return false
        end
    end
    return true
end

function M.comment(sym)
    local lines = get_visual_selection_text()
    local startln = vim.fn.getpos("v")[2]
    set_mode("n")
    vim.cmd(":" .. startln)
    for _ = 1, len(lines), 1 do
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("I", true, false, true), "n", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(sym .. " ", true, false, true), "n", false)
        set_mode("n")
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("j", true, false, true), "n", false)
    end
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":" .. startln .. "<CR>", true, false, true), "n", false)
end


function M.uncomment(sym)
    local lines = require("utils.string").get_visual_selection_text();
    local startln = vim.fn.getpos("v")[2]
    set_mode("n")
    vim.cmd(":" .. startln)
    for _ = 1, len(lines), 1 do
    local lensym = #sym
        local line_num = vim.api.nvim_win_get_cursor(0)[1]
        local current_line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
        current_line = ltrim(current_line)
        local firstchars = string.sub(current_line, 1, #sym + 1)
        print(firstchars)
        if (firstchars == sym .. " ") then
            lensym = lensym + 1
        end
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("^", true, false, true), "n", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(lensym .. "x", true, false, true), "n", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("j", true, false, true), "n", false)
    end

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":" .. startln .. "<CR>", true, false, true), "n", false)
end

function M.comment_toggle()

    local currbuff = get_curr_listed_buff()
    local sym = vim.b[currbuff].comment_symbol
    if (sym == nil) then
       sym = "--"
    end
    local lines = get_visual_selection_text()
    local is_commented = is_block_commented(sym,lines)
    if (is_commented) then
        M.uncomment(sym)
    else
        M.comment(sym)
    end
end

return M
