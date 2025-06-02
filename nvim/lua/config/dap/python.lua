require("dap").configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch with args",
    program = "${file}",
    args = function()
      local input = vim.fn.input("Args: ")
      return vim.fn.split(input, " ", true)
    end,
    console = "integratedTerminal",
  },
}

