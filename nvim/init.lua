vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.tabstop = 2        -- số khoảng trắng cho mỗi tab
vim.opt.shiftwidth = 2     -- số khoảng trắng khi auto-indent
vim.opt.expandtab = true   -- dùng khoảng trắng thay vì tab thật
vim.opt.smartindent = true -- tự động thụt dòng thông minh


-- Thêm lazy.nvim vào runtimepath
vim.opt.rtp:prepend("~/.config/nvim/setting_file/lazy.nvim")

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.plugins")
require("config.lsp")     -- <- dòng này để load cấu hình LSP



local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Toggle terminal với Ctrl + t
keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", opts)

-- Mở/tắt file explorer với <leader>e (mặc định <leader> là Space)
keymap("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", opts)
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

vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Tìm file (find_files)" })
vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Tìm nội dung (live_grep)" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Tìm buffer" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Tìm help" })

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
vim.keymap.set('v', '<C-hr>s', function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Stage Hunk Visual" })

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



-- Reload init.lua với :ReloadConfig
vim.api.nvim_create_user_command("ReloadConfig", function()
  vim.cmd("source $MYVIMRC")
  print("✅ Reloaded init.lua!")
end, {})

