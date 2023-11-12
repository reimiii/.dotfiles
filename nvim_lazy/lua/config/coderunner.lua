local status_ok, code_runner = pcall(require, "code_runner")
if not status_ok then
	return
end
code_runner.setup({
	-- put here the commands by filetype
	filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "python3 -u",
		cpp = "g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
	},
	-- mode = "term",
	mode = "float",
	focus = true,
	startinsert = true,
	term = {
		--position = "vert",
		position = "bot",
		size = 50,
	},
	float = {
		-- Key that close the code_runner floating window
		close_key = "<ESC>",
		-- Window border (see ':h nvim_open_win')
		border = "rounded",

		-- Num from `0 - 1` for measurements
		height = 0.8,
		width = 0.8,
		x = 0.5,
		y = 0.5,

		-- Highlight group for floating window/border (see ':h winhl')
		border_hl = "FloatBorder",
		float_hl = "Normal",

		-- Transparency (see ':h winblend')
		blend = 0,
	},
})
