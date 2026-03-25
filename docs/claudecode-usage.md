# Claude Code Neovim 使用文档

## 简介

本文档介绍如何在 Neovim 中使用 `claudecode.nvim` 插件来集成 Claude Code CLI。

## 前置要求

1. **安装 Claude Code CLI**
   ```bash
   # 方式1: 使用 npm
   npm install -g @anthropic-ai/claude-code

   # 方式2: 使用官方安装脚本
   curl -fsSL https://claude.ai/install.sh | bash
   ```

2. **验证安装**
   ```bash
   which claude
   claude --version
   ```

3. **登录 Claude Code**
   ```bash
   claude login
   ```

## 快捷键参考

### 基础操作

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>cc` | n, x | 打开/切换 Claude Code 窗口 |
| `<leader>cf` | n | 聚焦 Claude Code 窗口 |
| `<leader>cr` | n | 恢复 Claude 会话 |
| `<leader>cR` | n | 继续 Claude 会话 |
| `<leader>cm` | n | 选择 Claude 模型 |

### 上下文操作

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>cb` | n | 将当前缓冲区添加到 Claude 上下文 |
| `<leader>cs` | v | 发送可视选择到 Claude |

### 差异处理

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>ca` | n | 接受 Claude 的差异修改 |
| `<leader>cd` | n | 拒绝 Claude 的差异修改 |

## 命令参考

### 核心命令

| 命令 | 功能 |
|------|------|
| `:ClaudeCode` | 打开/切换 Claude Code 窗口 |
| `:ClaudeCodeFocus` | 聚焦 Claude Code 窗口 |
| `:ClaudeCode --resume` | 恢复之前的会话 |
| `:ClaudeCode --continue` | 继续当前会话 |

### 上下文命令

| 命令 | 功能 |
|------|------|
| `:ClaudeCodeAdd <file>` | 添加文件到 Claude 上下文 |
| `:ClaudeCodeAdd %` | 添加当前缓冲区到上下文 |
| `:ClaudeCodeSend` | 发送可视选择到 Claude |

### 差异命令

| 命令 | 功能 |
|------|------|
| `:ClaudeCodeDiffAccept` | 接受差异修改 |
| `:ClaudeCodeDiffDeny` | 拒绝差异修改 |

### 其他命令

| 命令 | 功能 |
|------|------|
| `:ClaudeCodeSelectModel` | 选择 Claude 模型 |

## 使用流程

### 1. 启动 Claude Code

```
<leader>cc
```

这会在右侧打开 Claude Code 终端窗口。

### 2. 发送代码上下文

方式1 - 发送当前文件：
```
<leader>cb
```

方式2 - 发送选中的代码：
1. 进入可视模式 (`v`) 选择代码
2. 按 `<leader>cs`

### 3. 与 Claude 对话

在 Claude Code 窗口中直接输入指令，例如：
- "解释这段代码"
- "优化这个函数的性能"
- "给这段代码添加注释"

### 4. 处理代码修改

当 Claude 提出代码修改时：
- 查看差异对比
- 按 `<leader>ca` 接受修改
- 或按 `<leader>cd` 拒绝修改

## 配置说明

插件配置文件位于：`~/.config/nvim/lua/plugins/claudecode.lua`

### 可配置的选项

| 选项 | 默认值 | 说明 |
|------|--------|------|
| `log_level` | `"info"` | 日志级别 |
| `auto_start` | `true` | 自动启动 Claude Code 连接 |
| `terminal.split_side` | `"right"` | 终端分割方向 |
| `terminal.split_width_percentage` | `0.35` | 终端宽度占比 |
| `terminal.provider` | `"auto"` | 终端提供者 |
| `diff_opts.layout` | `"vertical"` | 差异对比布局 |

## 故障排除

### Claude Code 无法连接

1. 检查 Claude Code CLI 是否安装：
   ```bash
   which claude
   ```

2. 检查是否已登录：
   ```bash
   claude login
   ```

3. 查看插件日志：
   ```
   :ClaudeCodeStatus
   ```

### 快捷键无效

检查是否有其他插件占用了相同的快捷键。可以通过以下命令查看快捷键映射：
```
:map <leader>cc
```

### 终端显示异常

尝试修改终端提供者：
```lua
terminal = {
  provider = "native", -- 或 "snacks"
}
```

## 参考资料

- [claudecode.nvim 官方仓库](https://github.com/coder/claudecode.nvim)
- [Claude Code 官方文档](https://docs.anthropic.com/en/docs/claude-code/overview)
- [MCP 协议文档](https://modelcontextprotocol.io/)
