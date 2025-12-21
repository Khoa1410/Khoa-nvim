vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.tabstop = 4        -- số khoảng trắng cho mỗi tab
vim.opt.shiftwidth = 4     -- số khoảng trắng khi auto-indent
vim.opt.expandtab = true   -- dùng khoảng trắng thay vì tab thật
vim.opt.smartindent = true -- tự động thụt dòng thông minh
vim.opt.clipboard = "unnamedplus" -- dùng clipboard hệ thống
vim.opt.cursorline = true


-- Thay thế tất cả các lệnh xóa bằng register black hole "_" để không sao chép gì
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })  -- Chế độ Normal
vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap = true, silent = true })  -- Xóa dòng mà không sao chép
vim.api.nvim_set_keymap('n', 'd$', '"_d$', { noremap = true, silent = true })  -- Xóa từ con trỏ đến cuối dòng
vim.api.nvim_set_keymap('n', 'dw', '"_dw', { noremap = true, silent = true })  -- Xóa từ con trỏ đến từ kế tiếp
vim.api.nvim_set_keymap('n', 'd2j', '"_d2j', { noremap = true, silent = true })  -- Xóa 2 dòng mà không sao chép

-- Xóa trong chế độ Visual
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true, silent = true })  -- Xóa vùng chọn mà không sao chép



-- Thêm lazy.nvim vào runtimepath
vim.opt.rtp:prepend("~/.config/nvim/setting_file/lazy.nvim")

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.plugins")
require("config.lsp")     -- <- dòng này để load cấu hình LSP
require("config.dap.dap")
require("config.copilot_agent")



local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Toggle terminal với Ctrl + t
keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", opts)

-- Mở/tắt file explorer với <leader>e (mặc định <leader> là Space)
keymap("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", opts)

--nvim-dap (Debug Adapter Protocol) keymaps
--
-- Tiếp tục / bắt đầu (Continue)
vim.keymap.set("n", "<C-d>c", function() require("dap").continue() end, { desc = "DAP Continue" })

-- Step over
vim.keymap.set("n", "<C-d>n", function() require("dap").step_over() end, { desc = "DAP Step Over" })

-- Step into
vim.keymap.set("n", "<C-d>i", function() require("dap").step_into() end, { desc = "DAP Step Into" })

-- Step out
vim.keymap.set("n", "<C-d>o", function() require("dap").step_out() end, { desc = "DAP Step Out" })

-- Toggle breakpoint
vim.keymap.set("n", "<C-d>b", function() require("dap").toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })

-- Mở REPL
vim.keymap.set("n", "<C-d>r", function() require("dap").repl.open() end, { desc = "DAP REPL Open" })

-- Toggle dap-ui (nếu dùng dap-ui)
vim.keymap.set("n", "<C-d>u", function() require("dapui").toggle() end, { desc = "DAP UI Toggle" })

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>p", builtin.find_files, { desc = "Tìm file (find_files)" })
vim.keymap.set("n", "<C-p>f", builtin.live_grep, { desc = "Tìm nội dung (live_grep)" })
vim.keymap.set("n", "<C-p>b", builtin.buffers, { desc = "Tìm buffer" })
vim.keymap.set("n", "<C-p>h", builtin.help_tags, { desc = "Tìm help" })

--(<C-c>p) open command palette





--resize window

vim.keymap.set("n", "<A-l>",  ":vertical resize -5<CR>")
vim.keymap.set("n", "<A-h>", ":vertical resize +5<CR>")
vim.keymap.set("n", "<A-k>",    ":resize +2<CR>")
vim.keymap.set("n", "<A-j>",  ":resize -2<CR>")


-- autocompletion
--
--  ["<C-n>"] = cmp.mapping.select_next_item(),  
--  ["<C-p>"] = cmp.mapping.select_prev_item(),
--  ["<C-Space>"] = cmp.mapping.complete(),
--  ["<CR>"] = cmp.mapping.confirm({ select = true }),
--  ["<Tab>"] = cmp.mapping(function(fallback)
  --

-- linter keymaps

--python linter
vim.keymap.set("n", "<C-s>p", function()
  require("lint").try_lint({ "pylint" })
end, { desc = "Run pylint manually" })


-- lazygit keymaps
-- vim.keymap.set("n", "<C-h>g", "<cmd>LazyGit<CR>", { noremap = true, silent = true, desc = "Open LazyGit" })





-- vim diagnostics 

-- 1. Đặt sign để hiển thị ở cột trái (signcolumn)
vim.opt.signcolumn = "yes"        -- Luôn hiện signcolumn để không bị nhảy cột khi có lỗi

-- 2. Cấu hình chung cho vim.diagnostic
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",      -- Dấu ● sẽ xuất hiện trước dòng lỗi
    spacing = 2,       -- Khoảng cách giữa ký tự prefix và nội dung
  },
  signs = true,         -- Hiển thị các dấu ở signcolumn
  underline = true,     -- Gạch chân chỗ có lỗi
  update_in_insert = false,   -- Không cập nhật diagnostic khi đang ở chế độ Insert
  severity_sort = true,        -- Sắp xếp theo mức độ (Error trước, Warn sau...)
})

-- 3.1 Tự động show diagnostic float khi đứng yên (CursorHold)
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",  -- áp dụng cho mọi filetype
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",  -- hiển thị nguồn (ví dụ: flake8, pylintrc...)
      prefix = "",
    })
  end
})

-- 4. keymaps cho diagnostic

local opts = { noremap = true, silent = true }

-- Đi tới lỗi/warning kế tiếp
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ float = false }) end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ float = false }) end, opts)

-- Mở popup xem diagnostic ở dòng hiện tại
vim.keymap.set("n", "<Space>e", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, opts)

-- Lấy danh sách diagnostic trong buffer vào location list
vim.keymap.set("n", "<Space>q", function()
  vim.diagnostic.setloclist({ open = true })
end, opts)


-- formatter keymaps


vim.keymap.set({ "n", "v" }, "<Space-f>", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })




-- go to definition keymaps

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to Declaration" })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Find References" })



--treesitter keymaps

          --keymaps = {
           -- ["af"] = "@function.outer",
            --["if"] = "@function.inner",
           -- ["ac"] = "@class.outer",
            --["ic"] = "@class.inner",


--outline keymaps

--<C-s>f


--which keymaps
--
--<Space-w>


-- Reload init.lua với :ReloadConfig
vim.api.nvim_create_user_command("ReloadConfig", function()
  vim.cmd("source $MYVIMRC")
  print("✅ Reloaded init.lua!")
end, {})



--autosave


vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = "*",
  callback = function()
    if vim.bo.modifiable and vim.bo.modified then
      vim.cmd("silent! write")
      print("Autosaved ")
    end
  end,
})



--persistent undo

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.cmd("silent! call mkdir(stdpath('cache') . '/undo', 'p')")
vim.opt.undolevels = 10000  
vim.opt.undoreload = 10000

--undo-tree
vim.g.undotree_WindowLayout = 2 -- cửa sổ ngang
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_SplitWidth = 30

--keymaps <C-u>








-- theme

require("theme.strawberry").setup()



