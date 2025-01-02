local function configure_all(lspconfig)
	local lua_lsp_config = require("plugins.config.lua_lsp");
	local clangd_config = require("plugins.config.clangd");
	lua_lsp_config.config(lspconfig);
	clangd_config.config(lspconfig);
end

return {
	"neovim/nvim-lspconfig",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function ()
			local lspconfig = require("lspconfig")
			configure_all(lspconfig)
		end
}
