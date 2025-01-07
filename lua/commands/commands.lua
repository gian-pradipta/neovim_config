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
		require("features.buffer_surfing").create_menu();
	end,
	{range = false}
);
