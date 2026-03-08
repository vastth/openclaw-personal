# 任务看板（Copilot <-> Claude）

说明:

- 一个任务同一时间只能有一个 Owner Agent。
- 改状态前后都要更新时间。
- 切换 Owner 时必须追加 handoff 记录。

| 任务 ID | 标题 | Owner Agent | 状态 | 文件锁 | 更新时间 | 备注 |
|---|---|---|---|---|---|---|
| OC-001 | 模型路由策略优化 | Claude Code | DONE | `openclaw.json`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-07.md`, `docs/handoffs/archive/2026-03-07.md` | 2026-03-07 | /oc-review PASS WITH NOTES：H-1 注释矛盾已修正；M-1/M-2 记录在案，不阻断 |
| OC-002 | 网关启动参数清理 | — | TODO | `gateway.cmd` | 2026-03-05 | 待 Copilot 执行 |
| OC-003 | 文档与配置对齐检查 | — | TODO | `docs/**` | 2026-03-05 | 待 Claude Code 执行 |
| OC-004 | 构建 `.claude` 并本土化整合协作规范 | Claude Code | DONE | `.claude/**`, `docs/**`, `CLAUDE.md` | 2026-03-05 | 第一版落地完成 |
| OC-005 | 配置 Claude 本地代理 settings.local.json | Copilot | DONE | `.claude/settings.local.json` | 2026-03-05 | JSON/网关验证通过 |
| OC-006 | everything-claude-code 本土化第二版 | Claude Code | DONE | `.claude/rules/**`, `.claude/commands/**`, `CLAUDE.md` | 2026-03-06 | roles/coding-style/security 规则 + oc-review/oc-checkpoint 命令 |
| OC-007 | 五层架构本土化（Skills/Hooks/Subagents/MCP/Plugins） | Claude Code | DONE | `.claude/**`, `.github/**`, `docs/standards/**` | 2026-03-06 | 共享标准层 + hooks + subagents + copilot 指令同步 |
| OC-008 | 双向角色模型重构（模式 A/B） | Claude Code | DONE | `.claude/rules/**`, `.claude/commands/**`, `CLAUDE.md`, `.github/**` | 2026-03-06 | 角色不固定 → 模式 A（Copilot 实现）+ 模式 B（Claude Code 架构） |
| OC-009 | 同步 Claude Code 架构改动归档 | Copilot | DONE | `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-06.md` | 2026-03-06 | 归档 OC-006/007/008 变更要点与验证口径 |
| OC-010 | 安全清理并准备 GitHub 推送 | Copilot | DONE | `.gitignore`, `openclaw.example.json`, `docs/**` | 2026-03-06 | 已初始化 git 并完成安全首提，等待创建 GitHub 远程 |
| OC-011 | 项目可汉化内容整理与中文优先约束 | Copilot | DONE | `CLAUDE.md`, `.github/**`, `.claude/**`, `docs/**` | 2026-03-06 | 已汉化关键说明与模板，并将两个 agent 默认中文要求写入规则 |
| OC-012 | README 中文首页与 Markdown 持续汉化 | Copilot | DONE | `README.md`, `docs/**`, `.claude/**` | 2026-03-06 | 已补中文首页、继续汉化高频 Markdown，并统一 handoff 中文字段风格 |
| OC-013 | 跨设备克隆部署说明落地 | Copilot | DONE | `README.md`, `docs/**` | 2026-03-06 | 已补跨设备部署指南，使仓库可作为新设备部署基座 |
| OC-014 | Web 浏览检索与回传能力接入 | Claude Code | DONE | `openclaw.json`, `openclaw.example.json`, `workspace/**`, `README.md`, `docs/**` | 2026-03-06 | 配置 tools.web + browser；AGENTS.md 写入三工具选择逻辑；Copilot 完成主体，Claude Code 收尾 |
| OC-015 | .claude 框架补全（Hooks/Subagents/MCP 对齐 ECC） | Claude Code | DONE | `.claude/settings.json`, `.claude/agents/**`, `.claude/hooks/**`, `.claude/commands/oc-review.md` | 2026-03-06 | /oc-validate 复验通过：GitHub MCP 包名修正为 @modelcontextprotocol/server-github 后可启动 |
| OC-016 | handoff active/archive 双层结构重构 | Copilot | DONE | `docs/handoffs/**`, `docs/AGENT_COLLAB_PROTOCOL.md`, `docs/HANDOFF_NOTE_TEMPLATE.md`, `.claude/hooks/session-start.md`, `.claude/settings.json`, `.claude/rules/common/openclaw-workflow.md`, `README.md`, `CLAUDE.md`, `.github/copilot-instructions.md` | 2026-03-06 | /oc-review PASS WITH NOTES：双层结构落地正确，M-1（CLAUDE.md 第3步表述）可后续修复 |
| OC-017 | 记录网页回传验证结论 | Copilot | DONE | `README.md`, `docs/handoffs/**`, `docs/TASK_BOARD.md` | 2026-03-06 | /oc-review PASS：纯文档变更，无 Critical/High 问题 |
| OC-018 | 创建 docs/CONFIG_GUIDE.md | Copilot | DONE | `docs/CONFIG_GUIDE.md` | 2026-03-06 | Copilot 直审通过：配置字段说明与当前示例配置一致，无阻塞问题 |
| OC-019 | 补充运行时目录说明 | Copilot | DONE | `docs/**` | 2026-03-06 | Copilot 直审通过：运行时目录说明与当前仓库结构一致，无阻塞问题 || OC-020 | OpenClaw 主脑切换为 qwen2.5:7b | Claude Code | DONE | `openclaw.json`, `工作站context.md` | 2026-03-07 | qwen3.5:9b VRAM 溢出、deepseek-r1:8b 不支持 tool call，最终定型 qwen2.5:7b； embedded 路径验证 PASS |
| OC-021 | Claw 自管理与自升级能力落地 | Copilot | REVIEW | `exec-approvals.json`, `workspace/AGENTS.md`, `workspace/SOUL.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | 已补 exec allowlist（openclaw + npm）与自管理工作流，待 Claude Code `/oc-review` |
| OC-022 | 主脑路由收敛与重任务 Agent 预留 | Copilot | REVIEW | `openclaw.json`, `docs/CONFIG_GUIDE.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | 已切 default compaction、保留 qwen2.5:7b 为 main、新增 heavy 云端 agent，并预留 memorySearch 配置位，待 Claude Code `/oc-review` |
| OC-023 | 修正插件查询误用消息工具 | Copilot | REVIEW | `workspace/AGENTS.md`, `workspace/SOUL.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | 已约束本地命令不得伪装成聊天消息；定位根因为 `message` 工具缺少 `action` 参数，待 Claude Code `/oc-review` |
## 状态说明

- `TODO`: 未开始
- `IN_PROGRESS`: 进行中
- `BLOCKED`: 阻塞
- `REVIEW`: 待复核
- `DONE`: 完成
