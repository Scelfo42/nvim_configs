return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
  },

  config = function()
    -- Keymaps only when an LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
      end,
    })

    -- Mason just installs tools (servers, linters, formatters)
    require("mason").setup()

    -- Configure clangd (C/C++)
    -- NOTE: This is the new Nvim 0.11+ way (no require('lspconfig').setup()).
    vim.lsp.config("clangd", {
      cmd = { "clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      -- root markers help clangd know "project root"
      root_markers = { ".git", "compile_commands.json", "compile_flags.txt", "Makefile", "CMakeLists.txt" },
    })

    -- Enable the server (autostarts for matching filetypes)
    vim.lsp.enable("clangd")
  end,
}

