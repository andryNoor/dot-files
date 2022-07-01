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
}
