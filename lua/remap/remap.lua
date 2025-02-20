vim.api.nvim_set_keymap('n', '\\b', ':buffers<CR>:buffer<Space>', {noremap=true, silent=false})
vim.api.nvim_set_keymap('v', 'Y', '"+y', {noremap=true, silent=false})
vim.api.nvim_set_keymap('n', 'P', '"+p', {noremap=true, silent=false})
vim.api.nvim_set_keymap('v', 'D', '"+d', {noremap=true, silent=false})
vim.api.nvim_set_keymap('i', 'jj', '<esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<space><space>', ":Telescope find_files<cr>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', 'tt', ":NvimTreeToggle<cr>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<c-p>', ":BufferSurfing<cr>", {noremap = true, silent = false})
vim.keymap.set('n', '<c-e>', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("v", "<c-d>", function ()
	local len = require("utils.table").get_length
	local lines = require("utils.string").get_visual_selection_text();
	local cmd = "/" .. lines[len(lines)]
	vim.cmd(cmd)
	require("utils.misc").set_mode("n")
end)

vim.keymap.set("x", "<c-_>", require("features.comment").comment_toggle)
vim.keymap.set("x", "<c-d>", function ()
    local ms = require("features.multiple_selections")
    local len = require("utils.table").get_length
    local get_visual_selection_text = require("utils.string").get_visual_selection_text
    local words = get_visual_selection_text()
    local word = words[len(words)]
	require("utils.misc").set_mode("n")
    ms.get_all_words(word)
    local index = ms.get_index_from_cursor()
    ms.add_hl(index)

end)

vim.keymap.set("n", "<c-d>", function ()
    local ms = require("features.multiple_selections")
    local i = ms.get_index_from_cursor()
    if (i ~= nil) then
        ms.toggle_hl(i)
    end
end)

vim.keymap.set("n", "N", function ()
    local ms = require("features.multiple_selections")
    ms.next()
end)

vim.keymap.set("n", "<Space>p", function ()
    local ms = require("features.multiple_selections")
    ms.prev()
end)


vim.keymap.set("n", "<Space>c", function ()
    local ms = require("features.multiple_selections")
    print(ms.word_now)
    local word = vim.fn.input("Change to: ", ms.word_now)
    ms.change_hl_word(word)
end)

vim.cmd("set mouse=a")
