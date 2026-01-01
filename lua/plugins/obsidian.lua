local function set_rm_checkbox_hl()
	vim.api.nvim_set_hl(0, "RMCheckboxTodo", { fg = "#89b4fa" })
	vim.api.nvim_set_hl(0, "RMCheckboxDeferred", { fg = "#f9e2af" })
	vim.api.nvim_set_hl(0, "RMCheckboxImportant", { fg = "#f38ba8" })
	vim.api.nvim_set_hl(0, "RMCheckboxProgress", { fg = "#94e2d5" })
	vim.api.nvim_set_hl(0, "RMCheckboxDone", { fg = "#a6e3a1" })
end

-- set ngay lần đầu
set_rm_checkbox_hl()

-- set lại khi đổi theme
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_rm_checkbox_hl,
})

vim.pack.add({
	{
		src = "https://github.com/obsidian-nvim/obsidian.nvim",
		version = vim.version.range("*"), -- use latest release, remove to use latest commit
	},
	{
		src = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
	},
})

require("render-markdown").setup({
	checkbox = {
		enabled = true,
		custom = {
			tilde = {
				raw = "[~]",
				rendered = "󰰱 ",
				highlight = "RMCheckboxDeferred",
				scope_highlight = nil,
			},

			important = {
				raw = "[!]",
				rendered = " ",
				highlight = "RMCheckboxImportant",
				scope_highlight = nil,
			},

			right_arrow = {
				raw = "[>]",
				rendered = " ",
				highlight = "RMCheckboxProgress",
				scope_highlight = nil,
			},
		},
	},
})
require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "personal",
			path = "~/Documents/note",
		},
	},
	footer = {
		enabled = false,
	},

	statusline = {
		enabled = false,
	},

	ui = {
		enable = false,
		ignore_conceal_warn = true,
	},

	checkbox = {
		enabled = true,
		create_new = true,
		order = { " ", "!", ">", "x" },
	},

	templates = {
		folder = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
	},
	note_id_func = function(title)
		if title == nil then
			return tostring(os.time())
		end
		return title:gsub(" ", "-"):gsub("\\[\\^A-Za-z0-9-\\]", ""):lower()
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

map("n", "<leader>on", "<cmd>Obsidian new_from_template<CR>", { desc = "New note" })
map("n", "<leader>ot", "<cmd>Obsidian today<CR>", { desc = "Today" })
map("n", "<leader>od", "<cmd>Obsidian dailies<CR>", { desc = "Daily" })
map("n", "<leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "Open note" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Backlinks" })
map("n", "<leader>os", "<cmd>Obsidian tags<CR>", { desc = "Search for tags" })
map("n", "<leader>or", "<cmd>Obsidian rename<CR>", { desc = "Rename" })
map("n", "<leader>gf", "<cmd>Obsidian follow_link<CR>", { desc = "Follow link" })
map("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<CR>", { desc = "Toggle checkbox" })
