local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Cấu hình lazy.nvim, import plugin từ config.plugins
require("lazy").setup({
  { import = "config.plugins" },
}, {
  root = vim.fn.stdpath("config") .. "/setting_file",  -- plugin sẽ clone vào đây
})


require("lazy").setup("config.plugins")

