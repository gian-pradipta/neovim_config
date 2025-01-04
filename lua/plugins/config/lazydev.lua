return {
	"folke/lazydev.nvim",
    ft="lua",
	name = "lazydev.nvim",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
    config = function ()
        require("lazydev").setup({
            debug = false,
            library = {
                "nvim-cmp/lua/cmp/types",
            },
        })
    end
}
