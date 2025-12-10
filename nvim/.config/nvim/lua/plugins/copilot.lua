return {
	{
		"github/copilot.vim",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      { "nvim-telescope/telescope.nvim", branch = "master" }, -- optional, for telescope integration
		},
		-- build = "make tiktoken", -- Only on MacOS or Linux
		-- opts = {
		-- See Configuration section for options
		--},
		opts = function()
			local user = vim.env.USER or "User"
			user = user:sub(1, 1):upper() .. user:sub(2)
			return {
				auto_insert_mode = true,
				question_header = "  " .. user .. " ",
				answer_header = "  Copilot ",
				window = {
					width = 0.4,
				},
			}
		end,
		keys = {
			{ "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
			{ "<leader>c", "", desc = "+ai", mode = { "n", "v" } },
			{
				"<leader>cc",
				function()
					return require("CopilotChat").toggle()
				end,
				desc = "Toggle (CopilotChat)",
				mode = { "n", "v" },
			},
      { "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Explain code" },
      { "<leader>cf", "<cmd>CopilotChatFix<CR>", desc = "Fix code issues" },
      { "<leader>cq", "<cmd>CopilotChatQuick<CR>", desc = "Quick chat" },
      { "<leader>ct", "<cmd>CopilotChatTests<CR>", desc = "Generate tests" },
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			-- vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-chat",
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
				end,
			})

			chat.setup(opts)
			-- config = function()
		end,

		-- vim.g.copilot_no_tab_map = true
		--vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
		--end,
		-- See Commands section for default commands if you want to lazy load on them
	},
}
