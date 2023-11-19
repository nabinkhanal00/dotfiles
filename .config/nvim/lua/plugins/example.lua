return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},

	-- change trouble config
	{
		"folke/trouble.nvim",
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},

	-- add symbols-outline
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		config = true,
	},

	-- Use <tab> for completion and snippets (supertab)
	-- first: disable default <tab> and <s-tab> behavior in LuaSnip
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
	-- then: setup supertab in cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")
			-- cmp.setup({ completion = { autocomplete = false } })
			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- this way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = false,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		},
	},
	{
		"TobinPalmer/pastify.nvim",
		cmd = { "Pastify" },
		config = function()
			require("pastify").setup({
				opts = {
					absolute_path = false,
					apikey = "",
					local_path = "/attatchments/",
					save = "local",
				},
			})
		end,
	},
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		config = function()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		"hkupty/iron.nvim",
		ft = "python",
		config = function(plugins, opts)
			local iron = require("iron.core")

			iron.setup({
				config = {
					-- Whether a repl should be discarded or not
					scratch_repl = true,
					-- Your repl definitions come here
					repl_definition = {
						python = {
							-- Can be a table or a function that
							-- returns a table (see below)
							command = { "python" },
						},
					},
					-- How the repl window will be displayed
					-- See below for more information
					repl_open_cmd = require("iron.view").right(60),
				},
				-- Iron doesn't set keymaps by default anymore.
				-- You can set them here or manually add keymaps to the functions in iron.core
				keymaps = {
					send_motion = "<space>rc",
					visual_send = "<space>rc",
					send_file = "<space>rf",
					send_line = "<space>rl",
					send_mark = "<space>rm",
					mark_motion = "<space>rmc",
					mark_visual = "<space>rmc",
					remove_mark = "<space>rmd",
					cr = "<space>r<cr>",
					interrupt = "<space>r<space>",
					exit = "<space>rq",
					clear = "<space>rx",
				},
				-- If the highlight is on, you can change how it looks
				-- For the available options, check nvim_set_hl
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			})

			-- iron also has a list of commands, see :h iron-commands for all available commands
			vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
			vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
			vim.keymap.set("n", "<space>rF", "<cmd>IronFocus<cr>")
			vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = { theme = "palenight" },
	},
	{
		"akinsho/bufferline.nvim",
		opts = { highlights = require("catppuccin.groups.integrations.bufferline").get() },
	},
}
