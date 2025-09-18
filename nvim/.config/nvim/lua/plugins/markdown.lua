return {
  {
    "nvim-treesitter/nvim-treesitter",
    ft = { "markdown" },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      opts.highlight = { enable = true }
      opts.indent = { enable = true }
    end,
    init = function()
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

