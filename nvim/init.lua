vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.tabstop = 4        
vim.opt.shiftwidth = 4     
vim.opt.expandtab = true   
vim.opt.smartindent = true 
vim.opt.clipboard = "unnamedplus" 
vim.opt.cursorline = true


-- no copy when using delete
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('n', 'd$', '"_d$', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('n', 'dw', '"_dw', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('n', 'd2j', '"_d2j', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true, silent = true })  



-- lazy.nvim setup
vim.opt.rtp:prepend("~/.config/nvim/setting_file/lazy.nvim")

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.plugins")
require("config.lsp")    
require("config.dap.dap")
require("config.copilot_agent")



local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- terminal 
keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", opts)

-- file explorer
keymap("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", opts)

--nvim-dap (Debug Adapter Protocol) keymaps
--
-- Continue
vim.keymap.set("n", "<C-d>c", function() require("dap").continue() end, { desc = "DAP Continue" })

-- Step over
vim.keymap.set("n", "<C-d>n", function() require("dap").step_over() end, { desc = "DAP Step Over" })

-- Step into
vim.keymap.set("n", "<C-d>i", function() require("dap").step_into() end, { desc = "DAP Step Into" })

-- Step out
vim.keymap.set("n", "<C-d>o", function() require("dap").step_out() end, { desc = "DAP Step Out" })

-- Toggle breakpoint
vim.keymap.set("n", "<C-d>b", function() require("dap").toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })

-- Open REPL
vim.keymap.set("n", "<C-d>r", function() require("dap").repl.open() end, { desc = "DAP REPL Open" })

-- Toggle dap-ui 
vim.keymap.set("n", "<C-d>u", function() require("dapui").toggle() end, { desc = "DAP UI Toggle" })

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>p", builtin.find_files, { desc = "find_files" })
vim.keymap.set("n", "<C-p>f", builtin.live_grep, { desc = "live_grep" })
vim.keymap.set("n", "<C-p>b", builtin.buffers, { desc = "find_buffer" })
vim.keymap.set("n", "<C-p>h", builtin.help_tags, { desc = "help" })

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

-- hunk 
--
--Stage hunk 
vim.keymap.set('n', '<C-h>s', gs.stage_hunk, { desc = "Stage Hunk" })

--Reset hunk 
vim.keymap.set('n', '<C-h>r', gs.reset_hunk, { desc = "Reset Hunk" })

--Stage visual mode.
vim.keymap.set('v', '<C-h>s', function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Stage Hunk Visual" })

--Reset visual mode.
vim.keymap.set('v', '<C-h>r', function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Reset Hunk Visual" })


-- all buffer keymaps
-- 
--Stage all buffer 
vim.keymap.set('n', '<C-h>S', gs.stage_buffer, { desc = "Stage Buffer" })

--Undo stage hunk 
vim.keymap.set('n', '<C-h>u', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })

--Reset all buffer 
vim.keymap.set('n', '<C-h>R', gs.reset_buffer, { desc = "Reset Buffer" })

--check information
--
--Preview hunk 
vim.keymap.set('n', '<C-h>p', gs.preview_hunk, { desc = "Preview Hunk" })

--Blame current line (full) 
vim.keymap.set('n', '<C-h>b', function() gs.blame_line{full=true} end, { desc = "Blame Line" })

--Toggle current line blame 
vim.keymap.set('n', '<C-h>B', gs.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })

--diff and toggle_current_line_blame
--
--Diff 
vim.keymap.set('n', '<C-h>d', gs.diffthis, { desc = "Diff This" })

--Diff this against HEAD~ 
vim.keymap.set('n', '<C-h>D', function() gs.diffthis("~") end, { desc = "Diff This Against HEAD~" })

--Toggle deleted
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

-- 1.signcolumn
vim.opt.signcolumn = "yes"        

-- 2. vim.diagnostic
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",      
    spacing = 2,       
  },
  signs = true,        
  underline = true,   
  update_in_insert = false,   
  severity_sort = true,       
})

-- 3.1 show diagnostic float (CursorHold)
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",  
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",  
      prefix = "",
    })
  end
})

-- 4. keymaps diagnostic

local opts = { noremap = true, silent = true }

-- next warning 
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ float = false }) end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ float = false }) end, opts)

-- popup diagnostic 
vim.keymap.set("n", "<Space>e", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, opts)

-- list diagnostic in buffer to location list
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


-- Reload init.lua :ReloadConfig
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
vim.g.undotree_WindowLayout = 2 
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_SplitWidth = 30

--keymaps <C-u>








-- theme

require("theme.strawberry").setup()



