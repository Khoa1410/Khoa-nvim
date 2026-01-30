return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    --  linter 
    lint.linters_by_ft = {
      python = { "flake8" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      cpp = { "cpplint" },
    }

    -- lint when save file
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })

    -- manual
    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Lint current file" })
  end,



local lint = require("lint")

lint.linters_by_ft = {
  python = { "flake8" }, 
}

lint.linters.pylint = {
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

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.py",
  callback = function()
    lint.try_lint()
  end,
})
}

