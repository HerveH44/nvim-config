-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local rust_fold_imports = vim.api.nvim_create_augroup("RustFoldImports", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter", "BufWinEnter" }, {
  group = rust_fold_imports,
  pattern = "*.rs",
  callback = function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("keepjumps normal! gg")
    vim.cmd("silent! keepjumps normal! zc")
    for line_num = 1, vim.api.nvim_buf_line_count(0) do
      local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
      if line:match("^%s*use ") or line:match("^%s*pub use ") then
        vim.api.nvim_win_set_cursor(0, { line_num, 0 })
        if vim.fn.foldclosed(line_num) == -1 then
          vim.cmd("silent! keepjumps normal! zc")
        end
      end
    end
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
})
