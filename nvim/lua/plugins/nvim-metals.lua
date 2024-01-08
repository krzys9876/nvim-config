return {
	"scalameta/nvim-metals",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"mfussenegger/nvim-dap",
			config = function(self, opts)
				-- Debug settings if you're using nvim-dap
				local dap = require("dap")

				dap.configurations.scala = {
					{
						type = "scala",
						request = "launch",
						name = "RunOrTest",
						metals = {
							runType = "runOrTestFile",
							--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
						},
					},
					{
						type = "scala",
						request = "launch",
						name = "Test Target",
						metals = {
							runType = "testTarget",
						},
					},
				}
			end,
		},
	},
	ft = { "scala", "sbt", "java" },
	opts = function()
		local metals_config = require("metals").bare_config()

		-- Example of settings
		metals_config.settings = {
			showImplicitArguments = true,
			excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
		}

		-- *READ THIS*
		-- I *highly* recommend setting statusBarProvider to true, however if you do,
		-- you *have* to have a setting to display this in your statusline or else
		-- you'll not see any messages from metals. There is more info in the help
		-- docs about this
		-- metals_config.init_options.statusBarProvider = "on"

		-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
		metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

		metals_config.on_attach = function(client, bufnr)
			require("metals").setup_dap()

			-- LSP mappings (moved from example metals config to lsp-config)
			--vim.keymap.set("n", "gD", vim.lsp.buf.definition)
			--vim.keymap.set("n", "K", vim.lsp.buf.hover)
			--vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP implementation (metals)"})
			--vim.keymap.set("n", "gr", vim.lsp.buf.references)
			--vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
			--vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
			--vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run)
			--vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
			--vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
			--vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)
			--vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

			vim.keymap.set("n", "<leader>ws", function()
				require("metals").hover_worksheet()
			end, { desc = "Metals hover_worksheet" })

			-- all workspace diagnostics
			vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist, { desc = "Diagnostics (all)" })

			-- all workspace errors
			vim.keymap.set("n", "<leader>ae", function()
				vim.diagnostic.setqflist({ severity = "E" })
			end, { desc = "Diagnostics (errors)" })

			-- all workspace warnings
			vim.keymap.set("n", "<leader>aw", function()
				vim.diagnostic.setqflist({ severity = "W" })
			end, { desc = "Diagnostics (warnings)" })

			-- buffer diagnostics only
			vim.keymap.set("n", "<leader>db", vim.diagnostic.setloclist, { desc = "Diagnostics (buffer only)" })

			vim.keymap.set("n", "[c", function()
				vim.diagnostic.goto_prev({ wrap = false })
			end, { desc = "Diagnostics (prev)" })

			vim.keymap.set("n", "]c", function()
				vim.diagnostic.goto_next({ wrap = false })
			end, { desc = "Diagnostics (next)" })

			-- Example mappings for usage with nvim-dap. If you don't use that, you can
			-- skip these
			vim.keymap.set("n", "<leader>dc", function()
				require("dap").continue()
			end, { desc = "DAP start/continue" })

			vim.keymap.set("n", "<leader>dr", function()
				require("dap").repl.toggle()
			end, { desc = "DAP REPL toggle" })

			vim.keymap.set("n", "<leader>dK", function()
				require("dap.ui.widgets").hover()
			end, { desc = "DAP hover" })

			vim.keymap.set("n", "<leader>dt", function()
				require("dap").toggle_breakpoint()
			end, { desc = "DAP toggle breakpoint" })

			vim.keymap.set("n", "<leader>dso", function()
				require("dap").step_over()
			end, { desc = "DAP step over" })

			vim.keymap.set("n", "<leader>dsi", function()
				require("dap").step_into()
			end, { desc = "DAP step into" })

			vim.keymap.set("n", "<leader>dl", function()
				require("dap").run_last()
			end, { desc = "DAP run last" })
		end

		return metals_config
	end,
	config = function(self, metals_config)
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}
