-- Function to get the current buffer or class name (replace with your editor/IDE-specific logic)
function get_current_file_name()
	-- Replace this with the logic to get the current buffer or class name
	return vim.fn.expand("%:t:r")
end

-- Function to run the Maven command in a new tmux window
function run_maven_test()
	local current_file_name = get_current_file_name()
	local command = string.format(
		"tmux new-window -n 'Maven Test Class' 'mvn -Dstyle.color=always -Dtest=%s test | less -R -G +G'",
		current_file_name
	)

	-- Run the tmux command to create a new window and execute the Maven command
	vim.fn.system(command)
end

function run_maven_test_method()
	-- Get the current line
	local current_line = vim.api.nvim_get_current_line()

	-- Pattern to match the method name
	local pattern = "void%s+(%w+)%s*%("

	-- Use the string.match function with the pattern
	local method_name = current_line:match(pattern)

	-- Now method_name holds the name of the method
	if method_name then
		-- print("Method name: " .. method_name)
		local current_file_name = get_current_file_name()
		local command = string.format(
			"tmux new-window -n 'Maven Test Method' 'mvn -Dstyle.color=always -Dtest=%s#%s test | less -R -G +G'",
			current_file_name,
			method_name
		)

		-- Run the tmux command to create a new window and execute the Maven command
		vim.fn.system(command)
	else
		print("No method name found in the current line.")
	end
end

local wk = require("which-key")
wk.register({
	["<leader>t"] = {
		name = "Run Maven Test",
		m = { "<cmd>lua run_maven_test_method()<CR>", "Single Method" },
		c = { "<cmd>lua run_maven_test()<CR>", "Single Class" },
	},
}, { noremap = true, silent = true })
