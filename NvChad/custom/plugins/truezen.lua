local present, truezen = pcall(require, "true-zen")

if not present then
  return
end

local options = {
  ui = {
    bottom = {
      laststatus = 0,
      ruler = false,
      showmode = true,
      cmdheight = 1,
    },
    top = {
      showtabline = 0,
    },
    left = {
      number = false,
    },
  },
  modes = {
    ataraxis = {
      left_padding = 3,
      right_padding = 3,
      top_padding = 1,
      bottom_padding = 0,
      auto_padding = false,
    },
  },
}

truezen.setup(options)
