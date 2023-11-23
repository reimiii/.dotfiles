-- -- Function to get the current buffer or class name (replace with your editor/IDE-specific logic)
-- local function get_current_file_name()
-- 	-- Replace this with the logic to get the current buffer or class name
-- 	return vim.fn.expand("%:t:r")
-- end
--
-- -- Function to run the Maven command in a new tmux window
-- function RunMavenTestClass()
-- 	local current_file_name = get_current_file_name()
-- 	local command = string.format(
-- 		"tmux new-window -n 'Maven Test Class' 'mvn -Dstyle.color=always -Dtest=%s test | less -R -G +G'",
-- 		current_file_name
-- 	)
--
-- 	-- Run the tmux command to create a new window and execute the Maven command
-- 	vim.fn.system(command)
-- end
--
-- function RunMavenTestMethod()
-- 	-- Get the current line
-- 	local current_line = vim.api.nvim_get_current_line()
--
-- 	-- Pattern to match the method name
-- 	local pattern = "void%s+(%w+)%s*%("
--
-- 	-- Use the string.match function with the pattern
-- 	local method_name = current_line:match(pattern)
--
-- 	-- Now method_name holds the name of the method
-- 	if method_name then
-- 		-- print("Method name: " .. method_name)
-- 		local current_file_name = get_current_file_name()
-- 		local command = string.format(
-- 			"tmux new-window -n 'Maven Test Method' 'mvn -Dstyle.color=always -Dtest=%s#%s test | less -R -G +G'",
-- 			current_file_name,
-- 			method_name
-- 		)
--
-- 		-- Run the tmux command to create a new window and execute the Maven command
-- 		vim.fn.system(command)
-- 	else
-- 		print("No method name found in the current line.")
-- 	end
-- end
--
-- local function pom_exists()
-- 	local handle = io.open("pom.xml", "r")
-- 	if handle ~= nil then
-- 		io.close(handle)
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end
--
-- local wk = require("which-key")
--
-- local function on_attach(client, bufnr)
-- 	local opts = { noremap = true, silent = true, buffer = bufnr }
--
-- 	if pom_exists() then
-- 		local mappings = {
-- 			["<leader>t"] = {
-- 				name = "Run Test pom_exists",
-- 				c = { RunMavenTestClass(), "Run Class" },
-- 				m = { RunMavenTestMethod(), "Run Method" },
-- 			},
-- 		}
-- 	else
-- 		local mappings = {
-- 			["<leader>t"] = {
-- 				name = "Run pom not exists",
-- 				c = { "some", "Run Class" },
-- 				m = { "oke", "Run Method" },
-- 			},
-- 		}
-- 	end
-- 	wk.register(mappings, opts)
-- end
--
-- return on_attach

-- Function to get the current buffer or class name (replace with your editor/IDE-specific logic)
local function get_current_file_name()
	-- Replace this with the logic to get the current buffer or class name
	return vim.fn.expand("%:t:r")
end

-- Function to run the Maven command in a new tmux window
local function run_maven_test(class_name, method_name)
	local command_format =
		"tmux new-window -n 'Maven Test %s' 'mvn -Dstyle.color=always -Dtest=%s test | less -R -G +G'"
	local test_target = class_name
	if method_name then
		test_target = test_target .. "#" .. method_name
	end
	local command = string.format(command_format, method_name and "Method" or "Class", test_target)
	vim.fn.system(command)
end

function RunMavenTestClass()
	local current_file_name = get_current_file_name()
	run_maven_test(current_file_name)
end

function RunMavenTestMethod()
	-- Get the current line
	local current_line = vim.api.nvim_get_current_line()

	-- Pattern to match the method name
	local pattern = "void%s+(%w+)%s*%("

	-- Use the string.match function with the pattern
	local method_name = current_line:match(pattern)

	-- Now method_name holds the name of the method
	if method_name then
		local current_file_name = get_current_file_name()
		run_maven_test(current_file_name, method_name)
	else
		print("No method name found in the current line.")
	end
end

local function pom_exists()
	local handle = io.open("pom.xml", "r")
	if handle ~= nil then
		io.close(handle)
		return true
	else
		return false
	end
end

local wk = require("which-key")

local function on_attach(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	local mappings = {
		["<leader>t"] = {
			name = pom_exists() and "Run Test pom_exists" or "Run pom not exists",
			c = { RunMavenTestClass, "Run Class" },
			m = { RunMavenTestMethod, "Run Method" },
		},
	}
	wk.register(mappings, opts)
end

return on_attach
