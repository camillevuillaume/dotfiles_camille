return {
	-- Add LuaSnip and its cmp source link
	{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },

	{
		"hrsh7th/nvim-cmp",
		-- Tell lazy.nvim to make sure these load before cmp does
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Load VSCode style snippets (like friendly-snippets if you use it)
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					REQUIRED = true,
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-CR>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
