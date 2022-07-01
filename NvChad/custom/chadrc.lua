local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,

M.ui = {
  theme = "tokyonight",
  -- theme = "everblush",
  transparency = true,
}

M.plugins = {
  user = require("custom.plugins")
}

return M
