return {
	"pysan3/fcitx5.nvim",
	config = function()
		require("fcitx5").setup({
			-- This ensures that leaving Insert mode always turns off IME
			en_setup = true,
		})
	end,
}
