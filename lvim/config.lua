----[[
--
--░█████╗░░█████╗░███╗░░██╗███████╗██╗░██████╗░░░░██╗░░░░░██╗░░░██╗░█████╗░
--██╔══██╗██╔══██╗████╗░██║██╔════╝██║██╔════╝░░░░██║░░░░░██║░░░██║██╔══██╗
--██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██║██║░░██╗░░░░██║░░░░░██║░░░██║███████║
--██║░░██╗██║░░██║██║╚████║██╔══╝░░██║██║░░╚██╗░░░██║░░░░░██║░░░██║██╔══██║
--╚█████╔╝╚█████╔╝██║░╚███║██║░░░░░██║╚██████╔╝██╗███████╗╚██████╔╝██║░░██║
--░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░░░░╚═╝░╚═════╝░╚═╝╚══════╝░╚═════╝░╚═╝░░╚═╝
--
-- LunarVim configuratin file

-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
----]]


--INFO: Enable powershell as your default shell
----------------------------------------------------
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}


--INFO: General options with autocommand
----------------------------------------------------
lvim.autocommands = {
  {
    { "BufEnter" },
    {
      pattern = "*",
      callback = function()
        -- Auto change directory based on buffer location. cmd: [set autochdir!] | [cd %:p:h]
        vim.o.autochdir = true
        vim.o.guifont = "CaskaydiaCove Nerd Font Propo:h10" -- Set guifont
        vim.o.termguicolors = true                          -- enable 24-bit RGB colors

        --[[ following xsiph dotfile on gitlab ]]
        vim.opt.lazyredraw = false  -- faster scrolling (if set to true) [suggest: false]
        vim.opt.hlsearch = false    -- remove highlighting after search
        vim.opt.wrap = false        -- line wrapping (if set to true)
        vim.opt.linebreak = true    -- don't split words
        vim.opt.scrolloff = 4       -- keep 4 rows buffer on screen edges
        vim.opt.colorcolumn = '120' -- line length marker at 80 columns
        vim.opt.synmaxcol = 240     -- max column for syntax highlight
      end,
    }
  },
  {
    { "VimEnter" },
    {
      callback = function()
        if lvim.colorscheme ~= 'tokyonight-day' and vim.o.background ~= 'light' then
          vim.schedule(function()
            vim.cmd('ToggleTransparentWindow')
          end)
        end
      end
    }
  }
}


--INFO: General User Function
----------------------------------------------------
--[[ Determine if Windows Terminal is currently in used ]]
-- NOTE: I use Windows Terminal and also HyperJS Terminal sometimes
-- Process Name under Windows (pwsh or cmd | parent process) is:
--  Windows Terminal: 'WindowsTerminal'
--  HyperJS Terminal: 'Hyper'
-- ------------------------------------
-- This function only detect whether WT_SESSION (Windows Terminal Env var) is set or not.
-- Sincse my lvim launch in cmd then in pwsh, its parent process would be 'cmd'
-- so we cannot rely on parent process.
-- --------------------------------------------------------------------------------------
-- returns: true or false or nil
local function is_windows_terminal()
  -- /* Check if WT_SESSION is set (using pwsh) */
  -- local handle = io.popen(
  -- 'pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "Write-Host $Env:WT_SESSION"')

  -- /* Check if WT_SESSION is set (using cmd) */
  local handle = io.popen('cmd /d /c echo %WT_SESSION%')

  if not handle then return end
  local wt_session = handle:read('*a')
  handle:close()
  -- print(wt_session) -- debuging purpose

  -- return wt_session:gsub('%s+', '') ~= '' -- return statement to be used if pwsh method is used
  return wt_session:gsub('%s+', '') ~= '%WT_SESSION%' -- return statement to be used if cmd method is used
end

--[[ Set _G.Bg_type values ]]
--NOTE:
-- It is used to help to determine the default colorscheme (theme)
-- If Windows Terminal is in used [Initial Theme: dark variant, else: light variant]
local function initialise_bg_type_vals() -- it is not the `vim.o.background`
  _G.Bg_type = { bg = 'dark', is_wt_checked = false, is_wt = true }

  -- Just to ensure `is_windows_terminal` runs only once
  if not _G.Bg_type.is_wt_checked then
    if not is_windows_terminal() then
      _G.Bg_type.bg = 'light'
      _G.Bg_type.is_wt = false
      vim.cmd('LvimReload')
    end
  end
  _G.Bg_type.is_wt_checked = true
end
vim.api.nvim_create_autocmd('VimEnter', {
  -- ensure the initialisation and Terminal check is only once
  -- (Performed after all initial config is done)
  callback = initialise_bg_type_vals
})

--[[ Neoscroll.nvim pre and post hook ]]
local function neoscroll_pre_hook() vim.opt.lazyredraw = true end
local function neoscroll_post_hook() vim.opt.lazyredraw = false end


--INFO: User plugins
----------------------------------------------------
lvim.plugins = {
  -- [[ Colorschemes ]]
  { "lunarvim/colorschemes" },
  { "samharju/synthweave.nvim" },    -- run :colorscheme synthweave or synthweave-transparent when feeling like it
  {
    "scottmckendry/cyberdream.nvim", -- A high-contrast, futuristic & vibrant theme for neovim with transparency in mind
    -- lazy = false,
    -- priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        -- transparent = true,
        italic_comments = true,
        hide_fillchars = false,
        borderless_telescope = false,
        terminal_colors = true,
      })
      -- vim.cmd("colorscheme cyberdream")   -- set the colorscheme
    end,
  },
  {
    "marko-cerovac/material.nvim",
    config = function()
      require('material').setup({

        contrast = {
          terminal = true,             -- Enable contrast for the built-in terminal
          sidebars = true,             -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false,    -- Enable contrast for floating windows
          cursor_line = true,          -- Enable darker background for the cursor line
          lsp_virtual_text = false,    -- Enable contrasted background for lsp virtual text
          non_current_windows = false, -- Enable contrasted background for non-current windows
          filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
        },

        styles = { -- Give comments style such as bold, italic, underline etc.
          comments = { italic = true },
          strings = { bold = true },
          keywords = { --[[ underline = true ]] },
          functions = { --[[ bold = true, undercurl = true ]] },
          variables = {},
          operators = {},
          types = {},
        },

        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          -- "coc"
          "dap",
          -- "dashboard",
          -- "eyeliner",
          -- "fidget",
          -- "flash",
          "gitsigns",
          -- "harpoon",
          -- "hop",
          -- "illuminate",
          "indent-blankline",
          -- "lspsaga",
          -- "mini",
          -- "neogit",
          "neotest",
          -- "neo-tree",
          -- "neorg",
          -- "noice",
          "nvim-cmp",
          "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          -- "rainbow-delimiters",
          -- "sneak",
          "telescope",
          -- "trouble",
          "which-key",
          -- "nvim-notify",
        },

        disable = {
          colored_cursor = true, -- Disable the colored cursor
          borders = false,       -- Disable borders between verticaly split windows
          background = false,    -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false,   -- Prevent the theme from setting terminal colors
          eob_lines = false      -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = true, -- Enable higher contrast text for lighter style
          darker = true   -- Enable higher contrast text for darker style
        },

        -- lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true,   -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_colors = nil,    -- If you want to override the default colors, set this to a function

        custom_highlights = {}, -- Overwrite highlights with your own
      })
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    -- priority = 1000,
    -- opts = {},
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "moon",         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",    -- The theme is used when the background is set to light
        transparent = false,    -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",              -- style for sidebars, see below
          floats = "dark",                -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true,              -- dims inactive windows
        lualine_bold = true,              -- When `true`, section headers in the lualine theme will be bold
      })
    end
  },

  -- [[ Others ]]
  { "mrjones2014/nvim-ts-rainbow" },
  {
    "norcalli/nvim-colorizer.lua", -- colour highlighter
    config = function()
      require("colorizer").setup({ "*", --[[ "css", "scss", "html", "javascript" ]] }, {
        RGB = true,         -- #RGB hex codes
        RRGGBB = true,      -- #RRGGBB hex codes
        RRGGBBAA = true,    -- #RRGGBBAA hex codes
        rgb_fn = true,      -- CSS rgb() and rgba() functions
        hsl_fn = true,      -- CSS hsl() and hsla() functions
        css = true,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = "background" -- Set the display mode
      })
    end,
  },
  {
    "rmagatti/goto-preview", -- previewing goto definition calls
    config = function()
      require('goto-preview').setup {
        width = 120,             -- Width of the floating window
        height = 25,             -- Height of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false,           -- Print debug information
        opacity = nil,           -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil     -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },
  {
    "ray-x/lsp_signature.nvim", -- hint when you type
    config = function()
      require "lsp_signature".setup({
      })
    end,
  },
  {
    "folke/todo-comments.nvim", -- highlight and search for to-do comments
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "karb94/neoscroll.nvim", -- smooth scrolling
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,              -- Hide cursor while scrolling
        stop_eof = true,                 -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false,     -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,       -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true,     -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = "sine",        -- Default easing function 'quintic'
        pre_hook = neoscroll_pre_hook,   -- Function to run before the scrolling animation starts
        post_hook = neoscroll_post_hook, -- Function to run after the scrolling animation ends
      })
    end
  },

  -- [[ Python specific ]]
  { "ChristianChiarulli/swenv.nvim" },
  { "stevearc/dressing.nvim" },
  { "mfussenegger/nvim-dap-python" },
  { "nvim-neotest/nvim-nio" },
  { "nvim-neotest/neotest" },
  { "nvim-neotest/neotest-python" },
}


--INFO: General configs
----------------------------------------------------
-- lvim.transparent_window = true
-- lvim.colorscheme = 'lunar' -- set colorscheme
-- lvim.builtin.lualine.options.theme = 'tokyonight'
if not vim.g.neovide then
  local background = vim.o.background                   -- background: dark || light
  local bubbles_theme = require "lualine_bubbles_theme" -- lualine custom theme
  local themes = { 'cyberdream', 'tokyonight-day' }
  local lualine_themes = { bubbles_theme, 'tokyonight' }
  local refresh_lualine = require "lvim.core.lualine".setup -- needed for reloading lualine
  -- [https://github.com/nvim-lualine/lualine.nvim/issues/310#issuecomment-899924926]

  --[[ Set colorscheme and lualine theme based on background type ]]
  --NOTE:
  -- Lvim configuration still needs to be reloaded (<leader>Lr) manually
  -- if background type (dark || light) is set manually (:set background=[value])
  -- otherwise lualine theme is not applied to current buffer.
  -- Lualine itself also needs to be reloaded
  -- otherwise its theme will not take effect

  lvim.colorscheme = background == (_G.Bg_type and _G.Bg_type.bg or 'dark') and themes[1] or themes[2]
  lvim.builtin.lualine.options.theme = background == (_G.Bg_type and _G.Bg_type.bg or 'dark') and lualine_themes[1] or
      lualine_themes[2]

  refresh_lualine()

  -- Configure the guicursor (blinking and so on)
  --[[ default (lvim): n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 ]]
  -- https://www.reddit.com/r/neovim/comments/105lqyc/how_do_i_change_the_cursor_colour_depending_on/
  vim.o.guicursor = "v:block,n-c-sm:block-blinkon175,i-ci-ve:ver25-blinkon175,r-cr-o:hor20-blinkon175"
end
require("neovide")          -- Neovide
vim.opt.fillchars = "eob: " -- Get rid of tilde '~' [EndOfBuffer]
lvim.builtin.treesitter.rainbow.enabled = true
lvim.builtin.cmp.formatting.duplicates.nvim_lsp = 1


-- TODO: Nvim background img (suggested by Gemini) [If possible in the future]
-- local base64_data = vim.fn.readfile("base64_grid_img.txt")
-- local base64_str = base64_data[1]
-- local temp_file = vim.fn.tempname()

-- vim.fn.writefile({ base64_str }, temp_file)
-- vim.g.background_image = temp_file
-- vim.g.background_image_color = '#007b7f'
-- vim.g.background_image_alpha = 100


--INFO: Lualine configs
----------------------------------------------------
local lv_lualine = lvim.builtin.lualine
local lv_icons_ui = require "lvim.icons".ui
local components = require("lvim.core.lualine.components")
-- lv_lualine.style = "lvim"

--[[ lualine custom functions ]]
local lualine_f = require_safe "lualine_f"

--[[ lualine section a ]]
lv_lualine.sections.lualine_a = {
  -- custom time component
  {
    lualine_f.time,
    color = lualine_f.color_f.time,
    icon = { lv_icons_ui.Table .. " ", align = 'left', color = { fg = '#79dac8', bg = '#080808', gui = 'inverse' } },
    separator = { left = '', --[[ right = '' ]] },
    padding = { left = 0, right = 1 },
    draw_empty = true,
    on_click = lualine_f.time
  },
  -- empty separator
  lualine_f.empty_separator,
  -- mode component
  {
    "mode",
    icon = { '󰀘 │', align = 'left', color = { fg = '#080808' } },
    separator = { left = '', right = '' },
    padding = { left = 0, right = 1 },
    fmt = function(str) return lualine_f.states.target_btn and str:sub(1, 1) or str end,
    on_click = lualine_f.float_term_toggle
    -- cond = function () return not lualine_f.states.target_btn end,
  }
}

--[[ lualine section b ]]
lv_lualine.sections.lualine_b = {
  -- fileformat component
  {
    "fileformat",
    on_click = lualine_f.new_buf
  },
  -- others component
  components.python_env,
  "searchcount",
  "selectioncount"
}

--[[ lualine section c ]]
lv_lualine.sections.lualine_c = {
  -- branch component
  components.branch,
  -- filename component
  {
    "filename",
    color = lualine_f.color_f.filename,
    on_click = lualine_f.print_filename
  }
}

--[[ lualine section y ]]
lv_lualine.sections.lualine_y = {
  -- custom cwd component
  {
    -- "" -> last used icon (from NvChad-ui)
    lualine_f.cwd,
    color = { fg = '#080808', bg = '#79dac8', gui = 'inverse' },
    icon = { lv_icons_ui.EmptyFolderOpen .. " ", align = 'left', color = { fg = '#79dac8', bg = '#080808', gui = 'inverse' } },
    separator = { left = '', --[[  right = '' ]] },
    padding = { left = 0, right = 1 },
    fmt = function(str)
      return (lualine_f.states.cwd or vim.bo.filetype == "NvimTree") and
          (function()
            local path_sep = package.config:sub(1, 1) -- default: '\' in Windows OS
            if vim.bo.filetype == "NvimTree" then
              lualine_f.states.cwd = true             -- keep it on
              return str .. path_sep .. ' [ ' .. vim.bo.filetype .. ' ]'
            else
              lualine_f.states.cwd = not lualine_f.states.cwd -- flip/reset the state
            end

            return str .. path_sep .. vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
          end
          )() --[[ return specified defined on func above ]] or str --[[ return default format ]]
      -- Purpose:
      -- to revert the state of this component
      -- based on `lualine_f.states.cwd` in 1000ms.
      -- lualine's options = { refresh = { statusline = 1000 } }
    end,
    on_click = lualine_f.cwd
  },
  -- location component
  {
    "location",
    padding = { left = 1, right = 1 },
  }
}

--[[ lualine section z ]]
lv_lualine.sections.lualine_z = {
  -- custom progress component
  {
    "%P/%L",
    icon = { '│', align = 'right', color = { fg = '#080808' } },
    separator = { left = '', right = '' },
    padding = { left = 0, right = 1 },
    -- on_click = lualine_f.nvtree
  }
}

--[[ lualine options ]]
lv_lualine.options.icons_enabled = true
lv_lualine.options.component_separators = { left = ' ▎', right = '' }
lv_lualine.options.section_separators = { left = '', right = '' }
-- lv_lualine.options.section_separators = { left = '', right = '' }
-- lv_lualine.options.section_separators = { left = '', right = '' }
-- lv_lualine.options.component_separators = { left = '|', right = '' }


--INFO: LSP configs [currently spesific for lsp_signature.nvim plugin only]
---------------------------------------------------------------------------
lvim.lsp.on_attach_callback = function(client, bufnr)
  require "lsp_signature".on_attach()
end


--INFO: Mapping [which_key] and override configs
----------------------------------------------------
local lv_wk = lvim.builtin.which_key
local lv_k = lvim.keys
local lv_term = lvim.builtin.terminal
local lv_lsp_bufmap = lvim.lsp.buffer_mappings

--[[ Options ]]
lv_wk.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 2000 } -- workaround for black (python null-ls code formatter)
  end, "Format"
}
lv_wk.setup.window.border = "double"
lv_wk.setup.plugins.marks = true
lv_wk.setup.plugins.registers = true
lv_wk.setup.plugins.presets.operators = true
require "which-key.plugins.presets".operators["v"] = nil
lv_wk.setup.plugins.presets.motions = true
lv_wk.setup.plugins.presets.g = true
lv_wk.setup.plugins.presets.z = true
lv_wk.setup.plugins.presets.windows = true
lv_wk.setup.plugins.presets.nav = true

--[[ User Defined Mappings ]]
lv_k.normal_mode["<Esc>"] = "<Esc><cmd>stopinsert<CR>"
lv_k.insert_mode["<Esc>"] = "<Esc><cmd>stopinsert<CR>"
lv_wk.mappings["x"] = { "<cmd>BufferKill<CR>", "Close Buffer" } -- Override default Lvim close buffer keymap (original: <space>c)
lv_wk.mappings["c"] = { "<cmd>set showcmd!<CR><cmd>echo 'showcmd!'<CR>", "Toggle Showcmd On Status" }
lv_wk.mappings["n"] = { "<cmd>set nu!<CR>", "Toggle Line Number" }
lv_wk.mappings["e"] = { "<cmd>cd %:p:h<CR><cmd>NvimTreeToggle<CR>", "Explorer" } -- cd first then toggle NvimTree [overrided from default Lvim map]
lv_wk.mappings["b"]["w"] = { "<cmd>enew<CR>", "Buffer new" }
lv_wk.mappings["b"][">"] = { "<cmd>BufferLineMoveNext<CR>", "Buffer move right" }
lv_wk.mappings["b"]["<lt>"] = { "<cmd>BufferLineMovePrev<CR>", "Buffer move left" }
lv_wk.mappings["E"] = { "<cmd>NvimTreeFindFile<CR>", "Explorer Focus Current Buffer" }
lv_wk.mappings["F"] = { "<cmd>lua =vim.api.nvim_buf_get_name(0)<CR><cmd>let @\" = expand('%:p')<CR>",
  "Print & Yank Current Buffer Path" }
lv_wk.mappings["G"] = { "<cmd>lua =vim.fn.getcwd()<CR><cmd>let @\" = getcwd()<CR>",
  "Print & Yank Current Buffer Location" }

--[[ User Defined Mappings: Window Appearance ]]
local user_cmd = vim.api.nvim_create_user_command

-- Command to toggle `background` [ 'dark' || 'light' ]
user_cmd('ToggleBackgroundType', function()
  -- Flip background type
  vim.o.background = (vim.o.background == 'dark' and 'light' or 'dark')
  vim.cmd('LvimReload')

  -- Automatically invoke transparency if appropriate
  -- (Sheduled before LvimReload and run after LvimReload)
  vim.schedule(function()
    if _G.Bg_type.is_wt_checked and _G.Bg_type.is_wt
        and vim.o.background == 'dark'
        and lvim.colorscheme ~= 'tokyonight-day' then
      -- print('Entering (checking | toggling transparency) after reload. Theme:', lvim.colorscheme) -- debugin purpose
      -- print('g.colors_name:', vim.g.colors_name) -- debugging purpose
      vim.cmd('ToggleTransparentWindow')
    end
  end)
end, { desc = 'Command for toggling background type between "dark" and "light"' })
lv_wk.mappings["L"]["s"] = { "<cmd>ToggleBackgroundType<CR>", "Toggle Theme" }

-- Toggle Transparent Window
vim.schedule(function()
  -- Ensure it is set only once to use for entire session
  if _G.Hl_groups then
    return
  end

  _G.Hl_groups = {
    Normal = '',
    SignColumn = '',
    NormalNC = '',
    TelescopeBorder = '',
    NvimTreeNormal = '',
    NvimTreeNormalNC = '',
    EndOfBuffer = '',
    MsgArea = '',
  }
end)

-- NOTE:
-- Scenario: Initial window is not transparent (lvim.transparent_window is not being set/used)
-- otherwise this functionality serve no purpose.
-- In other words please do not use lvim.transparent_window
user_cmd("ToggleTransparentWindow", function(opts)
  local function toggle_transparency()
    --[[ Takes default (non-None) values of current hl_name (group) from active colorscheme ]]
    for hl_name, value in pairs(_G.Hl_groups) do
      -- local bg = vim.api.nvim_get_hl_by_name(hl_name, true).background -- Alternative way
      local bg = vim.api.nvim_get_hl(0, { name = hl_name }).bg

      if bg then
        _G.Hl_groups[hl_name] = string.format("#%06x", bg)                      -- convert colour to hex and save to hl_groups tbl as default
        vim.cmd(string.format("highlight %s ctermbg=none guibg=none", hl_name)) -- Set transparent
      elseif value ~= '' then
        vim.cmd(string.format("highlight %s guibg=%s", hl_name, value))         -- Revert to default
        _G.Hl_groups[hl_name] = ''
      end
    end
  end

  if opts.args == '' then
    toggle_transparency()
  elseif opts.args == 'confirm' then
    vim.ui.input({ prompt = 'Toggle Transparency (if appropriate)? ([y]es/no): ' }, function(confirm)
      -- Trim spaces and convert it to lowercase (if not nil)
      confirm = confirm ~= nil and confirm:gsub("^%s+", ""):gsub("%s+$", ""):lower() or nil

      if confirm == nil then
        return
      elseif confirm == '' or confirm == 'y'
          or (confirm:sub(1, 3) == 'yes' and confirm:sub(4) == '') then
        toggle_transparency()
      end
    end)
  end

  -- print('ToggleTransparentWindow is invoked') -- debugging purpose
  vim.opt.fillchars = "eob: " -- Get rid of tilde '~' [EndOfBuffer]
end, { nargs = '?', desc = 'Command for toggling Transparent Window' })
lv_wk.mappings["L"]["t"] = { "<cmd>ToggleTransparentWindow<CR>", "Toggle Transparency" }
lv_wk.mappings["L"]["r"] = { -- Override default mapping [<leader>Lr] :LvimReload
  -- NOTE: This overriden mapping invokes the scheduled ToggleTransparentWindow after invoked LvimReload
  "<cmd>LvimReload<CR><cmd>lua vim.schedule(function() vim.cmd('ToggleTransparentWindow confirm') end)<CR>",
  "Reload LunarVim's configuration"
}

-- Show or Hide virtual_text (diagnostic)
user_cmd("ShowDiagnosticHint", function(opts)
  local _opts = (opts.args == 'true')               -- '' or true considered `true` | else is `false`
  local _set = vim.diagnostic.config().virtual_text -- used for toggling functionality

  vim.diagnostic.config({ virtual_text = (opts.args == '') and not _set or _opts })
end, { nargs = '?', desc = 'Toggle vim diagnostic virtual_text (Hint)' })
lv_wk.mappings["l"]["h"] = { "<cmd>ShowDiagnosticHint<CR>", "Toggle Diagnostic Hint" }

-- TODO: Customise Diagnostic Highlight Group (virtual_text)
-- NOTE: This highlight colour should blend to its bg colour (fg 70% alpha; bg 30% alpha).
-- Todo it we should convert its default (current related colorscheme hl):
-- from raw interger colour -> hex colour -> rgb then convert it back to hex colour
-- and apply it.
-- -----
-- Use the rgb colour and calculate what the colour value (hex) should be.
-- DiagnosticVirtualTextError
-- DiagnosticVirtualTextWarn
-- DiagnosticVirtualTextInfo
-- DiagnosticVirtualTextHint
-- DiagnosticVirtualTextOk

--[[ User Defined Mappings: Movement ]]
lv_k.normal_mode["<C-A-l>"] = '<cmd>nohlsearch<CR><Esc>gg"_dG<cmd>stopinsert<CR>' -- Clear highlights, clear screen
lv_k.insert_mode["<C-l>"] = "<Right>"
lv_k.insert_mode["<C-k>"] = "<Up>"

--[[ General LSP Mappings | <leader>l and also `g` ]]
if vim.lsp.buf.range_code_action then
  lv_wk.mappings["l"]["a"] = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Action" }
end
lv_lsp_bufmap.normal_mode["go"] = { vim.lsp.buf.type_definition, "Goto type definition" }
lv_lsp_bufmap.normal_mode["gL"] = { vim.diagnostic.open_float, "Show diagnostic in hover" }
lv_wk.mappings["l"]["W"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder" }
lv_wk.mappings["l"]["R"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()", "Remove Workspace Folder" }
lv_wk.mappings["l"]["L"] = { "<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>", "List Workspace Folders" }

--[[ Remap Terminal ]]
lv_term.open_mapping = [[<M-Bslash>]]
lv_term.shading_factor = 1
lv_k.term_mode["<C-x>"] = "<C-\\><C-N>" -- Esc terminal mode insert
-- See (for default) -> C:\Users\mnoor\AppData\Roaming\lunarvim\lvim\lua\lvim\keymappings.lua
lv_k.term_mode["<C-h>"] = false
lv_k.term_mode["<C-j>"] = false
lv_k.term_mode["<C-k>"] = false
lv_k.term_mode["<C-l>"] = false

--[[ Gitsigns Mapping ]]
-- Alternative keymap for <space>gj and <space>gk of Gitsigns hunk (configured by Lvim)
lv_k.normal_mode["[c"] = "<cmd>lua require 'gitsigns'.prev_hunk({ navigation_message = false })<CR>" -- "Prev Hunk"
lv_k.normal_mode["]c"] = "<cmd>lua require 'gitsigns'.next_hunk({ navigation_message = false })<CR>" -- "Next Hunk"

--[[ Todo-Comments Mapping ]]
lv_k.normal_mode["[t"] = "<cmd>lua require('todo-comments').jump_prev()<CR>"
lv_k.normal_mode["]t"] = "<cmd>lua require('todo-comments').jump_next()<CR>"

--[[ Lvim builtin (nvim-cmp) Mapping [Override some] ]]
vim.schedule(function()
  if not lvim.builtin.cmp.mapping['<C-J>']['i'] then
    -- ensure overriden all keys including this key only once for entire Nvim session
    return
  end

  local cmp_mapping_overriden_keymaps = {
    "<c-j>", -- Lvim Default: Select next completion {insert and command}
    "<c-k>", -- Lvim Default: Select prev completion {insert and command}
    "<tab>", -- Lvim Default: Select next completion if_visible or jumpable(1) {insert and select mode}
    -- "<s-tab>", -- Lvim Default: Select prev completion if_visible or jumpable(-1) {insert and select mode}
    -- "<c-d>",   -- Lvim Default: Scroll docs up (-4)
    -- "<c-f>",   -- Lvim Default: Scroll docs down (4)
  }

  local cmp = require("lvim.utils.modules").require_on_index "cmp"
  local cmp_mapping = require "cmp.config.mapping"
  local cmp_mapping_tbl = lvim.builtin.cmp.mapping
  local luasnip = require("lvim.utils.modules").require_on_index "luasnip"
  local jumpable = require("lvim.core.cmp").methods.jumpable
  local has_words_before = require("lvim.core.cmp").methods.has_words_before

  for keymap, _ in pairs(cmp_mapping_tbl) do
    if vim.tbl_contains(cmp_mapping_overriden_keymaps, keymap:lower()) then
      if keymap:lower() == '<tab>' then
        cmp_mapping_tbl[keymap] = cmp_mapping(function(fallback)
          if cmp.visible() then
            -- print('entering close if visible')
            cmp.close()
            if jumpable(1) then
              -- print('entering close if visible - jumpable')
              luasnip.jump(1)
            else
              -- print('entering close if visible - else - fallback')
              fallback()
            end
          elseif luasnip.expand_or_locally_jumpable() then
            -- print('entering expand and jump')
            -- WARN: We need to jump with this first--DO NOT REMOVE IT.
            -- I do not know the exact reason why. But it seems we need to do initial jump first
            -- (even though it is not noticeable visually)
            luasnip.jump(1) -- this is the key for smooth jumpable snippet | completion movement

            -- Actual jumping actions
            if has_words_before() and not cmp.visible() then
              -- print('entering expand or jump - has words before - fallback')
              -- luasnip.expand_or_jump() -- use this for default behaviour (expand snippet when hitting tab and cmp is not visible)
              fallback() -- use this instead if you don't want snippet expanding default behaviour
            else
              -- print('entering expand or jump - else - expand_or_jump')
              luasnip.expand_or_jump()
            end
          elseif jumpable(1) then
            -- print('entering jump only')
            luasnip.jump(1)
          elseif has_words_before() then
            -- print('entering has words before')
            fallback()
          else
            -- print('entering else')
            fallback()
          end
        end, { "i", "s" })
      else
        -- Removes <c-j> and <c-k> insert
        cmp_mapping_tbl[keymap]['i'] = nil
      end
    end
  end
end)

--[[ Lualine Components Mapping ]]
lv_wk.mappings["L"]["h"] = { "<cmd>lua require_safe 'lualine_f'.time(1, 'l')<CR>", "Toggle Time" }               -- lualine_f.time toggle
lv_wk.mappings["L"]["H"] = { "<cmd>lua require_safe 'lualine_f'.time(1, 'l', 'a')<CR>", "Toggle Date and Time" } -- lualine_f.time toggle (long dt fmt)

-- NOTE: [Start]
--------------------------------------------------------------------------------------
-- Only for manual debuging purpose of `lualine_f` when doing its configurations;
-- why?: because I need to temporarily move all `lualine_f` elements here from its
-- separate module under `lua/lualine_f`. It seems LunarVim cannot include my changes
-- there without restarting NVim especially while experimenting with my custom funcs
-- for `on_click` of lualine option, it's not the case when
-- `lualine_f` is written here directly. [config.lua];
-- lualine_f.time(1, 'l') -- hide/undhide datetime component
-- lualine_f.time(1, 'l', 'a') -- toggle datetime format (time or datetime)
-- NOTE: [End]
-- If there's no more lualine_f specific codes (or commented) between this
-- 'NOTE' Start and 'NOTE' End, it means the debugging process considered Done.
-- Mainly we can use lualine functionality and its stuff as expected (with lualine_f).
-- Actually there's nothing too fancy, I am just adding `Time` component along with
-- other lualine Components and Events.
--------------------------------------------------------------------------------------


--INFO: Language [Programming] specific configurations
------------------------------------------------------
local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"
-- local codeActions = require "lvim.lsp.null-ls.code_actions"
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 3000
lvim.format_on_save.pattern = { "*.py" }
lvim.builtin.treesitter.ensure_installed = { "python", "elixir", "heex" } -- automatically install {Languages} syntax highlighting
lvim.lsp.installer.setup.ensure_installed = { "cssls", "tsserver", "tailwindcss", "elixirls" }

-- [[ Python ]]
-- setup formatting
formatters.setup { { name = "black", filetypes = { "python" } } }

-- setup linting
linters.setup { { command = "flake8", filetypes = { "python" } } }

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

-- setup mappings
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

-- [[ End of Python ]]

--[[ Powershell ]]
require("powershell_treesitter") -- unmaintained parser for treesitter (syntax highlighting for powershell)
--[[ End of Powershell ]]

--[[ Dart ]]
require("lspconfig").dartls.setup {} -- Dart lsp [https://github.com/LunarVim/LunarVim/issues/3919]
--[[ End of Dart ]]

--[[ Elixir ]]
-- Features: Basic Elixir configuration with TailwindCSS support for Phoenix projects
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" })
local opts = {
  root_dir = function(fname)
    local util = require "lspconfig/util"
    return util.root_pattern("assets/tailwind.config.js", "tailwind.config.js", "tailwind.config.cjs", "tailwind.js",
      "tailwind.cjs")(fname)
  end,
  init_options = {
    userLanguages = { heex = "html", elixir = "html" }
  },
}
require("lvim.lsp.manager").setup("tailwindcss", opts)

--[[ End of Elixir ]]
