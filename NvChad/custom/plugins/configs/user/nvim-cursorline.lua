require("nvim-cursorline").setup {
  cursorline = {
    enable = true,
    timeout = 100,
    number = false,
  },
  cursorword = {
    enable = false,
    min_length = 3,
    hl = { underline = false },
  },
}
