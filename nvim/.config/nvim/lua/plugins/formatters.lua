return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" }, -- from Rust toolchain
        go = { "gofumpt" },
        python = { "ruff_format" },
        cpp = { "clang_format" },
        c = { "clang_format" },
        markdown = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
      },
    },
  },
}
