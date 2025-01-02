vim.api.nvim_create_user_command(
	"SayHello",
	function ()
		print("Hello, world!");
	end,
	{}
);

vim.api.nvim_create_user_command(
	"GetNextBuff",
	function ()
		local get_length = require("utils.table_utils").get_length
		local indexOf = require("utils.table_utils").indexOf
		local bufs = require("commands.commands_helper").get_buffs()
		local curr_buf = vim.api.nvim_get_current_buf()
		local curr_i = indexOf(bufs, curr_buf)
		local buffs_len = get_length(bufs)
		local next_i = curr_i + 1
		if next_i > buffs_len then
			next_i = buffs_len
		end
		local next_buf = bufs[next_i]
		print(vim.api.nvim_buf_get_name(next_buf))
	end,
	{range = false}
);

vim.api.nvim_create_user_command(
	"GetAllBuff",
	function ()
		local bufs = require("commands.commands_helper").get_buffs()
		for _, buf in ipairs(bufs) do
			print(vim.api.nvim_buf_get_name(buf))
		end
	end,
	{range = false}
);


vim.api.nvim_create_user_command(
	"PopWindow",
	function ()
		require("utils.ui_utils").create_menu();
	end,
	{range = false}
);
