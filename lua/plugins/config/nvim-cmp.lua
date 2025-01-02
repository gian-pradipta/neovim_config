return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",  -- LSP Source for nvim-cmp
		"hrsh7th/cmp-buffer",    -- Buffer Source
		"hrsh7th/cmp-path",      -- Path Source
		"L3MON4D3/LuaSnip",      -- Snippet Engine
		"saadparwaiz1/cmp_luasnip", -- Snippet Source
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "luasnip" },
			}),
		})
	end,
}
