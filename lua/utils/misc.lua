local M = {}
local len = require("utils.table").get_length

local function set_normal_mode()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

function M.feed_key(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), "n", false)
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

function M.comment()
    local lines = require("utils.string").get_visual_selection_text();
    local startln = vim.fn.getpos("v")[2]
    local char = vim.fn.getchar()
    local sym = ""
    while (char ~= 13) do
        sym = sym .. vim.fn.nr2char(char)
        char = vim.fn.getchar()
    end
    M.set_mode("n")
    vim.cmd(":" .. startln)
    for _ = 1, len(lines), 1 do
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("I", true, false, true), "n", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(sym .. " ", true, false, true), "n", false)
        M.set_mode("n")
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("j", true, false, true), "n", false)
    end

    vim.cmd(".")
end


function M.uncomment()
    local lines = require("utils.string").get_visual_selection_text();
    local startln = vim.fn.getpos("v")[2]
    local char = vim.fn.getchar()
    local lensym = 1
    while (char ~= 13) do
        lensym = lensym + 1
        char = vim.fn.getchar()
    end
    M.set_mode("n")
    vim.cmd(":" .. startln)
    for _ = 1, len(lines), 1 do
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("^", true, false, true), "n", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(lensym .. "x", true, false, true), "n", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("j", true, false, true), "n", false)
    end

    vim.cmd(".")
end

return M
