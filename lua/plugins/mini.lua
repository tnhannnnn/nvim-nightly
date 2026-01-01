vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
})
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.pick").setup()
vim.ui.pick = require("mini.pick").pick
