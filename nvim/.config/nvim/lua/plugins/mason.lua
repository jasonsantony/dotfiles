return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "rust-analyzer",
        "gopls",
        "basedpyright",
        "clangd",
        "marksman",
        "yaml-language-server",
        "json-lsp",
        "taplo",
        "bash-language-server",

        -- Debuggers
        "codelldb",   -- Rust / C / C++
        "delve",      -- Go
        "debugpy",    -- Python

        -- Formatters & linters (Mason-managed)
        "stylua",          -- Lua formatter
        "shfmt",           -- Shell formatter
        "prettier",        -- JSON / YAML / Markdown formatter
        "ruff",            -- Python (lint + format)
        "gofumpt",         -- Go formatter
        "goimports",       -- Go imports fixer
        "clang-format",    -- C/C++ formatter
        "vale",            -- Markdown linter
        "actionlint",      -- GitHub Actions YAML linter
        "editorconfig-checker", -- EditorConfig checker
      },
    },
  },
}

