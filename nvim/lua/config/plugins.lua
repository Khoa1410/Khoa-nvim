return {
  -- ToggleTerm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        size = 15,
        open_mapping = [[<c-\>]],
        shade_terminals = false,
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      })
    end,
  },

  -- Nvim Tree
  {
  "nvim-tree/nvim-web-devicons",
  lazy = true
},

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
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
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
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

  --copilot


    {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,     -- gợi ý tự động
          keymap = {
            accept = "<S-Tab>",      -- accept gợi ý
            next = "<C-c>h",        -- gợi ý tiếp theo
            prev = "<C-c>l",        -- gợi ý trước
            dismiss = "<C-c>d",     -- ẩn gợi ý
          },
        },
        panel = { enabled = false }, -- tắt cửa sổ sidebar (tuỳ chọn)
      })
    end,
  },


  -- AI chat

    {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",


    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "",
      })

    end,
  },

  --gitlens 
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
      },

      -- Gọi lint khi lưu file
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
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

