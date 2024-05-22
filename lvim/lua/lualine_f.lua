--[[ lualine custom functions ]]
local M = {}
M.nvtree = function(n, btn)
  if n == 1 and btn == 'l' then
    vim.cmd('cd %:p:h')
    print('CDir to:', vim.fn.getcwd())
    vim.cmd('NvimTreeToggle')
  end
end

M.print_filename = function(n, btn) -- show filename absolute path
  if n == 1 and btn == 'l' then
    vim.cmd('=vim.fn.expand("%:p")')
  end
end

M.float_term_toggle = function(n, btn, md)
  md = vim.fn.trim(md)
  if n == 1 and btn == 'l' and md == 'a' then
    vim.cmd('execute v:count . "ToggleTerm"')
  elseif n == 1 and btn == 'l' then
    M.states.target_btn = not M.states.target_btn
  end
end

M.new_buf = function(n, btn)
  if n == 1 and btn == 'l' then
    vim.cmd('enew')
    print('new unsave buf at:', vim.fn.expand("%:p:h"))
  end
end

M.cwd = function(n, btn, md)
  md = vim.fn.trim(md)
  if n == 1 and btn == 'l' and md == 'a' then
    M.states.nvtree = not M.states.nvtree
    -- print('nvtree opened status:', lualine_f.states.nvtree)
    return M.nvtree(n, btn)
  elseif n == 1 and btn == 'l' --[[  and md == 'c' ]] then
    -- print('Folder:', vim.fn.expand("%:p:h"))
    M.states.cwd = not M.states.cwd
    print('File:', vim.fn.expand("%"), '|', 'Folder (Path):', vim.fn.expand("%:p:h"))
    return
  end
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t') -- get only the dirname (inspired by NvChad-ui statusline)
end

-- TODO: Next: Assign keymap for time component for easy access or invocation
-- e.g <space>Lh -> normal time; <space>LH -> long fmt time
-- [ <space>L -> LunarVim keymap group ]
M.time = function(n, btn, md)
  md = vim.fn.trim(md)

  if n == 1 and btn == 'l' and md == 'a' then
    -- print(n, btn, md)
    if not M.states.target_btn then
      -- make sure it's active;
      -- main purpose: make it possible for toggling via shortcut directly
      -- without needing to invoke hide/unhide toggle first, e.g. by triggering on_click;
      M.states.target_btn = true
    end
    if M.states.dt_fmt then
      M.states.countd = 0
      M.states.dt_fmt = nil
    else
      M.states.countd = 30 -- in second
      M.states.dt_fmt = '%A, %d %B %Y - %H:%M:%S'
      -- print(os.date(M.states.dt_fmt))
    end
  elseif n == 1 and btn == 'l' then
    -- print(n, btn, md)
    M.states.target_btn = not M.states.target_btn
  elseif M.states.target_btn and M.states.dt_fmt and M.states.countd <= 0 then
    M.states.dt_fmt = nil
    -- print(' ') -- auto clear printed dt at laststatus area (long form)
  elseif not M.states.target_btn and M.states.dt_fmt then
    M.states.countd = 0
    M.states.dt_fmt = nil
  end
  -- print(n, btn, md, lualine_f.states.dt_fmt, lualine_f.states.target_btn)
  -- if lualine_f.states.countd >= -2 then print(lualine_f.states.countd) end
  if M.states.countd > 0 and M.states.target_btn then M.states.countd = M.states.countd - 1 end
  return M.states.target_btn and os.date(M.states.dt_fmt or '%H:%M:%S') or ""
end

M.empty_separator = {
  "",
  color = { bg = '#080808' },
  -- color = { bg = '#ff5189' },
  padding = { left = 0, right = 0 },
  draw_empty = true,
}

M.states = {
  --[[

  PURPOSE:
  Indicates lualine component 'click' and/or 'custom funcs (on_click)' states
    [true]      => first or next click | activate
    [false]     => second or next click | not clicked | deactivate
    [nil | any] => initial or default state or value [ type or value change as necessary by the caller ]

  NOTE:
    Not all states here are needed

  --]]

  cwd = false,
  nvtree = false,
  target_btn = false, -- 󰀘 [ .time and .float_toggle_term actions or states ]
  dt_fmt = nil,       -- datetime format [ specified by .time func ]
  countd = 0          -- default or initial value to keep track of countdown value [ used by .time to autohide | getback to initial dt_fmt ]
}

M.color_f = {
  filename = function()
    return { fg = "#79dac8", gui = vim.bo.modified and "italic,bold" or "none" }
  end,
  time = function()
    return {
      fg = M.states.target_btn --[[ false ]] and '#080808' or '#79dac8',
      bg = M.states.target_btn --[[ false ]] and '#79dac8' or '#080808',
      gui = M.states.target_btn --[[ false ]] and 'inverse' or 'none'
    }
  end
}

return M
