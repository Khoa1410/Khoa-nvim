local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- Đường dẫn đến lldb-vscode
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- Optional: Cho C và Rust dùng chung cấu hình
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

