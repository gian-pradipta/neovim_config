local M = {}

function M.config(lspconfig)
    lspconfig.lua_ls.setup({
        on_attach = function (client, bufnr)
            print("Hello")
            vim.b[bufnr].comment_symbol = "--"
        end,
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
