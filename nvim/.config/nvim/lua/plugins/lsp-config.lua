return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pylsp", "clangd", "ts_ls", "bashls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- local lspconfig = require("lspconfig")
			-- lspconfig.lua_ls.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.pylsp.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.clangd.setup({
			--   capabilities = capabilities,
			-- })
			vim.lsp.config("pylsp", {
				settings = {
					pylsp = {
						plugins = {
							jedi = {
								extra_paths = { vim.fn.getcwd() },
								environment = ".venv",
							},
						},
					},
				},
			})

			vim.lsp.config("ltex_plus", {
				settings = {
					ltex = {
						language = "en-US",
						-- any other ltex-plus specific settings
					},
				},
			})
			-- vim.lsp.config("ltex", {})

			-- 3. Enable them (pass a string or a list of strings)
			vim.lsp.enable("pylsp")
			vim.lsp.enable("ltex")

			-- local lspconfig = require("lspconfig")

			-- -- Setup your servers here
			-- lspconfig.pylsp.setup({
			-- 	settings = {
			-- 		pylsp = {
			-- 			plugins = {
			-- 				jedi = {
			-- 					extra_paths = {
			-- 						vim.fn.getcwd(),
			-- 					},
			-- 					environment = ".venv",
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })
			-- lspconfig.ltex.setup({})
			-- lspconfig.ltex.setup({
			-- 	-- cmd = {
			-- 	-- 	"ltex-ls",
			-- 	-- 	"--linker-args",
			-- 	-- 	"-Djdk.xml.totalEntitySizeLimit=0",
			-- 	-- },
			-- 	filetypes = { "markdown", "text", "gitcommit", "latex", "tex" },
			-- 	settings = {
			-- 		ltex = {
			-- 			language = "en-US", -- Set to English
			-- 			-- language = "ja-JP", -- Set to Japanese
			-- 		},
			-- 		additionalRules = {
			-- 			enablePickyRules = true,
			-- 			motherTongue = "ja-JP",
			-- 		},
			-- 	},
			-- })
			vim.lsp.enable("pylsp")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("clangd")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("bashls")

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.diagnostic.config({
				virtual_text = false,
				underline = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					linehl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					},
					numhl = {
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			})
			-- vim.diagnostic.config({ signs = { text = { [vim.diagnostic.severity.INFO] = ""}, texthl = "DiagnosticSignInfo" }})
			-- vim.diagnostic.config({ signs = { text = { [vim.diagnostic.severity.HINT] = ""}, texthl = "DiagnosticSignHint" }})
		end,
	},
}
