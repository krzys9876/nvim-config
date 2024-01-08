-- status line
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- opts is what is passed to require("xxx").setup(opts)
	opts = {
		options = { theme = "dracula" },
	},
}
