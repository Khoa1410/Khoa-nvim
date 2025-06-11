
-- lua/plugins/copilot_agent.lua
return {
  -- 1) Copilot core: auth & commands
  {
    "github/copilot.vim",
    cmd = {
      "Copilot",
      "CopilotSetup",
      "CopilotStatus",
      "CopilotEnable",
      "CopilotDisable",
      "CopilotAuth",
    },
  },

  -- 2) Ghost-text inline suggestions
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    dependencies = { "github/copilot.vim" },
    opts = {
      suggestion = {
        enabled      = true,
        auto_trigger = true,
        keymap       = {
          accept  = "<C-r>",   -- chấp nhận
          next    = "<C-c>h",  -- gợi ý kế
          prev    = "<C-c>l",  -- gợi ý trước
          dismiss = "<C-c>d",  -- ẩn
        },
      },
      panel = { enabled = false },
    },
  },

  -- 3) Copilot Chat Agent UI: đọc file, so sánh, sinh diff & patch
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatAgents" },
    dependencies = {
      "github/copilot.vim",
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
    },
    opts = {
      -- agent mặc định (chọn số trong :CopilotChatAgents),
      default_agent = "none",
      -- layout
      window = {
        layout   = "vertical",
        position = "right",
        width    = 0.4,
      },
      -- tự động lấy context file, git-diff, con trỏ
      providers = { "file", "git_diff", "cursor" },
      -- phím apply diff hunk
      mappings = {
        apply = "<leader>ca",
        next  = "<leader>cn",
        prev  = "<leader>cp",
      },
    },
    -- thêm sẵn lệnh AIFix & AICompare
    config = function(_, opts)
      require("CopilotChat").setup(opts)

      vim.api.nvim_create_user_command("AIFix", function()
        require("CopilotChat").open(
          "Analyze the current buffer and suggest code improvements with patch.",
          { context = { buffer = vim.api.nvim_get_current_buf() } }
        )
      end, { desc = "AI: Analyze & fix buffer" })

      vim.api.nvim_create_user_command("AICompare", function()
        require("CopilotChat").open(
          "Generate diff comparing current buffer with best practice refactor.",
          { context = { buffer = vim.api.nvim_get_current_buf() } }
        )
      end, { desc = "AI: Generate refactor diff" })
    end,
  },
}
