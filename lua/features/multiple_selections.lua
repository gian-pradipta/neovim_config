local M = {}
local len = require "utils.table".get_length
local namespace = "MultipleSelection"
local hl_group = namespace .. "Group"
local ns_id = vim.api.nvim_create_namespace(namespace)
vim.api.nvim_set_hl(0, hl_group, { bg = "#FFD700", fg = "#000000", bold = true })

M.lines_and_pos = {}
M.word_now = ""
local curr_pos = 1

function M.clear_hl(i)
    local line_info = M.lines_and_pos[i]
    line_info[4] = false
    vim.api.nvim_buf_clear_namespace(0, ns_id, line_info[1] - 1, line_info[1])
end

function M.clear_all_hl()
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
end

local function cleanup()
    M.clear_all_hl()
    curr_pos = 1
    M.lines_and_pos = {}
    M.word_now = ""
end

local function place_cursor(i)
    local pos = M.lines_and_pos[i]
    vim.api.nvim_win_set_cursor(0, {pos[1], pos[2] - 1})
end

local function get_all_words(word)
    cleanup()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for linenr, line in ipairs(lines) do
        local start_idx = 1
        while true do
            local start_pos, end_pos = string.find(line, word, start_idx)
            if not start_pos then break end
            start_idx = end_pos + 1
            table.insert(M.lines_and_pos, {linenr, start_pos, end_pos, false})
        end
    end
end

function M.add_hl(i)
    local pos = M.lines_and_pos[i]
    pos[4] = true
    vim.api.nvim_buf_add_highlight(0, ns_id, hl_group, pos[1] - 1, pos[2] - 1, pos[3])
end

function M.get_words_and_highlight_first(word)
    get_all_words(word)
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local current_col = vim.api.nvim_win_get_cursor(0)[2]
    for i, line_info in ipairs(M.lines_and_pos) do
        if (current_line == line_info[1] and current_col == line_info[2]) then
            curr_pos = i
            break
        end
    end
    place_cursor(curr_pos)
    M.word_now = word
    M.add_hl(curr_pos)
end

function M.next()
    curr_pos = curr_pos + 1
    if (curr_pos > len(M.lines_and_pos)) then
       curr_pos = 1
    end
    place_cursor(curr_pos)
end

function M.add_hl_next()
    M.next()
    M.add_hl(curr_pos)
end

function M.clear_hl_next()
    M.next()
    M.clear_hl(curr_pos)
end

function M.toggle_hl_next()
    M.next()
    if (M.lines_and_pos[curr_pos][4]) then
        M.clear_hl(curr_pos)
    else
        M.add_hl(curr_pos)
    end
end

function M.change_hl_word(subs)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line_info in ipairs(M.lines_and_pos) do
        local row = line_info[1]
        local scol = line_info[2]
        local ecol = line_info[3]
        local is_hl = line_info[4]
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
