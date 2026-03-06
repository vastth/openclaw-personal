# OpenClaw 个人工作区

这是一个以 `OpenClaw` 为核心的个人工作区仓库，主要用于沉淀本地代理配置、双 Agent 协作规则、项目级指令模板，以及面向日常使用的文档规范。

## 仓库目标

- 沉淀 `Copilot` 与 `Claude Code` 的双 Agent 协作机制。
- 统一项目级规则、交接模板、验证标准与审查标准。
- 保留可公开分享的说明、模板和脚本，同时避免推送本地密钥、会话和运行态数据。

## 当前包含的内容

- `.claude/`：Claude Code 项目级规则、命令、hooks、subagents。
- `.github/copilot-instructions.md`：Copilot 项目级指令。
- `docs/`：协作协议、handoff、标准文档、分析文档。
- `completions/`：OpenClaw 命令补全脚本。
- `gateway.cmd`：本地网关启动脚本。
- `openclaw.example.json`：可公开分享的配置示例文件。

## 中文优先约定

- 两个 Agent 在与你交互时，默认尽量使用中文。
- 新增或维护的 Markdown 文档、handoff、验证报告默认使用中文。
- 代码注释默认优先使用中文。
- 命令、路径、环境变量、配置 key、协议字段和固定术语保持原文。

## 不会推送到 GitHub 的内容

以下本地内容已通过 `.gitignore` 排除：

- 真实配置与密钥：`openclaw.json`、`.claude/settings.local.json`
- 凭据与身份信息：`credentials/`、`identity/`
- 运行态数据：`logs/`、`memory/`、`agents/*/sessions/`
- 嵌套工作区：`workspace/`、`workspace-analyst/`

## 快速开始

1. 先阅读 `docs/AGENT_COLLAB_PROTOCOL.md`。
2. 查看 `docs/TASK_BOARD.md` 了解当前任务状态。
3. 阅读最新的 `docs/handoffs/` 获取最近变更上下文。
4. 如需本地运行，参考 `openclaw.example.json` 创建自己的 `openclaw.json`。

## 相关文档

- `CLAUDE.md`
- `.github/copilot-instructions.md`
- `docs/HANDOFF_NOTE_TEMPLATE.md`
- `docs/standards/README.md`

## 说明

本仓库以个人使用与协作流程沉淀为主，不包含所有本地运行态文件。若需完整运行环境，请在本地根据示例配置补齐自己的密钥与渠道配置。