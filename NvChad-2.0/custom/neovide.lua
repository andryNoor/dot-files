local opt = vim.opt
local g = vim.g

if g.neovide then
	opt.guifont = "CaskaydiaCove Nerd Font Propo:h12"
  g.neovide_transparency = 0.8
  g.neovide_floating_blur_amount_x = 2.0
  g.neovide_floating_blur_amount_y = 2.0
  g.neovide_hide_mouse_when_typing = true
  g.neovide_underline_automatic_scaling = true
  g.neovide_refresh_rate = 60
  g.neovide_refresh_rate_idle = 5
  g.neovide_no_idle = false
  g.neovide_cursor_antialiasing = true
  g.neovide_cursor_vfx_mode = "ripple"
  g.neovide_cursor_trail_size = 0.7
  g.neovide_cursor_animation_length = 0.10
  g.neovide_scroll_animation_length = 0.3
end
