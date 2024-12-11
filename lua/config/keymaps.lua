vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true })

vim.keymap.set("n", "<leader>ck", ":RustLsp expandMacro<CR>")

vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true })
