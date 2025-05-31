#  Khoa-nvim

Cấu hình tối ưu cho Neovim sử dụng Lazy.nvim — đơn giản, mạnh mẽ và nhanh chóng!

---


- `trương trình điều kiện` (có thể bạn muốn nói đến "trình biên dịch" hoặc "logic điều kiện"?)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep): Tìm kiếm siêu nhanh trong project
- [`fzf`](https://github.com/junegunn/fzf): Fuzzy finder trong terminal
- [`pylint`](https://github.com/pylint-dev/pylint): Kiểm tra code Python
- [`cpplint`](https://github.com/cpplint/cpplint): Kiểm tra code C++
- [`eslint_d`](https://github.com/mantoni/eslint_d.js): Kiểm tra code JavaScript nhanh chóng
- [`lazygit`](https://github.com/jesseduffield/lazygit): Giao diện git nhẹ và đẹp

---

## 🎨 Theme


```lua
vim.opt.rtp:append("~/.config/nvim/theme/strawberry")
require("theme.strawberry").setup()

