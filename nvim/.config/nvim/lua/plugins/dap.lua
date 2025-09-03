return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dapui = require("dapui")

      -- Mason installs debug adapters for us
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "delve", "debugpy" },
        handlers = {}, -- auto-setup adapters if possible
      })

      -- UI for debugging
      dapui.setup()

      -- Auto open/close dap-ui
      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
