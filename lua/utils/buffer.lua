local M = {}
local len = require("utils.table").get_length
local indexOf = require("utils.table").indexOf

function M.get_buffs()
    local filter = require("utils.table").filter
    local bufs = filter(vim.api.nvim_list_bufs(), function (buf)
        return vim.api.nvim_buf_get_option(buf, 'buflisted')
    end)
    return bufs
end

function M.get_curr_listed_buff()
    local bufs = M.get_buffs()
    local curr_buf = vim.api.nvim_get_current_buf()
    local curr_i = indexOf(bufs, curr_buf)
    if curr_i == -1 then
        curr_buf = vim.fn.bufnr("#")
        curr_i = indexOf(bufs, curr_buf)
    end
    return curr_buf
end

function M.get_next_buff(curr_buf)
    local bufs = M.get_buffs()
    local curr_i = indexOf(bufs, curr_buf)
    if curr_i == -1 then
        curr_buf = vim.fn.bufnr("#")
        curr_i = indexOf(bufs, curr_buf)
    end
    local buffs_len = len(bufs)
    local next_i = curr_i + 1
    if next_i > buffs_len then
        next_i = 1
    end
    local next_buf = bufs[next_i]
    return next_buf
end

return M
