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

--config lazy.nvim, import plugin 
require("lazy").setup({
  { import = "config.plugins" },
}, {
  root = vim.fn.stdpath("config") .. "/setting_file",  
})


require("lazy").setup("config.plugins")

