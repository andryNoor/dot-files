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
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 5,
			right_padding = 3,
			top_padding = 2,
			bottom_padding = 2,
			auto_padding = false,
		},
	},

  integrations = {
    limelight = true,
  },
}

truezen.setup(options)
