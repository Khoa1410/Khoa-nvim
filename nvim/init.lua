vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.tabstop = 2        -- số khoảng trắng cho mỗi tab
vim.opt.shiftwidth = 2     -- số khoảng trắng khi auto-indent
vim.opt.expandtab = true   -- dùng khoảng trắng thay vì tab thật
vim.opt.smartindent = true -- tự động thụt dòng thông minh
vim.opt.clipboard = "unnamedplus" -- dùng clipboard hệ thống



-- Thêm lazy.nvim vào runtimepath
vim.opt.rtp:prepend("~/.config/nvim/setting_file/lazy.nvim")

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.plugins")
require("config.lsp")     -- <- dòng này để load cấu hình LSP
require("config.dap.dap")



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




--  gitlens

local gs = require('gitsigns')

vim.keymap.set('n', ']c', function()
  if vim.wo.diff then return ']c' end
  vim.schedule(function() gs.next_hunk() end)
  return '<Ignore>'
end, {expr=true, desc="Next Git Hunk"})

vim.keymap.set('n', '[c', function()
  if vim.wo.diff then return '[c' end
  vim.schedule(function() gs.prev_hunk() end)
  return '<Ignore>'
end, {expr=true, desc="Previous Git Hunk"})

-- Phím tắt thao tác với hunk (đoạn thay đổi)
--
--Stage hunk — đánh dấu đoạn thay đổi hiện tại vào staging area (chuẩn bị commit).
vim.keymap.set('n', '<C-h>s', gs.stage_hunk, { desc = "Stage Hunk" })

--Reset hunk — bỏ các thay đổi trong đoạn hiện tại, quay về trạng thái của HEAD.
vim.keymap.set('n', '<C-h>r', gs.reset_hunk, { desc = "Reset Hunk" })

--Stage đoạn được chọn trong visual mode.
vim.keymap.set('v', '<C-h>s', function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Stage Hunk Visual" })

--Reset đoạn được chọn trong visual mode.
vim.keymap.set('v', '<C-h>r', function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Reset Hunk Visual" })


--Phím tắt thao tác toàn bộ buffer
--
--Stage toàn bộ buffer — stage toàn bộ thay đổi trong file hiện tại.
vim.keymap.set('n', '<C-h>S', gs.stage_buffer, { desc = "Stage Buffer" })

--Undo stage hunk — hoàn tác việc stage đoạn thay đổi gần nhất.
vim.keymap.set('n', '<C-h>u', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })

--Reset toàn bộ buffer — reset toàn bộ file về trạng thái của HEAD.
vim.keymap.set('n', '<C-h>R', gs.reset_buffer, { desc = "Reset Buffer" })

--Phím tắt xem và ẩn thông tin
--
--Preview hunk — mở popup xem nội dung thay đổi trong hunk hiện tại.
vim.keymap.set('n', '<C-h>p', gs.preview_hunk, { desc = "Preview Hunk" })

--Blame dòng hiện tại (full) — hiển thị thông tin ai chỉnh sửa dòng hiện tại và commit message.
vim.keymap.set('n', '<C-h>b', function() gs.blame_line{full=true} end, { desc = "Blame Line" })

--Toggle current line blame — bật/tắt hiển thị thông tin blame tự động ở dòng hiện tại (dưới dạng ẩn hoặc hiện).
vim.keymap.set('n', '<C-h>B', gs.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })

--Phím tắt diff và toggle_current_line_blame
--
--Diff this — xem sự khác biệt file hiện tại so với HEAD.
vim.keymap.set('n', '<C-h>d', gs.diffthis, { desc = "Diff This" })

--Diff this against HEAD~ — so sánh file hiện tại với commit trước HEAD (HEAD~).
vim.keymap.set('n', '<C-h>D', function() gs.diffthis("~") end, { desc = "Diff This Against HEAD~" })

--Toggle deleted — ẩn hoặc hiện các dòng bị xóa.
vim.keymap.set('n', '<C-h>P', gs.toggle_deleted, { desc = "Toggle Deleted" })


--AI chatbot
vim.keymap.set("n", "<C-c>g", ":ChatGPT<CR>", { noremap = true, silent = true, desc = "Open ChatGPT" })


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


-- theme

require("theme.strawberry").setup()


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



--csv and excel reader

vim.api.nvim_create_user_command("XlsxToCsv", function(opts)
  local filepath = opts.args
  if filepath == "" then
    print("Please provide a path to the Excel file")
    return
  end
  local cmd = string.format("!%s %s", "~/.config/nvim/scripts/xlsx_to_csv.py", filepath)
  vim.cmd(cmd)
  -- Mở file CSV tương ứng
  local csvfile = filepath:gsub("%.xlsx$", ".csv")
  vim.cmd("edit " .. csvfile)
end, { nargs = 1, complete = "file" })


--chatbot diff


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




