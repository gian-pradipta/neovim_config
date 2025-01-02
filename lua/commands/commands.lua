vim.api.nvim_create_user_command(
	"SayHello",
	function ()
		print("Hello, world!");
	end,
	{}
);

vim.api.nvim_create_user_command(
	"BufferSurfing",
	function ()
		require("commands.buffer_surfing").create_menu();
	end,
	{range = false}
);
