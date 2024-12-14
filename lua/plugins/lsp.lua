return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable hover action to let it controlled by rustacean
    keys[#keys + 1] = { "K", false }
  end,
}
