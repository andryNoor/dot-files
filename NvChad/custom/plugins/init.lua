-- custom/plugins/init.lua

return {

  ["elkowar/yuck.vim"] = { ft = "yuck" },

  -- ["NvChad/nvterm"] = {
    -- config = function()
      -- require "plugins.configs.nvterm"
      -- end,
      -- },

      -- User Themes (Pluigns)
      ["mangeshrex/everblush.vim"] = {
        config = function()
          require("custom.plugins.configs.user.everblush")
        end,
      },

      ---[[
      -- PLUGIN STUFF FROM Siduck

      -- autoclose tags in html, jsx, etc
      ["windwp/nvim-ts-autotag"] = {
        ft = { "html", "javascriptreact" },
        after = "nvim-treesitter",
        config = function ()
          require("custom.plugins.smolconfigs").autotag()
        end,
      },

      -- format & linting
      ["jose-elias-alvarez/null-ls.nvim"] = {
        after = "nvim-lspconfig",
        config = function()
          require "custom.plugins.null-ls"
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
          require "custom.plugins.truezen"
        end,
      },

      -- get highlight group under cursor
      ["nvim-treesitter/playground"] = {
        cmd = "TSCaptureUnderCursor",
        config = function()
          require("nvim-treesitter.configs").setup()
        end,
      },

      -- AutoSave
      ["Pocco81/AutoSave.nvim"] = {
        module = "autosave",
        config = function()
          require("custom.plugins.smolconfigs").autosave()
        end,
      },
      -- ]]
    }
