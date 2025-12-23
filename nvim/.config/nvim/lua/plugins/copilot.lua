return {
	{
		"ggml-org/llama.vim",
		enable = false,
		init = function()
			vim.g.llama_config = {
				endpoint = "http://192.168.3.193:11434",
			}
		end,
	},
	{
		"github/copilot.vim",
		-- enable = false,
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
				model = "claude-sonnet-4.5",
				auto_insert_mode = true,
				window = {
					layout = "float",
					width = 80, -- Fixed width in columns
					height = 20, -- Fixed height in rows
					border = "rounded", -- 'single', 'double', 'rounded', 'solid'
          relative = "editor", -- 'editor' or 'win'
					title = "🤖 AI Assistant",
					zindex = 100, -- Ensure window stays on top
				},

				-- headers = {
				-- 	user = "👤 You",
				-- 	assistant = "🤖 Copilot",
				-- 	tool = "🔧 Tool",
				-- },

				separator = "━━",
				auto_fold = true, -- Automatically folds non-assistant messages
				question_header = "👤 You",
				answer_header = "🤖 Copilot",
				-- window = {
				--   width = 0.4,
				-- },
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
      { "<leader>cv", function()
          require("CopilotChat").open({ window = {layout = "vertical"} })
        end,
        desc = "Copilot Chat vertical split",
      },
			{ "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Explain code" },
			{ "<leader>cf", "<cmd>CopilotChatFix<CR>", desc = "Fix code issues" },
			{ "<leader>ct", "<cmd>CopilotChatTests<CR>", desc = "Generate tests" },
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			-- vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })

			chat.setup(opts)
			-- config = function()
		end,

		-- vim.g.copilot_no_tab_map = true
		--vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
		--end,
		-- See Commands section for default commands if you want to lazy load on them
	},
}
