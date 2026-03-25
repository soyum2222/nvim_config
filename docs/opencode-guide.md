# Opencode.nvim 使用指南

## 🚀 快速开始

### 1. 基本使用
由于 opencode 服务器模式存在权限问题，我们配置了 TUI 模式：

```vim
" 打开 opencode TUI
:OpencodeToggle

" 或者使用快捷键
<C-.>
```

### 2. AI 对话快捷键

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `<C-a>` | 与 AI 对话 | 分析当前选择或光标位置的代码 |
| `<C-x>` | AI 动作菜单 | 选择预设的 AI 动作 |
| `<C-.>` | 切换 opencode | 显示/隐藏 opencode 终端 |
| `go` | 添加范围到 AI | 操作符模式，支持 `goj`（当前行）等 |

### 3. 专用功能快捷键

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `<leader>or` | 代码审查 | 让 AI 审查代码质量 |
| `<leader>oe` | 代码解释 | 解释代码的功能和逻辑 |
| `<leader>of` | 修复问题 | 修复诊断错误 |
| `<leader>od` | 添加文档 | 生成代码注释和文档 |

### 4. 命令行使用

```vim
" 询问 AI
:OpencodeAsk 解释这段代码的作用

" 切换终端
:OpencodeToggle

" 选择动作
:OpencodeSelect
```

## 🔧 故障排除

### 如果遇到连接问题：

1. **检查 opencode 是否已安装**：
   ```bash
   which opencode
   opencode --version
   ```

2. **手动启动 opencode**：
   ```bash
   # 在项目目录下启动
   cd /path/to/your/project
   opencode --port
   ```

3. **检查权限**：
   ```bash
   # 检查 opencode 数据目录权限
   ls -la ~/.local/share/opencode/
   
   # 如果需要，修复权限
   chmod 755 ~/.local/share/opencode/
   ```

### 常见问题：

**Q: 提示 "Response decode error: 404 page not found"**
A: opencode 服务器未正确启动，尝试手动运行 `opencode --port`

**Q: 提示 "Blocked by sandbox network policy"**
A: 网络权限问题，通常在手动启动 opencode 后可以解决

**Q: 数据库权限错误**
A: 运行 `chmod 644 ~/.local/share/opencode/opencode.db*`

## 💡 使用技巧

1. **上下文感知**：
   - 在视觉模式下选择代码再按 `<C-a>` 可以让 AI 分析特定代码块
   - 使用 `@buffer` 让 AI 分析整个文件
   - 使用 `@diagnostics` 让 AI 修复当前错误

2. **自定义 Prompts**：
   配置文件中已包含一些预设的 prompts，你可以根据需要添加更多

3. **与 LSP 结合**：
   opencode 可以理解 LSP 诊断信息，结合现有的 gopls、ts_ls 等效果更佳

## 📚 相关链接

- [opencode 官方文档](https://github.com/opencoding-community/opencode)
- [opencode.nvim GitHub](https://github.com/nickjvandyke/opencode.nvim)