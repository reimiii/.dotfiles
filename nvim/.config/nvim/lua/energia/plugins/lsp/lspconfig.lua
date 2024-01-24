return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lsp_keymaps = require("energia.core.lsp-keymaps")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["dockerls"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				lsp_keymaps(client, bufnr)
			end,
		})

		lspconfig["java_language_server"].setup({
			cmd = { "~/.local/share/nvim/mason/packages/java-language-server/dist/lang_server_linux.sh" },
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				lsp_keymaps(client, bufnr)
			end,
		})

		lspconfig["docker_compose_language_service"].setup({
			cmd = { "docker-compose-langserver", "--stdio" },
			filetypes = { "yaml.docker-compose" },
			root_dir = lspconfig.util.root_pattern("docker-compose.yaml"),
			single_file_support = true,
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				lsp_keymaps(client, bufnr)
			end,
		})

		lspconfig["yamlls"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				lsp_keymaps(client, bufnr)
			end,
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				lsp_keymaps(client, bufnr)
			end,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
