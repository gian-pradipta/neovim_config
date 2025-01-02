vim.api.nvim_set_keymap('n', '<Leader>b', ':buffers<CR>:buffer<Space>', {noremap=true, silent=false})
vim.api.nvim_set_keymap('v', 'Y', '"+y', {noremap=true, silent=false})
vim.api.nvim_set_keymap('n', 'P', '"+p', {noremap=true, silent=false})
vim.api.nvim_set_keymap('v', 'D', '"+d', {noremap=true, silent=false})
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Space><Space>', ":Telescope find_files<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Space>t', ":NvimTreeToggle<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<C-p>', ":BufferSurfing<CR>", {noremap = true, silent = false})
vim.keymap.set("v", "<C-d>", function ()
	local len = require("utils.table_utils").get_length
	local lines = require("utils.string_utils").get_visual_selection_text();
	local cmd = "/" .. lines[len(lines)]
	vim.cmd(cmd)
	require("utils.misc_utils").set_mode("n")
end)

vim.keymap.set("n", "<C-d>", function ()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("n", true, false, true), "n", false)
	vim.cmd(".")
end)

vim.cmd("set mouse=a")

