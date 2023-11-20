local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local config = {
	cmd = {
		-- vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
		"java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		-- "/home/energia/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
		"/home/energia/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		"/home/energia/.local/share/nvim/mason/packages/jdtls/config_linux",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		vim.fn.expand("~/.cache/jdtls-workspace/") .. workspace_dir,
	},
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
}

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }
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

config["on_attach"] = function(client, bufnr)
	opts.buffer = bufnr

	opts.desc = "Run Maven Test Single Method"
	keymap.set("n", "<leader>tm", "<cmd>lua run_maven_test_method()<CR>", opts) -- show definition, references

	opts.desc = "Run Maven Test Single Class"
	keymap.set("n", "<leader>tr", "<cmd>lua run_maven_test()<CR>", opts) -- show definition, references

	opts.desc = "Run LSP Format"
	keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<CR>", opts) -- show definition, references
	-- set keybinds
	opts.desc = "Show LSP references"
	keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

	opts.desc = "Go to declaration"
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

	opts.desc = "Show LSP definitions"
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

	opts.desc = "Show LSP implementations"
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

	opts.desc = "Show LSP type definitions"
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

	opts.desc = "See available code actions"
	keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

	opts.desc = "Smart rename"
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

	opts.desc = "Show buffer diagnostics"
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

	opts.desc = "Show line diagnostics"
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

	opts.desc = "Go to previous diagnostic"
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

	opts.desc = "Go to next diagnostic"
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

	opts.desc = "Show documentation for what is under cursor"
	keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

	opts.desc = "Restart LSP"
	keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
end

require("jdtls").start_or_attach(config)
