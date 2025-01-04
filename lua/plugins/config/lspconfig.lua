-- Helper function to set keymaps
local function set_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  keymap(bufnr, "n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
end

-- `on_attach` function for LSP
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  set_keymaps(bufnr)
end

-- Configures all servers
local function configure_all(lspconfig)
  local lua_lsp_config = require("plugins.config.lua_lsp")
  local clangd_config = require("plugins.config.clangd")
  
  -- Configure Lua and Clangd
  lua_lsp_config.config(lspconfig, on_attach)
  clangd_config.config(lspconfig, on_attach)
  
  -- Configure TypeScript server
  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(), -- Optional for autocompletion
  })
end

-- Plugin Configuration
return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")

    -- Ensure Mason installs the required LSP servers
    mason_lspconfig.setup({
      ensure_installed = { "lua_ls", "clangd", "ts_ls" }, -- Add more servers if needed
    })

    -- Configure installed servers
    configure_all(lspconfig)
  end,
}

