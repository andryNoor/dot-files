local M = {}
local override = require("custom.plugins.configs.override")

-- make sure you maintain the structure of `core/default_config.lua` here,

M.ui = {
	theme_toggle = { "chadracula", "tokyonight" },
	theme = "chadracula",
	-- theme = "onedark",
	-- theme = "nightowl",
	-- theme = "nightowl",
	-- theme = "nightowl",
	transparency = false,
	hl_override = require("custom.highlights").overriden_hlgroups,
}

M.plugins = {
	-- overriding default plugins option (NvChad's default/in-built plugins)
	override = {
		["kyazdani42/nvim-tree.lua"] = override.nvimtree,
		["nvimm-treesitter/nvim-treesitter"] = override.treesitter,
		["lukas-reineke/indent-blankline.nvim"] = override.blankline,
		["goolord/alpha-nvim"] = override.alpha,
	},

	--[[
  Note: To define custom "plugins' definition", configure it in 'custom/chadrc.lua'. See: https://nvchad.github.io/config/plugins [Modify plugin definition options] section.
  ]]

	-- user custom plugins
	user = require("custom.plugins"),

  -- remove
  -- remove = {
  --   "yamatsum/nvim-cursorline",
  -- },
}

M.mappings = require("custom.mappings")

-- vim.highlight.create("Comment", { cterm = "italic", gui = "italic" }, false)

return M
