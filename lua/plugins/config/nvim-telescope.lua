return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function ()
		require("telescope").setup {
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					 "%.o", "%.a", "%.out", "%.class",
					"%.pdf", "%.mkv", "%.mp4", "%.zip"
				},
				preview = false
			}
		}

	end
},
{
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup {
			extensions = {
				file_browser = {
					theme = "ivy",
					hijack_netrw = true,
					mappings = {
						["i"] = {
						},
						["n"] = {
						},
					},
				},
			},
		}
		require("telescope").load_extension "file_browser"
	end
}
