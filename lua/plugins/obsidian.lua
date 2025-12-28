vim.pack.add({
	{
		src = "https://github.com/obsidian-nvim/obsidian.nvim",
		version = vim.version.range("*"), -- use latest release, remove to use latest commit
	},
	{
		src = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
	},
})
require("render-markdown").setup()
require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "personal",
			path = "~/Documents/note",
		},
	},
	footer = {
		enabled = true,
	},

	statusline = {
		enabled = false,
	},

	ui = {
		enable = true,
		ignore_conceal_warn = true,
	},

	checkbox = {
		enabled = true,
		create_new = true,
		order = { " ", "~", "!", ">", "x" },
	},

	templates = {
		folder = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
	},
	note_id_func = function(title)
		if title ~= nil and title ~= "" then
			-- normalize title → filename
			return title:gsub("%s+", "-"):gsub("[^%w%-]", ""):lower()
		end

		return os.date("%Y%m%d%H%M%S")
	end,

	daily_notes = {
		folder = "daily",
		date_format = "%Y-%m-%d",
		template = "daily.md",
		default_tags = { "daily-notes" },
		workdays_only = false,
	},
})

local map = vim.keymap.set

map("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "New note" })
map("n", "<leader>ot", "<cmd>Obsidian today<CR>", { desc = "Today" })
map("n", "<leader>od", "<cmd>Obsidian dailies<CR>", { desc = "Daily" })
map("n", "<leader>oo", "<cmd>Obsidian quick_switch<CR>", { desc = "Open note" })
map("n", "<leader>gf", "<cmd>Obsidian follow_link<CR>", { desc = "Backlinks" })
