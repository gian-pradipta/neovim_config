local M = {}
local len = require "utils.table".get_length
local namespace = "MultipleSelection"
local exit_dot = require("features.helper.multiple_selections").exit_dot
local hl_group = namespace .. "Group"
local ns_id = vim.api.nvim_create_namespace(namespace)
vim.api.nvim_set_hl(0, hl_group, { bg = "#FFD700", fg = "#000000", bold = true })

M.line_infos = {}
M.word_now = ""
M.last_hl_pos = 1

function M.clear_hl(i)
    local line_info = M.line_infos[i]
    line_info.is_hl = false
    vim.api.nvim_buf_clear_namespace(0, ns_id, line_info.line - 1, line_info.line)
    M.last_hl_pos = i
end

function M.clear_all_hl()
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
end

local function cleanup()
    M.clear_all_hl()
    M.last_hl_pos = 1
    M.line_infos = {}
    M.word_now = ""
end

local function place_cursor(i)
    local line_info = M.line_infos[i]
    vim.api.nvim_win_set_cursor(0, {line_info.line, line_info.scol - 1})
end

function M.get_index_from_cursor()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local current_col = vim.api.nvim_win_get_cursor(0)[2] + 1
    for i, line_info in ipairs(M.line_infos) do
        if (current_line == line_info.line and (current_col >= line_info.scol and current_col <= line_info.ecol)) then
            return i
        end
    end
    return nil
end

function M.get_all_words(word)
    local new_word = exit_dot(word)
    cleanup()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for linenr, line in ipairs(lines) do
        local start_idx = 1
        while true do
            local start_pos, end_pos = string.find(line, new_word, start_idx)
            if not start_pos then break end
            start_idx = end_pos + 1
            table.insert(M.line_infos, {
                line=linenr, scol=start_pos, ecol=end_pos, is_hl=false
            })
        end
    end
    M.word_now = word
end

function M.add_hl(i)
    local line_info = M.line_infos[i]
    line_info.is_hl = true
    vim.api.nvim_buf_add_highlight(0, ns_id, hl_group, line_info.line - 1, line_info.scol - 1, line_info.ecol)
    M.last_hl_pos = i
end

function M.next()
    M.last_hl_pos = M.last_hl_pos + 1
    if (M.last_hl_pos > len(M.line_infos)) then
       M.last_hl_pos = 1
    end
    place_cursor(M.last_hl_pos)
end

function M.prev()
    M.last_hl_pos = M.last_hl_pos - 1
    if (M.last_hl_pos <= 0) then
       M.last_hl_pos = len(M.line_infos)
    end
    place_cursor(M.last_hl_pos)
end


function M.toggle_hl(i)
    if (M.line_infos[i].is_hl) then
        M.clear_hl(i)
    else
        M.add_hl(i)
    end
end

function M.change_hl_word(subs)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line_info in ipairs(M.line_infos) do
        local row = line_info.line
        local scol = line_info.scol
        local ecol = line_info.ecol
        local is_hl = line_info.is_hl
        if (is_hl) then
            local new_line = ""
            new_line = string.sub(lines[row], 1, scol - 1) .. subs .. string.sub(lines[row], ecol + 1, #lines[row])
            lines[row] = new_line
        end
    end
    vim.api.nvim_buf_set_lines(0, 0, len(lines) + 1, false, lines)
    cleanup()
end

return M
