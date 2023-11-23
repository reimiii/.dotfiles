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

local maven = require("energia.core.maven")
local lsp_keymaps = require("energia.core.lsp-keymaps")

-- local keymap = vim.keymap -- for conciseness
-- local opts = { noremap = true, silent = true }

config["on_attach"] = function(client, bufnr)
	-- opts.buffer = bufnr
	lsp_keymaps(client, bufnr)
	maven(client, bufnr)

	-- opts.desc = "Run Maven Test Single Method"
	-- keymap.set("n", "<leader>tm", "<cmd>lua run_maven_test_method()<CR>", opts) -- show definition, references
	--
	-- opts.desc = "Run Maven Test Single Class"
	-- keymap.set("n", "<leader>tr", "<cmd>lua run_maven_test()<CR>", opts) -- show definition, references
end

require("jdtls").start_or_attach(config)
