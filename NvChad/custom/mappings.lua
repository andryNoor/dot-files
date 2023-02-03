local M = {}

-- M.lspconfig = {
-- 	n = {
-- 		-- Temporarily set this until getting fix by the next update of NvChad (mapping)
-- 		["<leader>fm"] = {
-- 			function()
-- 				vim.lsp.buf.format({ async = true }) -- reason: due to vim.lsp.buf.formatting({}) is deprecated
-- 			end,
-- 			"lsp formatting",
-- 		},
-- 	},
-- }

M.truzen = {
	n = {
		["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
		["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
		["<leader>tf"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
	},
}

M.treesitter = {
	n = {
		["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "  find media" },
	},
}

-- M.shade = {
--   n = {
--     ["<leader>s"] = {
--       function()
--         require("shade").toggle()
--       end,
--
--       "   toggle shade.nvim",
--     },
--
--     ["<leader>lz"] = {
--       function()
--         require("nvterm.terminal").send("lazygit", "vertical")
--       end,
--       "nvterm lazygit",
--     },
--   },
-- }

M.comment = {
	-- toggle comment in both modes
	n = {
		-- Ctrl-/
		["<C-_>"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"蘒  toggle comment",
		},
	},

	v = {
		-- Ctrl-/
		["<C-_>"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"蘒  toggle comment",
		},
	},
}

M.togglecursor = {
	n = {
		["<space>cl"] = {
			"<ESC><cmd>set cursorline!<CR>",
			"蘒 toggle cursorline",
		},

		["<space>ck"] = {
			"<ESC><cmd>highlight clear CursorLine<CR>",
			"蘒 hi clear CursorLine",
		},

		["<space>ch"] = {
			"<ESC><cmd>HiCursorLine<CR><ESC><cmd>highlight Comment cterm=italic gui=italic<CR><ESC><cmd>HiLSPgui<CR><ESC><cmd>HiTSgui<CR>",
			"蘒 hi CurL, Comm, LSP & TS gui (force)",
		},

		["<space>cc"] = {
			"<ESC><cmd>set cursorcolumn!<CR>",
			"蘒 toggle cursorcolumn",
		},
	},
}

M.nvterm = {
	t = {
		-- toggle in terminal mode
		["<A-f>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"   toggle floating term",
		},
	},

	n = {
		-- toggle in normal mode
		["<A-f>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"   toggle floating term",
		},
	},
}

M.minimap = {
	n = {
		-- close minimap
		["<leader>mc"] = {
			"<ESC><cmd>lua MiniMap.close()<CR>",
			"   close minimap",
		},

		-- toggle focus
		["<leader>mf"] = {
			"<ESC><cmd>lua MiniMap.toggle_focus()<CR>",
			"   toggle focus minimap",
		},

		-- open minimap
		["<leader>mo"] = {
			"<ESC><cmd>lua MiniMap.open()<CR>",
			"   open minimap",
		},

		-- refresh minimap
		["<leader>mr"] = {
			"<ESC><cmd>lua MiniMap.refresh()<CR>",
			"   refresh minimap",
		},

		-- toggle side
		["<leader>ms"] = {
			"<ESC><cmd>lua MiniMap.toggle_side()<CR>",
			"   toggle side minimap",
		},

		-- toggle minimap
		["<leader>mt"] = {
			"<ESC><cmd>lua MiniMap.toggle()<CR>",
			"   toggle minimap",
		},
	},
}

M.general = {
	n = {
		-- Temporarily set this until getting fix by the next update of NvChad (mapping)
		-- formatting code
		["<leader>fm"] = {
			function()
				vim.lsp.buf.format({ async = true }) -- reason: due to vim.lsp.buf.formatting({}) is deprecated
			end,
			"lsp formatting",
		},
		-- toggle transparency
		["<leader>tr"] = {
			function()
				require("base46").toggle_transparency()
			end,
			"   toggle transparency",
		},

		-- clear search hl + refresh minimap hl
		["<ESC>"] = { "<cmd> noh <CR><cmd>lua MiniMap.refresh()<CR>", "no highlight" },
	},
}

-- note: just fix the mis-place name/description of this shortcut ('goto next' and 'goto prev')
-- will remove this override if it got fixed in the next update of NvChad
-- M.tabufline = {
--   n = {
--     -- cycle through tabs
--     ["<leader>tp"] = { "<cmd> tabprevious <CR>", "  goto prev tab" },
--     ["<leader>tn"] = { "<cmd> tabnext <CR> ", "  goto next tab" },
--   },
-- }

return M
