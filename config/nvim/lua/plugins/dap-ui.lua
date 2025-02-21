return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    {
      "mfussenegger/nvim-dap",
      keys = {
        {
          "<leader>dbp",
          function()
            local dap = require("dap")
            dap.toggle_breakpoint()
          end,
          desc = "Toggle Breakpoint"
        },
        {
          "<leader>dbc",
          function()
            local dap = require("dap")
            dap.continue()
          end,
          desc = "DUI Continue"
        },
        {
          "<leader>dbi",
          function()
            local dap = require("dap")
            dap.step_into()
          end,
          desc = "DUI Step Into"
        },
      }
    },
    "nvim-neotest/nvim-nio"
  },
  keys = {
    {
      "<leader>dui",
      function()
        local dapui = require("dapui")
        dapui.toggle()
      end,
      desc = "Toggle Dap UI"
    },
  },
  config = function()
    local dapui = require("dapui")
    dapui.setup()
  end,
}
