# Khoa-nvim

Cấu hình tối ưu cho Neovim sử dụng Lazy.nvim — đơn giản, mạnh mẽ và nhanh chóng!

---

- `trương trình điều kiện nvim >= 0.11.1` (có thể bạn muốn nói đến "trình biên dịch" hoặc "logic điều kiện"?)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep): Tìm kiếm siêu nhanh trong project
- [`fzf`](https://github.com/junegunn/fzf): Fuzzy finder trong terminal
- [`pylint`](https://github.com/pylint-dev/pylint): Kiểm tra code Python
- [`cpplint`](https://github.com/cpplint/cpplint): Kiểm tra code C++
- [`eslint_d`](https://github.com/mantoni/eslint_d.js): Kiểm tra code JavaScript nhanh chóng
- [`lazygit`](https://github.com/jesseduffield/lazygit): Giao diện git nhẹ và đẹp
- [`debugpy`]()
- [`vscode-js-debug`]()
- [`lldb`]()
- [`neovim xclip xsel`]()
- [`xclip xsel`]()

---

## 🎨 Theme

```lua
vim.opt.rtp:append("~/.config/nvim/theme/strawberry")
require("theme.strawberry").setup()

```

```bash
# LUA
cargo install stylua

# Python
pip install black

# JS, TS, HTML, CSS, JSON, Markdown...
npm install -g prettier

# Shell
npm install -g shfmt

#excel viewer
pip install tabulate openpyxl pandas
pip install pandas openpyxl
chmod +x ~/.config/nvim/scripts/xlsx_to_csv.py
cargo install viu




```
