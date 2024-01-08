return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "marksman" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.pyright.setup({})
      lspconfig.marksman.setup({})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP definition (lsp-config)" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code_actions (lsp-config)" })
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "LSP references (lsp-config)" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover (lsp-config)" })
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP implementation (lsp-config)"})
			vim.keymap.set("n", "<leader>gds", vim.lsp.buf.document_symbol, { desc = "LSP document_symbol (lsp-config)"})
			vim.keymap.set("n", "<leader>gws", vim.lsp.buf.workspace_symbol, { desc = "LSP workspace_symbol (lsp-config)"})
			vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "LSP codelens run (lsp-config)"})
			vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP signature help (lsp-config)"})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename (lsp-config)"})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "LSP format (lsp-config)"})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code_action (lsp-config)"})
	  end,
	},
}
