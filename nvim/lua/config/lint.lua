return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Gán linter theo loại file
    lint.linters_by_ft = {
      python = { "flake8" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      cpp = { "cpplint" },
    }

    -- Tự động lint khi lưu file
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })

    -- Phím tắt để lint thủ công
    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Lint current file" })
  end,
}

