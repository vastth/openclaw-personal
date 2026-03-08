# 新设备部署指南

本文档用于指导你将当前仓库克隆到另一台设备，并在新设备上完成 OpenClaw 的本地部署。

## 适用场景

- 新电脑初始化 OpenClaw 环境
- 重装系统后恢复工作区
- 在第二台设备上复用当前协作规则、文档和脚本

## 先理解仓库内容

当前仓库适合作为“部署基座”和“规则资产仓库”，其中包括：

- 项目级规则与命令：`.claude/`、`.github/`
- 协作文档与标准：`docs/`
- 启动脚本与补全脚本：`gateway.cmd`、`completions/`
- 公共配置模板：`openclaw.example.json`

以下内容不会随 Git 同步，需要你在新设备本地自行补齐：

- 真实配置：`openclaw.json`
- 本地代理设置：`.claude/settings.local.json`
- 凭据与身份：`credentials/`、`identity/`
- 运行态数据：`logs/`、`memory/`、`agents/*/sessions/`

## 部署步骤

### 1. 安装基础环境

确保新设备已安装：

- Git
- Node.js
- OpenClaw CLI（若尚未安装，请按你的本地方式安装）
- VS Code（若你要继续使用 Copilot / Claude Code 协作）

### 2. 克隆仓库

```powershell
git clone https://github.com/vastth/openclaw-personal.git
cd openclaw-personal
```

### 3. 创建本地配置文件

将示例配置复制为真实配置：

```powershell
Copy-Item openclaw.example.json openclaw.json
```

然后根据新设备实际情况修改 `openclaw.json`：

- 填入自己的 API Key / Token
- 修改 `workspace` 路径
- 修改 `gateway.auth.token`
- 修改飞书或其他渠道的本地凭据

### 4. 创建本地 Claude 配置（如需要）

如果新设备需要代理或本地差异配置，可新建：

```powershell
Copy-Item .claude\settings.json .claude\settings.local.json
```

然后仅在 `settings.local.json` 中写入本机相关内容，例如：

- `HTTP_PROXY`
- `HTTPS_PROXY`
- `NO_PROXY`
- 本机特有 permissions

注意：`settings.local.json` 不会进入 Git。

### 5. 恢复凭据与身份信息

以下目录需要从旧设备手动迁移或重新登录生成：

- `credentials/`
- `identity/`

如果你不希望直接复制旧设备凭据，也可以在新设备上重新完成登录、绑定或授权流程。

### 6. 验证 OpenClaw 是否可运行

建议至少执行以下检查：

```powershell
openclaw gateway status
openclaw status
```

如果有 VS Code + Agent 协作需求，再额外检查：

- Copilot 是否正常加载 `.github/copilot-instructions.md`
- Claude Code 是否正常读取 `.claude/` 下的规则与命令

## 推荐同步策略

建议将“可同步”和“不可同步”的内容分开管理：

### 适合通过 Git 同步

- 规则
- 文档
- 命令模板
- hooks / subagents
- 示例配置
- 启动脚本

### 适合手动或加密方式同步

- 真实密钥
- 本地身份信息
- 渠道凭据
- 历史会话
- 运行日志

## 推荐做法

1. Git 仓库负责版本管理和部署基座。
2. 真实配置通过手工复制或密码管理器恢复。
3. 本地敏感目录使用加密备份，不进入 Git。

## 最小部署检查清单

- [ ] Git 仓库已克隆
- [ ] `openclaw.json` 已创建并填写真实配置
- [ ] `.claude/settings.local.json` 已按需创建
- [ ] 凭据和身份信息已恢复或重新登录
- [ ] `openclaw gateway status` 通过
- [ ] `openclaw status` 通过
- [ ] VS Code 中 Agent 规则加载正常

## 相关文件

- `README.md`
- `openclaw.example.json`
- `docs/CONFIG_GUIDE.md`
- `docs/RUNTIME_LAYOUT.md`
- `docs/AGENT_COLLAB_PROTOCOL.md`
- `CLAUDE.md`
- `.github/copilot-instructions.md`
