return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
        yaml = { "actionlint" },
        -- Rust → clippy (via toolchain, not Mason)
        -- Go → gopls provides lint-like diagnostics
        -- C/C++ → clangd provides lint-like diagnostics
      },
    },
  },
}
