require("options")
--plugin
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	{ src = "https://github.com/catppuccin/nvim", branch = "main" },
})
vim.cmd.colorscheme("catppuccin")
require("plugins.neotree")
require("plugins.format")
require("plugins.telescope")
require("plugins.completion")
require("plugins.mini")
require("plugins.obsidian")
require("mason").setup({})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath("config") .. "/lua",
				},
				maxPreload = 2000,
				preloadFileSize = 150,
			},
			semantic = {
				enable = false,
			},
		},
	},
})

vim.lsp.enable({ "lua_ls", "clangd", "ts_ls" })
require("nvim-treesitter")
	.install({
		"lua",
		"vim",
		"vimdoc",
		"c",
		"cpp",
		"html",
		"typescript",
		"tsx",
		"javascriptreact",
		"javascript",
		"python",
		"markdown",
	})
	:wait(300000)
vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

local severity = vim.diagnostic.severity
vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>o", "<cmd>lopen<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>lclose<CR>", { silent = true })
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.diagnostic.setloclist({ open = false })
	end,
})
vim.o.statusline = table.concat({
	" %{v:lua.require'statusline'.mode()} ",
	"| %f%m",
	"| %{v:lua.require'statusline'.git_branch()} ",
	"%=",
	"%{v:lua.require'statusline'.diagnostics()} ",
	"%l:%c ",
	"%p%% ",
})
