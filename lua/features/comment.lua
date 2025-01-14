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
    for i, _ in ipairs(lines) do
        lines[i] = sym .. lines[i]
    end
    vim.api.nvim_buf_set_lines(0, startln - 1, startln + len(lines) - 1, false, lines)
end


function M.uncomment(sym)
    local lines = require("utils.string").get_visual_selection_text();
    local startln = vim.fn.getpos("v")[2]
    set_mode("n")
    vim.cmd(":" .. startln)
    for i, _ in ipairs(lines) do
        local sym_from_line = string.sub(lines[i], 1, #sym)
        if (sym_from_line == sym) then
            lines[i] = string.sub(lines[i], #sym + 1, #lines[i])
        end
    end
    vim.api.nvim_buf_set_lines(0, startln - 1, startln + len(lines) - 1, false, lines)
end

function M.comment_toggle()
    local currbuff = get_curr_listed_buff()
    local sym = vim.b[currbuff].comment_symbol
    if (sym == nil) then
       sym = "//"
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
