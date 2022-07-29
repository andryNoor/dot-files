-- "mangeshrex/everblush.vim" theme config
local M = {}

M.everblush = {
  -- Color Highlight
  -- vim.g.everblushNR = 1, -- enable (default)
  --vim.g.everblushNR = 0, -- disable
  require("everblush").setup({
    nvim_tree = {
      contrast = true,
    },
  })

}

return M
