return {
	{
		"ggml-org/llama.vim",
		-- enable = false,
		init = function()
			vim.g.llama_config = {
				endpoint = "http://192.168.3.190:11436/infill",
				-- endpoint = "http://192.168.3.190:11434/infill",
				-- Local Context (Line based)
				n_prefix = 64, -- ~640 tokens
				n_suffix = 32, -- ~320 tokens
				n_predict = 128, -- Space for the AI's answer

				-- Ring Buffer (Global context from other files)
				-- Default is usually 8 chunks; we reduce it to keep the current file prioritized
				ring_n_chunks = 4,
				ring_chunk_size = 16, -- Smaller chunks to save space
			}
		end,
	},
	-- {
	--   "github/copilot.vim",
	--   -- enable = false,
	-- },
	{
		"olimorris/codecompanion.nvim",
		-- enable = false,
		version = "^18.0.0",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = { adapter = "llama.cpp" },
					inline = { adapter = "llama.cpp" },
					agent = { adapter = "openhands" },
				},
				adapters = {
					http = {
						["llama.cpp"] = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "http://192.168.3.190:11434", -- replace with your llama.cpp instance
									api_key = "TERM",
									chat_url = "/v1/chat/completions",
								},
								-- handlers = {
								-- 	parse_message_meta = function(self, data)
								-- 		local extra = data.extra
								-- 		if extra and extra.reasoning_content then
								-- 			data.output.reasoning = { content = extra.reasoning_content }
								-- 			if data.output.content == "" then
								-- 				data.output.content = nil
								-- 			end
								-- 		end
								-- 		return data
								-- 	end,
								-- },
							})
						end,
					},
					acp = {
						-- 1. OPENHANDS ADAPTER (For Agent Workflows)
						openhands = function()
							return require("codecompanion.adapters").extend("acp", {
								name = "openhands",
								env = {
									OPENHANDS_HOME = vim.fn.expand("~/.openhands"),
								},
								schema = {
									command = {
										default = vim.fn.expand("~/.local/bin/openhands"),
									},
									args = {
										default = { "acp" },
									},
								},
							})
						end,
					},
				},
			})
		end,
		keys = {
			{
				"<leader>cc",
				function()
					require("codecompanion").toggle()
				end,
				desc = "Toggle CodeCompanion chat",
				mode = { "n", "v" },
			},
			{
				"<leader>cp",
				"<cmd>CodeCompanionActions<CR>",
				desc = "CodeCompanion Action Palette",
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
	},
	--{
	--	"CopilotC-Nvim/CopilotChat.nvim",
	--	enable = false,
	--	dependencies = {
	--		{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
	--		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	--		{ "nvim-telescope/telescope.nvim", branch = "master" }, -- optional, for telescope integration
	--	},
	--	-- build = "make tiktoken", -- Only on MacOS or Linux
	--	-- opts = {
	--	-- See Configuration section for options
	--	--},
	--	opts = function()
	--		local user = vim.env.USER or "User"
	--		user = user:sub(1, 1):upper() .. user:sub(2)
	--		return {
	--			model = "claude-sonnet-4.5",
	--			auto_insert_mode = true,
	--			window = {
	--				layout = "float",
	--				width = 80, -- Fixed width in columns
	--				height = 20, -- Fixed height in rows
	--				border = "rounded", -- 'single', 'double', 'rounded', 'solid'
	--				relative = "editor", -- 'editor' or 'win'
	--				title = "🤖 AI Assistant",
	--				zindex = 100, -- Ensure window stays on top
	--			},

	--			-- headers = {
	--			-- 	user = "👤 You",
	--			-- 	assistant = "🤖 Copilot",
	--			-- 	tool = "🔧 Tool",
	--			-- },

	--			separator = "━━",
	--			auto_fold = true, -- Automatically folds non-assistant messages
	--			question_header = "👤 You",
	--			answer_header = "🤖 Copilot",
	--			-- window = {
	--			--   width = 0.4,
	--			-- },
	--		}
	--	end,
	--	keys = {
	--		{ "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
	--		{ "<leader>c", "", desc = "+ai", mode = { "n", "v" } },
	--		{
	--			"<leader>cc",
	--			function()
	--				return require("CopilotChat").toggle()
	--			end,
	--			desc = "Toggle (CopilotChat)",
	--			mode = { "n", "v" },
	--		},
	--		{
	--			"<leader>cv",
	--			function()
	--				require("CopilotChat").open({ window = { layout = "vertical" } })
	--			end,
	--			desc = "Copilot Chat vertical split",
	--		},
	--		{ "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Explain code" },
	--		{ "<leader>cf", "<cmd>CopilotChatFix<CR>", desc = "Fix code issues" },
	--		{ "<leader>ct", "<cmd>CopilotChatTests<CR>", desc = "Generate tests" },
	--	},
	--	config = function(_, opts)
	--		local chat = require("CopilotChat")
	--		-- vim.g.copilot_no_tab_map = true
	--		vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })

	--		chat.setup(opts)
	--		-- config = function()
	--	end,

	--	-- vim.g.copilot_no_tab_map = true
	--	--vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
	--	--end,
	--	-- See Commands section for default commands if you want to lazy load on them
	--},
}
