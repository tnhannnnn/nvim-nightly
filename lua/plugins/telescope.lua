vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
})
require("telescope").load_extension("ui-select")
require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			"%.git/",
			"dist",
			"build",
			"%.lock",
			"%.obsidian/",
		},
	},
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
-- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
