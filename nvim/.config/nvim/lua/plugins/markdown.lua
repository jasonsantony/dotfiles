return {
  {
    "nvim-treesitter/nvim-treesitter",
    ft = { "markdown" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "markdown", "markdown_inline" },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Always force conceal off in markdown
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.schedule(function()
            vim.opt_local.conceallevel = 0
            vim.opt_local.concealcursor = "n"
          end)
        end,
      })
    end,
  },
}
