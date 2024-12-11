return {
  "mrcjkb/rustaceanvim",
  opts = {
    dap = {
      client = {
        initCommands = {
          "command script import /home/hervehuneau/Downloads/rust_prettifier_for_lldb.py",
        },
      },
    },
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "K", function()
          vim.cmd.RustLsp({ "hover", "actions" })
        end, { silent = false, buffer = bufnr })
        vim.keymap.set("n", "<leader>cR", function()
          vim.cmd.RustLsp("codeAction")
        end, { desc = "Code Action", buffer = bufnr })
        vim.keymap.set("n", "<leader>dr", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })
        vim.keymap.set("n", "<leader>ct", function()
          vim.cmd.RustLsp("testables")
        end, { desc = "Rust Testables", buffer = bufnr })
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          -- imports = {
          --   granularity = {
          --     group = "module",
          --   },
          --   prefix = "self",
          -- },
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          -- Add clippy lints for Rust.
          checkOnSave = true,
          -- cachePriming = {
          --   enable = false,
          -- },
          -- diagnostics = {
          --   experimental = {
          --     enable = true,
          --   },
          -- },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "please_stop_bothering_me" },
            },
          },
        },
      },
    },
  },
}
