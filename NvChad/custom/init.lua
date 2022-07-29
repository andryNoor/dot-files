-- example file i.e lua/custom/init.lua

-- load your globals, autocmds here or anything .__.

local new_cmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd

-- highlight CursorLine
new_cmd("HiCursorLine", function()
	-- [WORKAROUND] force highlight CursorLine after changing theme
	-- reason: NvChad clear CursorLine highlight after manually toggle or changing theme

	local colors = require("base46").get_theme_tb("base_30")
	local black2 = colors.black2
	local cmd = string.format("highlight CursorLine guibg=%s cterm=bold gui=bold", black2)

	vim.cmd(cmd)
end, {})

-- highlight LSP gui
new_cmd("HiLSPgui", function()
	local hls = require("custom.highlights").overriden_hlgui.HiLSPgui

	local cmd
	for _, hl in ipairs(hls) do
		cmd = string.format("highlight %s cterm=italic gui=italic", hl)
		vim.cmd(cmd)
	end
end, {})

-- highlight Treesitter (syntax) gui
new_cmd("HiTSgui", function()
	local hls = require("custom.highlights").overriden_hlgui.HiTSgui

	for k, v in pairs(hls) do
		local cmd
		for _, hl in ipairs(v) do
			if k == "italic_bold" then
				cmd = string.format("highlight %s cterm=italic,bold gui=italic,bold", hl)
				vim.cmd(cmd)
			elseif k == "italic" then
				cmd = string.format("highlight %s cterm=italic gui=italic", hl)
				vim.cmd(cmd)
			elseif k == "bold" then
				cmd = string.format("highlight %s cterm=bold gui=bold", hl)
				vim.cmd(cmd)
			end
		end
	end
end, {})


autocmd("BufEnter", {
	callback = function()
		-- vim.cmd("highlight CursorLine cterm=bold gui=bold")
		vim.cmd([[
    " italic Comment
    highlight Comment cterm=italic gui=italic
    " override CursorLine gui
    highlight CursorLine cterm=bold gui=bold
    " highlight LSP, Treesitter and general syntax
    HiLSPgui
    " highlight Treesitter and general syntax
    HiTSgui
    ]])
	end,
})

-- autocmd("VimEnter", {
-- 	callback = function()
-- 		-- vim.highlight.create("Comment", { cterm = "italic", gui = "italic" }, false),
-- 		vim.cmd([[
--     ]])
-- 	end,
-- })

-- autocmd("FileType", {
--   pattern = "terminal",
--   callback = function ()
--     vim.cmd("highlight clear CursorLine")
--   end
-- })
