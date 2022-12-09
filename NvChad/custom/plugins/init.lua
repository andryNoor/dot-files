-- custom/plugins/init.lua

return {

	["elkowar/yuck.vim"] = { ft = "yuck" },

	-- ["NvChad/nvterm"] = {
	-- config = function()
	-- require "plugins.configs.nvterm"
	-- end,
	-- },

	-- User Themes (Pluigns)
	-- ["Everblush/everblush.nvim"] = {
	-- 	config = function()
	-- 		require("custom.plugins.configs.user.everblush")
	-- 	end,
	-- },

	-- nvim-cursorline (delay cursorline/phasing)
	["yamatsum/nvim-cursorline"] = {
		setup = function()
			require("core.lazy_load").on_file_open("nvim-cursorline")
		end,
		config = function()
			require("custom.plugins.configs.user.nvim-cursorline")
		end,
	},

	-- Limelight
	["junegunn/limelight.vim"] = {
		vim.cmd("let g:limelight_conceal_guifg = '#777777'"),
	},

	-- Neoscroll (smooth scrolling)
	["karb94/neoscroll.nvim"] = {
		config = function()
			require("custom.plugins.configs.user.neoscroll")
		end,
	},

	-- suda.vim (Read or Write file with 'sudo')
	["lambdalisue/suda.vim"] = {
		vim.cmd("let g:suda#prompt = 'JNET::suda -> [sudo] password: '"),
	},

	-- Override Tabufline (Nvchad/ui)
	["NvChad/ui"] = {
		tabufline = {
			lazyload = true,
		},
	},

	-- Override whichkey [re-enabled] (Reason: disabled by default)
	["folke/which-key.nvim"] = {
		disable = false,
	},

	---[[
	-- PLUGIN STUFF FROM Siduck

	-- autoclose tags in html, jsx, etc
	["windwp/nvim-ts-autotag"] = {
		ft = { "html", "javascriptreact" },
		after = "nvim-treesitter",
		config = function()
			require("custom.plugins.smolconfigs").autotag()
		end,
	},

	-- format & linting
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	-- minimal modes
	["Pocco81/TrueZen.nvim"] = {
		cmd = {
			"TZAtaraxis",
			"TZMinimalist",
			"TZFocus",
		},
		config = function()
			require("custom.plugins.truezen")
		end,
	},

	-- Get highlight group under cursor
	["nvim-treesitter/playground"] = {
		cmd = "TSCaptureUnderCursor",
		config = function()
			require("nvim-treesitter.configs").setup()
		end,
	},

	-- AutoSave
	-- ["Pocco81/AutoSave.nvim"] = {
	-- 	module = "autosave",
	-- 	config = function()
	-- 		require("custom.plugins.smolconfigs").autosave()
	-- 	end,
	-- },

	-- Alpha/Init/Welcome screen
	["goolord/alpha-nvim"] = {
		disable = false,
		cmd = "Alpha",
	},

	-- lspconfig
	["neovim/nvim-lspconfig"] = {
		-- after = "flutter-tools.nvim",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},
	-- ]]

	---[[
	-- DEVELOPMENT OR PROGRAMMING SPECIFIC TOOLS

	-- Flutter Tools
	["akinsho/flutter-tools.nvim"] = {
		config = function()
			require("custom.plugins.configs.user.flutter-tools")
		end,
	},

  -- Code MiniMap
  ["echasnovski/mini.map"] = {
    config = function()
      require("custom.plugins.configs.user.minimap")
    end,
  },
	-- ]]
}
