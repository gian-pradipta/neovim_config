vim.api.nvim_set_keymap('n', '<Leader>b', ':buffers<CR>:buffer<Space>', {noremap=true, silent=false})
vim.api.nvim_set_keymap('v', 'Y', '"+y', {noremap=true, silent=false})
vim.api.nvim_set_keymap('n', 'P', '"+p', {noremap=true, silent=false})
vim.api.nvim_set_keymap('v', 'D', '"+d', {noremap=true, silent=false})
vim.api.nvim_set_keymap('i', 'jj', '<esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<space><space>', ":Telescope find_files<cr>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', 'tt', ":NvimTreeToggle<cr>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<c-p>', ":BufferSurfing<cr>", {noremap = true, silent = false})
vim.keymap.set('n', '<c-e>', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("v", "<c-d>", function ()
	local len = require("utils.table_utils").get_length
	local lines = require("utils.string_utils").get_visual_selection_text();
	local cmd = "/" .. lines[len(lines)]
	vim.cmd(cmd)
	require("utils.misc_utils").set_mode("n")
end)

vim.keymap.set("n", "<c-d>", function ()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("n", true, false, true), "n", false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(".", true, false, true), "n", false)
end)

vim.keymap.set("x", "<c-_>", require("utils.comment_utils").comment_toggle)

vim.cmd("set mouse=a")
