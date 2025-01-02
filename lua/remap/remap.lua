vim.api.nvim_set_keymap('n', '<Leader>b', ':buffers<CR>:buffer<Space>', {noremap=true, silent=false})
vim.api.nvim_set_keymap('v', 'Y', '"+y', {noremap=true, silent=false})
vim.api.nvim_set_keymap('n', 'P', '"+p', {noremap=true, silent=false})
vim.api.nvim_set_keymap('v', 'D', '"+d', {noremap=true, silent=false})
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>s', ":!ls<CR>:e **/", {noremap = true, silent = false})
vim.api.nvim_set_keymap('x', '<Leader>c', ":s/^/\\/\\/<CR>:nohl<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('x', '/', ":s/\\/\\<CR>:nohl<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Space><Space>', ":Telescope find_files<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Leader>fb', ":Telescope file_browser<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Space>t', ":NvimTreeToggle<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<C-p>', ":PopWindow<CR>", {noremap = true, silent = false})
vim.keymap.set("v", "<C-d>", function ()
	local lines = require("utils.string_utils").get_visual_selection_text();
end)

vim.cmd("set mouse=a")

