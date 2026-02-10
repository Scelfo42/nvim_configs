return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      configs.setup({
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}

