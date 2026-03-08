# OpenClaw 个人工作区

这是一个以 `OpenClaw` 为核心的个人工作区仓库，主要用于沉淀本地代理配置、双 Agent 协作规则、项目级指令模板，以及面向日常使用的文档规范。

## 仓库目标

- 沉淀 `Copilot` 与 `Claude Code` 的双 Agent 协作机制。
- 统一项目级规则、交接模板、验证标准与审查标准。
- 保留可公开分享的说明、模板和脚本，同时避免推送本地密钥、会话和运行态数据。

## 当前包含的内容

- `.claude/`：Claude Code 项目级规则、命令、hooks、subagents。
- `.github/copilot-instructions.md`：Copilot 项目级指令。
- `docs/`：协作协议、handoff active/archive、标准文档、分析文档。
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
3. 阅读当日 `docs/handoffs/YYYY-MM-DD.md` 获取最小可执行状态；只有在需要追溯历史时再看 `docs/handoffs/archive/`。
4. 如需本地运行，参考 `openclaw.example.json` 创建自己的 `openclaw.json`。

## 跨设备部署

如果你希望把当前仓库克隆到其他设备，并将其作为 OpenClaw 的部署基座使用，建议阅读：

- `docs/DEPLOY_ON_NEW_DEVICE.md`

简化理解：

- Git 仓库负责同步规则、文档、脚本和示例配置
- 新设备本地补齐真实 `openclaw.json`、凭据、身份和代理配置
- 敏感信息与运行态数据不进入 Git，而是单独恢复

## Web 浏览与检索

当前配置已经为 `OpenClaw` 显式接入三类网页能力：

- `browser`：打开和操作网页，适合 JS 站点、需要点击或可视化核验的页面
- `web_fetch`：直接抓取网页正文，适合新闻、博客、文档等静态内容
- `web_search`：联网检索互联网结果，适合先找资料入口再深入阅读

默认策略：

- 先 `web_search` 找入口
- 再用 `web_fetch` 抓正文
- 遇到动态页面、登录态页面或页面抓取失败时，切到 `browser`

注意：

- `browser` 和 `web_fetch` 配置后可直接使用
- `web_search` 仍需要额外配置搜索提供商 API Key，推荐执行 `openclaw configure --section web`
- 如果未配置 `web_search` 的 Key，主工作区中的 agent 指令会让它自动回退到 `browser` 打开网页检索

当前验证结论：

- 当前未配置搜索 API Key，但飞书端已验证 `web_fetch + browser fallback` 可完成联网取数与结果回传。

## 相关文档

- `CLAUDE.md`
- `.github/copilot-instructions.md`
- `docs/HANDOFF_NOTE_TEMPLATE.md`
- `docs/CONFIG_GUIDE.md`
- `docs/RUNTIME_LAYOUT.md`
- `docs/standards/README.md`
- `docs/DEPLOY_ON_NEW_DEVICE.md`

## 说明

本仓库以个人使用与协作流程沉淀为主，不包含所有本地运行态文件。若需完整运行环境，请在本地根据示例配置补齐自己的密钥、身份信息与渠道配置。