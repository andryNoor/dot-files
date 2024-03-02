---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

M.theme = {
  n = {
    ["<leader>tt"] = {
      function()
        require("base46").toggle_theme()
      end,
      "toggle theme [dark|light]",
    },

    ["<leader>tr"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },
  },
  v = {
    ["<leader>tt"] = {
      function()
        require("base46").toggle_theme()
      end,
      "toggle theme [dark|light]",
    },

    ["<leader>tr"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },
  },
}

M.tabufline = {
  n = {
    ["<leader><tab>"] = {
      function()
        require("nvchad.tabufline").move_buf(1)
      end,
      "arraange buffer (move right)",
    },

    ["<leader><S-tab>"] = {
      function()
        require("nvchad.tabufline").move_buf(-1)
      end,
      "arraange buffer (move left)",
    },

    ["<leader>wc"] = {
      function()
        require("nvchad.tabufline").closeAllBufs()
      end,
      "close all buffer",
    },
  },
}

return M
