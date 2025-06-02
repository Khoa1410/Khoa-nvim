local dap = require("dap")
local dapui = require("dapui")

-- Tự động mở UI khi bắt đầu debug
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Tự động đóng UI khi kết thúc debug
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
-- Cấu hình dap-ui



-- Cấu hình dap-ui cho javascript

require("config.dap.javascript")


-- Cấu hình dap-ui cho Python
require("config.dap.python")

