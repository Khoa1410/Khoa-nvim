vim.api.nvim_create_user_command("ReloadConfig", function()
  vim.cmd("source $MYVIMRC")
end, {})


local keymap = vim.keymap.set

-- Phím tắt mở/đóng terminal toggleterm
keymap("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- Phím tắt bật/tắt file explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })


