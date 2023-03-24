return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      autoformat = false,
      ---@type lspconfig.options
      servers = {
        omnisharp = {
          cmd = { "dotnet", "C:/Users/max.GA/AppData/Local/nvim-data/mason/packages/omnisharp/OmniSharp.dll" },
        },
        rust_analyzer = {},
      },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    -- keymappings to add
    -- require("dapui").toggle(1)   --> this will toggle the left
    -- require("dapui").toggle(2)   --> this will toggle the bottom
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Start/continue debugging (DAP)",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint (DAP)",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step over (DAP)",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step into (DAP)",
      },
      {
        "<leader>wt",
        function()
          require("dapui").eval()
        end,
        desc = "Evaluate element under cursor (DAP)",
      },
    },
    config = function(_, opts)
      local dap, dapui = require("dap"), require("dapui")

      vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
      vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "yellow", { fg = "#ffff00" })
      vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
      vim.api.nvim_set_hl(0, "red", { fg = "#ff0000" })

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "", texthl = "red", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "ﳁ", texthl = "red", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapLogPoint",
        { text = "", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )

      -- dap.adapters.coreclr = {
      --   type = "executable",
      --   command = "C:/tools/netcoredbg/netcoredbg",
      --   args = { "--interpreter=vscode" },
      -- }
      --

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "C:/Users/max.GA/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb",
          args = { "--port", "${port}" },
          -- On windows you may have to uncomment this:
          detached = false,
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to exe/dll: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- dap.configurations.cs = {
      --   {
      --     type = "coreclr",
      --     name = "launch - netcoredbg",
      --     request = "launch",
      --     program = function()
      --       return vim.fn.input("Path to exe/dll: ", vim.fn.getcwd() .. "/bin/debug/net7.0/", "file")
      --     end,
      --   },
      -- }

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Use this to override mappings for specific elements
        element_mappings = {
          -- Example:
          -- stacks = {
          --   open = "<CR>",
          --   expand = "o",
          -- }
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
          },
        },
        floating = {
          max_height = nil,  -- These can be integers or a float between 0 and 1.
          max_width = nil,   -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      })

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
