return{
  -- ToggleTerm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        size = 7,
        open_mapping = [[<c-\>]],
        shade_terminals = false,
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      })
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*",
      callback = function()
        vim.cmd("startinsert")
        local opts = { buffer = true }
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end,
  })
end,
},

  -- Nvim Tree
{
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- vẫn giữ nếu sau này muốn bật lại icon
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
        adaptive_size = true,
      },
      renderer = {
        icons = {
          webdev_colors = false,  -- không dùng màu icon
          show = {
            git = false,
            folder = false,
            file = false,
            folder_arrow = false,
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      filters = {
        dotfiles = false,
        custom = { ".git", "node_modules", ".cache" },
      },
    })
  end,
},





-- undo-tree



{
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<C-u>", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" }
  }
},




-- keymaps search



--outline.nvim



{
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<C-s>f", "<cmd>Outline<CR>", desc = "Toggle Outline" },
  },
  opts = {
    outline_window = {
      position = "right",
      width = 30,
    },
    symbols = {
      -- bạn có thể cấu hình thêm tùy thích ở đây
    },
  },
},



--lualine.nvim

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          icons_enabled = false,  -- Tắt icon ở đây
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },





--treesitter


{
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "lua", "python", "javascript", "typescript", "html", "css", "bash", "json", "yaml"
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    })
  end,
},

--indentscope


{
  "echasnovski/mini.indentscope",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('mini.indentscope').setup({
      draw = {
        delay = 50,
        animation = require('mini.indentscope').gen_animation.none(),
      },
      symbol = "⎸" ,
      options = { try_as_border = true },
    })
  end
},

{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        char = "▏"
    }
},
},

-- nvim-autopairs


  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
      })
    end,
  },


--Docker ui

{
  "skanehira/docker.vim",
  cmd = { "DockerContainers", "DockerImages", "DockerVolumes", "DockerNetworks" },
  keys = {
    { "<Space-d>c", ":DockerContainers<CR>", desc = "Docker containers" },
    { "<Space-d>i", ":DockerImages<CR>", desc = "Docker images" },
  }
},

{
  "stevearc/overseer.nvim",
  config = function()
    require("overseer").setup()
    require("overseer").new_task({
  cmd = { "docker-compose", "up" },
  name = "Docker Up",
  strategy = "terminal",
})

  end,
},
{
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "lpoto/telescope-docker.nvim", -- tiện ích Docker cho telescope
  },
  config = function()
    require("telescope").load_extension("docker")
  end
},






-- csv reader


{
  "chrisbra/csv.vim",
  ft = "csv",
  lazy = false,
  event = "BufReadPre",
  config = function()
    -- Không cần config phức tạp, plugin tự hoạt động khi mở file .csv
  end,
},



--preview markdown



--{
 -- "iamcco/markdown-preview.nvim",
 -- ft = "markdown",
 -- build = "cd app && npm install",
  --config = function()
   -- vim.g.mkdp_auto_start = 1
  --end,
--},



-- image viewer



{
  "3rd/image.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = true,
  ft = { "markdown", "txt", "norg" }, -- load khi mở file markdown/text
  config = function()
    require("image").setup({
      backend = "viu", -- nhẹ, hỗ trợ mọi terminal
      integrations = {
        markdown = true,
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = 50,
      max_height_window_percentage = 50,
    })
  end,
},


  --bufferline
  


{
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        separator_style = "thick",
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = false,
        show_buffer_icons = false,
        indicator = {
          style = "icon",
          icon = "▶",  -- biểu tượng chỉ báo tab hiện tại
        },
        modifier_icons = "●",
        },
     highlights = {
       buffer_selected = {
    fg = "#fff0f7",        -- g0: sáng rõ
    bg = "#d46a84",        -- gF: nền nổi bật
    bold = true,
    italic = false,
  },
  buffer_visible = {
    fg = "#9e8b95",        -- g3: nhạt hơn
    bg = "#f0dde6",        -- g1: nền sáng vừa phải
    bold = false,
    italic = false,
  },
  background = {
    fg = "#75616b",        -- g5: xám tối cho tab chưa chọn
    bg = "#f0dde6",        -- g1: nền sáng
  },
},
 

          })
    -- Keybinds để chuyển tab
    vim.keymap.set("n", "<C-o>", ":BufferLineCycleNext<CR>", {})
    vim.keymap.set("n", "<C-i>", ":BufferLineCyclePrev<CR>", {})
  end,
},


-- formatter


{
  "stevearc/conform.nvim",
  lazy = false, -- load ngay để hỗ trợ format-on-save
  config = function()
    require("conform").setup({
      format_on_save = {
        lsp_fallback = true, -- fallback nếu không có formatter riêng
        timeout_ms = 500,    -- thời gian chờ format
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        sh = { "shfmt" },
        markdown = { "prettier" },
        yaml = { "prettier" },
      },
    })
  end,
},




  -- Core Copilot completion
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-r>",
            next = "<C-c>h",
            prev = "<C-c>l",
            dismiss = "<C-c>d",
          },
        },
        panel = {
          enabled = false,
        },
        server_opts_overrides = {
          -- Optional: override agent model and settings
          capabilities = {
            textDocument = {
              codeAction = { dynamicRegistration = false },
            },
          },
        },
      })
    end,
  },

  -- Copilot Chat with Agent capabilities






{
    "CopilotC-Nvim/CopilotChat.nvim",
    build        = "make tiktoken",
    dependencies = {
      "github/copilot.vim",                   -- auth
      { "nvim-lua/plenary.nvim", branch = "master" },
    },

    config = function()
      local chat = require("CopilotChat")
      chat.setup({                            -- MẶC ĐỊNH: không ép model, không keymap
      })

      --------------------------------------------------------------------------
      -- ❶ DANH SÁCH BUFFER ĐƯỢC THÊM
      --------------------------------------------------------------------------
      vim.g.copilot_chat_files = {}

      local function add_buf(bufnr)
        if not vim.tbl_contains(vim.g.copilot_chat_files, bufnr) then
          table.insert(vim.g.copilot_chat_files, bufnr)
          vim.notify("Added: " .. vim.api.nvim_buf_get_name(bufnr), vim.log.levels.INFO)
        else
          vim.notify("Buffer already in list", vim.log.levels.WARN)
        end
      end

      --------------------------------------------------------------------------
      -- ❷ CÁC LỆNH QUẢN LÝ FILE & CHAT
      --------------------------------------------------------------------------
      -- Thêm file đang mở
      vim.api.nvim_create_user_command("CopilotAddFile", function()
        add_buf(vim.api.nvim_get_current_buf())
      end, { desc = "Add current buffer" })

      -- Xóa list
      vim.api.nvim_create_user_command("CopilotClearFiles", function()
        vim.g.copilot_chat_files = {}
        vim.notify("File list cleared", vim.log.levels.INFO)
      end, { desc = "Clear added file list" })

      -- Liệt kê file
      vim.api.nvim_create_user_command("CopilotListFiles", function()
        if #vim.g.copilot_chat_files == 0 then
          print("List empty")
          return
        end
        for i, b in ipairs(vim.g.copilot_chat_files) do
          print(i .. ": " .. vim.api.nvim_buf_get_name(b))
        end
      end, { desc = "Show list" })

      -- Mở chat kèm các file đã add
      vim.api.nvim_create_user_command("CopilotChatFiles", function(opts)
        if #vim.g.copilot_chat_files == 0 then
          vim.notify("List empty – add files first (:CopilotAddFile)", vim.log.levels.WARN)
          return
        end
        local prompt = opts.args ~= "" and opts.args
          or "Review the added files and send a unified diff patch that fixes issues."
        -- Nếu muốn ép Sonnet 4: prompt = "$claude-sonnet-4\\n" .. prompt
        chat.open(prompt, { context = { buffers = vim.g.copilot_chat_files } })
      end, { nargs = "*", desc = "Chat with added files" })

      --------------------------------------------------------------------------
      -- ❸ LỆNH ÁP DỤNG / BỎ QUA HUNK (plugin đã có)
      --------------------------------------------------------------------------
      vim.api.nvim_create_user_command("CopilotAccept",  "CopilotChatApply", { desc = "Apply hunk"  })
      vim.api.nvim_create_user_command("CopilotReject",  "CopilotChatSkip",  { desc = "Skip hunk"  })
    end,
  },



-- diffview



  {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen" },
},


  -- Telescope chat
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("CopilotChat").setup({
  window = {
    layout = "vertical",
    width = 0.4,
    position = "right", -- đảm bảo có dòng này
  },
})
      require("telescope").setup()
    end,
  },

  --gitsigns
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup {
        current_line_blame = true,
        sign_priority = 6,
      }
    end,
  },
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("neogit").setup {}
    end,
  },


  --lazygit


  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit" },  -- lazy-load khi bạn gọi lệnh :LazyGit
    keys = {
      { "<C-h>g", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
    },
    config = function()
      require("lazygit").setup({
      })
    end,
  },


--telescope-fuzzy-finder



{
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",  -- dùng version ổn định
  dependencies = {
    "nvim-lua/plenary.nvim",      
  {
        "nvim-telescope/telescope-fzf-native.nvim", -- Extension tăng tốc
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      

    },
  cmd = "Telescope",  -- lazy load khi gọi :Telescope
  keys = {},
  config = function()
    require("telescope").setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { 
          horizontal = { width = 0.9 },
          vertical = { width = 0.9 },
        },
        sorting_strategy = "ascending",
      },
    })
  end,
},



--telescope_command_palette


  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local conf = require("telescope.config").values

      telescope.setup{
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
            preview_width = 0.6,
          },
          sorting_strategy = "ascending",
          file_ignore_patterns = { "node_modules", "%.git/" },
        },
      }

      -- Định nghĩa command palette list
      local command_palette = {
        { "Save File", ":w<CR>" },
        { "Quit", ":q<CR>" },
        { "Find Files", ":Telescope find_files<CR>" },
        { "Live Grep", ":Telescope live_grep<CR>" },
        { "Buffers", ":Telescope buffers<CR>" },
        { "Help Tags", ":Telescope help_tags<CR>" },
        { "Git Status", ":Telescope git_status<CR>" },
        { "Toggle Line Numbers", ":set number!<CR>" },
        { "Toggle Relative Numbers", ":set relativenumber!<CR>" },
        { "Reload Config", ":source $MYVIMRC<CR>" },
      }

      -- Tạo function mở command palette
      function _G.open_command_palette()
        pickers.new({}, {
          prompt_title = "Command Palette",
          finder = finders.new_table({
            results = command_palette,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry[1],
                ordinal = entry[1],
              }
            end,
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              vim.cmd(selection.value[2])
            end)
            return true
          end,
        }):find()
      end

      -- keymap mở command palette
      vim.api.nvim_set_keymap("n", "<C-c>p", ":lua open_command_palette()<CR>", { noremap = true, silent = true })
    end,
  },


-- snippet


  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- tích hợp với nvim-cmp
      "rafamadriz/friendly-snippets", -- bộ snippet mẫu
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load() -- tải các snippet từ friendly-snippets
    end,
  },


  {
  "rafamadriz/friendly-snippets",
  lazy = true,
},



--nvim-linter


  
  {"mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft={
        python = { "flake8" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        html = {},
        css = {},
        cpp = { "cpplint" },
        java = {}, -- Java thường dùng formatter/linter riêng
      }

      -- special linter cho Python
    lint.linters.pylint={
      cmd = "pylint",
      stdin = false,
      args = { "--from-stdin", "%filepath" },
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.parser").from_errorformat([[%f:%l:%c: %m]], {
        source = "pylint",
        severity = vim.diagnostic.severity.WARN,
      }),
    }

      -- Gọi lint khi lưu file
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
      -- Gọi pylint
       vim.keymap.set("n", "<C-s>p", function()
      lint.try_lint({ "pylint" })
    end, { desc = "Run pylint manually" })
    end,
  },


  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- Mason LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      "neovim/nvim-lspconfig",
      {"williamboman/mason.nvim", opts = {}},
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ruff_lsp",
          "clangd",
          "eslint",
          "tailwindcss",
          "emmet_language_server",
          "jsonls",
          "jdtls",
          "typescript",
          "ts_ls",
          "typescript-language-server",
          "html",
          "cssls",
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup()

--    			require("mason-lspconfig").setup_handlers({
				-- Will be called for each installed server that doesn't have
				-- a dedicated handler.
				--
--				function(server_name) -- default handler (optional)
					-- https://github.com/neovim/nvim-lspconfig/pull/3232
--					if server_name == "tsserver" then
						server_name = "ts_ls"
--					end
--					local capabilities = require("cmp_nvim_lsp").default_capabilities()
--					require("lspconfig")[server_name].setup({

--						capabilities = capabilities,
--					})
--				end,
--			}) 
    end,
  },
-- Nvim-dap
  {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    -- Ví dụ cấu hình DAP cho Python
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return "python"
        end,
      },
    }
  end,
},


--Dap-UI
{
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
},


--python-debug-adapter
 {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    local dap_python = require("dap-python")
      dap_python.setup("/usr/bin/python3")
  


  end,
},



-- js-dap


{
  "mxsdev/nvim-dap-vscode-js",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-vscode-js").setup({
      node_path = "node",  
      debugger_path = vim.fn.stdpath("data") .. "/js-debug",  
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" },
    })
  end,
},


 

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}

