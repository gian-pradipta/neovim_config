local M = {}

function M.config(lspconfig)
	lspconfig.clangd.setup({
		cmd = { "clangd", "--background-index", "--clang-tidy" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
		settings = {
			clangd = {
				arguments = { "--completion-style=detailed" }
			}
		},
		on_attach = function(client, bufnr)
			-- Keybindings for LSP functionality
			local opts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		end,
	})
end

return M;
