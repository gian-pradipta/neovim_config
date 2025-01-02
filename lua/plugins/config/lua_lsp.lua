local M = {}

function M.config(lspconfig)
      lspconfig.lua_ls.setup({
	settings = {
	  Lua = {
	    diagnostics = {
	      globals = { "vim" }, -- Avoid warnings for "vim" global
	    },
	  },
	},
      })
end

return M
