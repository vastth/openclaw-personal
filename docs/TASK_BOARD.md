# Task Board (Copilot <-> Claude)

说明:

- 一个任务同一时间只能有一个 Owner Agent。
- 改状态前后都要更新时间。
- 切换 Owner 时必须追加 handoff 记录。

| Task ID | Title | Owner Agent | Status | File Lock | Updated At | Notes |
|---|---|---|---|---|---|---|
| OC-001 | 模型路由策略优化 | — | TODO | `openclaw.json` | 2026-03-05 | 待规划具体策略 |
| OC-002 | 网关启动参数清理 | — | TODO | `gateway.cmd` | 2026-03-05 | 待 Copilot 执行 |
| OC-003 | 文档与配置对齐检查 | — | TODO | `docs/**` | 2026-03-05 | 待 Claude Code 执行 |
| OC-004 | 构建 `.claude` 并本土化整合协作规范 | Claude Code | DONE | `.claude/**`, `docs/**`, `CLAUDE.md` | 2026-03-05 | 第一版落地完成 |
| OC-005 | 配置 Claude 本地代理 settings.local.json | Copilot | DONE | `.claude/settings.local.json` | 2026-03-05 | JSON/网关验证通过 |
| OC-006 | everything-claude-code 本土化第二版 | Claude Code | DONE | `.claude/rules/**`, `.claude/commands/**`, `CLAUDE.md` | 2026-03-06 | roles/coding-style/security 规则 + oc-review/oc-checkpoint 命令 |
| OC-007 | 五层架构本土化（Skills/Hooks/Subagents/MCP/Plugins） | Claude Code | DONE | `.claude/**`, `.github/**`, `docs/standards/**` | 2026-03-06 | 共享标准层 + hooks + subagents + copilot 指令同步 |
| OC-008 | 双向角色模型重构（模式 A/B） | Claude Code | DONE | `.claude/rules/**`, `.claude/commands/**`, `CLAUDE.md`, `.github/**` | 2026-03-06 | 角色不固定 → 模式 A（Copilot 实现）+ 模式 B（Claude Code 架构） |
| OC-009 | 同步 Claude Code 架构改动归档 | Copilot | DONE | `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-06.md` | 2026-03-06 | 归档 OC-006/007/008 变更要点与验证口径 |
| OC-010 | 安全清理并准备 GitHub 推送 | Copilot | DONE | `.gitignore`, `openclaw.example.json`, `docs/**` | 2026-03-06 | 已初始化 git 并完成安全首提，等待创建 GitHub 远程 |

## Status Legend

- `TODO`: 未开始
- `IN_PROGRESS`: 进行中
- `BLOCKED`: 阻塞
- `REVIEW`: 待复核
- `DONE`: 完成
