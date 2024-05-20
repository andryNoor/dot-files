local opt = vim.opt
local g = vim.g

if g.neovide then
  -- lvim specific configs for Neovide
  lvim.colorscheme = 'synthweave-transparent' -- set colorscheme
  lvim.builtin.lualine.options.theme = 'auto'
  -- lvim.builtin.lualine.options.theme = 'material'
  -- lvim.builtin.lualine.options.theme = 'synthweave'

  opt.guifont = "CaskaydiaCove Nerd Font Propo:h10"
  -- g.transparency = 0.68
  -- g.neovide_theme = "auto"
  g.neovide_hide_mouse_when_typing = true
  g.neovide_underline_automatic_scaling = true
  g.neovide_transparency = 0.80
  g.neovide_floating_blur_amount_x = 2.0
  g.neovide_floating_blur_amount_y = 2.0
  g.neovide_refresh_rate = 60
  g.neovide_refresh_rate_idle = 5
  g.neovide_no_idle = false
  g.neovide_cursor_antialiasing = true
  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_animate_command_line = true
  g.neovide_cursor_unfocused_outline_width = 0.125
  g.neovide_cursor_vfx_mode = "ripple"
  g.neovide_cursor_trail_size = 0.7
  g.neovide_cursor_animation_length = 0.10
  g.neovide_scroll_animation_length = 0.3
  g.neovide_unlink_border_highlights = true -- fix border and winbar scrolling glitches
end
