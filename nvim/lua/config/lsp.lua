-- Kích hoạt Mason để cài LSP server
require("mason").setup()

-- Mason-LSPconfig để tự động kết nối với lspconfig
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",   -- Python
    "clangd",    -- C/C++
    "jdtls",     -- Java
    "ts_ls",  -- JavaScript/TypeScript
    "html",      -- HTML
    "cssls",     -- CSS
  },
  automatic_installation = true,
})

-- Nạp lspconfig và capabilities cho nvim-cmp
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Hàm cấu hình chung khi server được attach
local on_attach = function(_, bufnr)
  local map = vim.keymap.set
  local opts = { buffer = bufnr, silent = true }

  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
end

-- Danh sách các LSP servers bạn muốn bật
local servers = {
  "pyright",
  "clangd",
  "jdtls",
  "ts_ls",
  "html",
  "cssls",
}

-- Lặp qua và setup từng server
for _, server in ipairs(servers) do
  --vim.lsp.config[server].setup({
  --  capabilities = capabilities,
  --  on_attach = on_attach,
  --})
  vim.lsp.config(server, {
    capabilities = capabilities,
    on_attach = on_attach,
    })
end
vim.lsp.enable(servers)

