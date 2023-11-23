local wk = require("which-key")

local function on_attach(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	local mappings = {
		["<leader>l"] = {
			name = "LSP",
			f = { "<cmd>lua vim.lsp.buf.format{async=true}<CR>", "Format" },
			a = { vim.lsp.buf.code_action, "Code Actions" },
			D = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer Diagnostics" },
			d = { vim.diagnostic.open_float, "Line Diagnostics" },
			k = { vim.lsp.buf.hover, "Show documentation for what is under cursor" },
			g = {
				name = "Show LSP",
				r = { "<cmd>Telescope lsp_references<CR>", "references" },
				D = { vim.lsp.buf.declaration, "Go to declaration" },
				d = { "<cmd>Telescope lsp_definitions<CR>", "definitions" },
				i = { "<cmd>Telescope lsp_implementations<CR>", "implementations" },
				t = { "<cmd>Telescope lsp_type_definitions<CR>", "definitions" },
			},
			r = {
				name = "Rename Etc",
				s = { ":LspRestart<CR>", "Restart LSP" },
				n = { vim.lsp.buf.rename, "Smart Rename" },
			},
		},
		["]d"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
		["[d"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
	}

	wk.register(mappings, opts)
end

return on_attach
