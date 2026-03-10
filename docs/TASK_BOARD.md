# 任务看板（Copilot <-> Claude）

说明:

- 一个任务同一时间只能有一个 Owner Agent。
- 改状态前后都要更新时间。
- 切换 Owner 时必须追加 handoff 记录。

| 任务 ID | 标题 | Owner Agent | 状态 | 文件锁 | 更新时间 | 备注 |
|---|---|---|---|---|---|---|
| OC-001 | 模型路由策略优化 | Claude Code | DONE | `openclaw.json`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-07.md`, `docs/handoffs/archive/2026-03-07.md` | 2026-03-07 | /oc-review PASS WITH NOTES：H-1 注释矛盾已修正；M-1/M-2 记录在案，不阻断 |
| OC-002 | 网关启动参数清理 | — | TODO | `gateway.cmd` | 2026-03-05 | 待 Copilot 执行 |
| OC-003 | 文档与配置对齐检查 | Copilot | REVIEW | `docs/**` | 2026-03-09 | 已同步 2026.3.8 升级状态，修正 `docs/OpenClaw_全景认知地图_v2.md` 过时信息，并给出当前 level 判定 |
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
| OC-021 | Claw 自管理与自升级能力落地 | Claude Code | DONE | `exec-approvals.json`, `workspace/AGENTS.md`, `workspace/SOUL.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | /oc-review PASS WITH NOTES：H-1（npm.cmd 缺 id）+ H-2（npm 执行面过广）已记录，不阻断 |
| OC-022 | 主脑路由收敛与重任务 Agent 预留 | Claude Code | DONE | `openclaw.json`, `docs/CONFIG_GUIDE.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | /oc-review PASS WITH NOTES：H-3（heavy 共享 workspace）已记录，maxConcurrent=1 当前缓解 |
| OC-023 | 修正插件查询误用消息工具 | Claude Code | DONE | `workspace/AGENTS.md`, `workspace/SOUL.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | /oc-review PASS WITH NOTES：M-3（提示词护栏非底层修复）已知，不阻断 |
| OC-024 | 配置私密层与分层改造落地 | Claude Code | DONE | `openclaw.json`, `openclaw.base.example.json`, `openclaw.private.example.json`, `scripts/**`, `.gitignore`, `docs/**` | 2026-03-08 | /oc-review PASS WITH NOTES：M-1（缺 schema 校验）+ M-2（示例含绝对路径）已记录，不阻断 |
| OC-025 | gateway 启动前自动合成配置 | Copilot | REVIEW | `gateway.cmd`, `scripts/**`, `docs/**` | 2026-03-08 | 已补官方更新 / repair 后复核清单；当前已知副作用仅为 `gateway status` 的 non-standard 提示 |
| OC-026 | WebUI 汉化补丁脚本化与源码恢复 | Copilot | REVIEW | `scripts/openclaw-webui-zh-patch.ps1`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md`, `C:/Users/Administrator/AppData/Roaming/npm/node_modules/openclaw/dist/control-ui/assets/index-Qb3PJV7U.js` | 2026-03-08 | 已确认本机安装 bundle 当前 `markerHits=0`，本地汉化补丁内容已移除，后续如需汉化优先改走 userscript 路线 |
| OC-027 | Control UI 汉化 userscript 本地固化 | Copilot | REVIEW | `docs/OpenClaw Control UI 汉化说明文档.txt`, `docs/汉化/openclaw-control-ui-zh-local.user.js`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | 用户已在 Tampermonkey 验证本地固定版 userscript 生效；当前保留 userscript 路线，停用本地 bundle 补丁路线 |
| OC-028 | WebUI 汉化 skill 固化并清理 bundle patch | Copilot | REVIEW | `workspace/skills/webui-localization-userscript/SKILL.md`, `docs/OpenClaw Control UI 汉化说明文档.txt`, `scripts/openclaw-webui-zh-patch.ps1`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | 已新增可复用 skill，删除仓库内 bundle patch 脚本，并将当前说明路线收口为 Tampermonkey + 本地固定 userscript |
| OC-029 | userscript 未翻译抓取与增量维护 | Copilot | REVIEW | `docs/汉化/openclaw-control-ui-zh-local.user.js`, `docs/汉化/openclaw-control-ui-zh-scan.user.js`, `docs/汉化/openclaw-control-ui-zh-scan-full.user.js`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-09.md`, `docs/handoffs/archive/2026-03-09.md` | 2026-03-09 | 基于全量英文扫描补充 170+ 条新翻译；涵盖配置字段、认证授权、语音媒体、模型提供商配置和 ACP 相关模块；已验证无语法错误 |
| OC-030 | 漏翻扫描版 userscript | Copilot | REVIEW | `docs/汉化/openclaw-control-ui-zh-scan.user.js`, `docs/OpenClaw Control UI 汉化说明文档.txt`, `docs/汉化/OpenClaw Control UI 汉化说明文档.md`, `workspace/skills/webui-localization-userscript/SKILL.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-08.md`, `docs/handoffs/archive/2026-03-08.md` | 2026-03-08 | 已新增独立扫描版 userscript，提供页面内扫描面板和 JSON 复制能力；不修改当前稳定汉化版 |
| OC-031 | 同步 OpenClaw 官方最新版并保留本机备份 | Copilot | REVIEW | `openclaw.json`, `openclaw.private.json`, `gateway.cmd`, `docs/**`, `C:/Users/Administrator/AppData/Roaming/npm/node_modules/openclaw/**` | 2026-03-09 | 已升级到 OpenClaw 2026.3.8；已完成计划任务实际重启，`RPC probe: ok`、Dashboard HTTP 200；启动后最新日志未见隐藏报错；`gateway status` 的 non-standard 提示仍来自自定义 `gateway.cmd` 路线 |
| OC-032 | Level 2 read/write 边界落地 | Copilot | REVIEW | `openclaw.base.example.json`, `openclaw.json`, `docs/OpenClaw_全景认知地图_v2.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-09.md`, `docs/handoffs/archive/2026-03-09.md` | 2026-03-09 | 已落地 `read/write` + `tools.fs.workspaceOnly=true`；文档已明确 workspace 边界与 sandbox 边界区别；配置校验通过，网关重载后 `RPC probe: ok`；已补真实会话 smoke test，确认 workspace 内 `read/write` 可用、`../` 越界写入被拒绝 |
| OC-033 | 云主脑切换与 Level 8-beta 基础通电 | Copilot | REVIEW | `openclaw.base.example.json`, `openclaw.json`, `workspace/AGENTS.md`, `workspace/SOUL.md`, `docs/CONFIG_GUIDE.md`, `docs/OpenClaw_全景认知地图_v2.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-09.md`, `docs/handoffs/archive/2026-03-09.md`, `cron/jobs.json` | 2026-03-09 | 已补首条可用低风险 cron 作业：main/systemEvent job `8f4a51b7-40f5-401f-b6f0-231e431e4650` 手动 run 成功并记录 `status: ok`；同时将两次超时的 isolated agentTurn job `2e48e44c-07fc-4267-8b01-76fb6dc9c463` 禁用收口 |
| OC-034 | 多 agent 最小权限分权一期 | Copilot | REVIEW | `openclaw.base.example.json`, `openclaw.private.json`, `openclaw.json`, `scripts/**`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-09.md`, `docs/handoffs/archive/2026-03-09.md` | 2026-03-09 | 已完成阶段 1：收回全局 `group:fs/runtime/automation/memory` + `browser/canvas/nodes`；显式写开 main/scout/builder 的 workspace 与 agentDir；main 预留 `sessions_spawn`；builder 仅建空壳且未启用 sandbox/写执行权限 |
| OC-035 | builder 专属 sandbox 二期 | Claude Code | DONE | `openclaw.base.example.json`, `openclaw.json`, `scripts/openclaw-phase2-audit.ps1`, `scripts/openclaw-phase2-rollback.ps1`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-10.md`, `docs/handoffs/archive/2026-03-10.md` | 2026-03-10 | /oc-review PASS WITH NOTES：无 Critical/High；M-1～M-6（注释缺失/冗余 deny/路径硬编码/rollback 无 Set-Location/文件锁文档不一致）记录在案，不阻断；后续已补齐 `openclaw-sandbox:bookworm-slim` 与 `openclaw-sandbox-browser:bookworm-slim`，并完成容器烟测 |
| OC-036 | secrets 收口一期 | Claude Code | DONE | `gateway.cmd`, `openclaw.base.example.json`, `openclaw.private.json`, `openclaw.json`, `agents/main/agent/auth-profiles.json`, `agents/builder/agent/auth-profiles.json`, `agents/heavy/agent/auth-profiles.json`, `agents/main/agent/models.json`, `agents/analyst/agent/models.json`, `agents/builder/agent/models.json`, `.env`, `scripts/openclaw-secrets-phase1-audit.ps1`, `backups/2026-03-10-secrets-phase1-dry-run-plan.json`, `docs/analysis/OC-036_SECRETS_PHASE1.md`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-10.md`, `docs/handoffs/archive/2026-03-10.md` | 2026-03-10 | /oc-review PASS WITH NOTES：无 Critical/High；M-1（backups/ 未入 .gitignore）+ M-2（main/models.json 残留裸字符串 apiKey）+ M-3（private.example.json 示例过时）记录在案，不阻断 |
| OC-037 | secrets 收口尾项修复 | Claude Code | DONE | `.gitignore`, `agents/main/agent/models.json`, `openclaw.private.example.json`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-10.md`, `docs/handoffs/archive/2026-03-10.md` | 2026-03-10 | /oc-review PASS WITH NOTES：无 Critical/High；M-1（`.gitignore`）✓，M-3（`private.example.json`）✓；M-2（`models.json`）audit=clean 但字段移除未能持久（OpenClaw 疑似回写）；M-1（OC-037）记录在案，不阻断 |
| OC-038 | 备份源码嵌套 Git 失活与 SCM 收口 | Copilot | REVIEW | `scripts/disable-backup-nested-git.ps1`, `docs/TASK_BOARD.md`, `docs/handoffs/2026-03-10.md`, `docs/handoffs/archive/2026-03-10.md`, `backups/2026-03-10-openclaw-upstream-src/.git.disabled-*` | 2026-03-10 | 已定位并失活 `backups/2026-03-10-openclaw-upstream-src/.git`，新增可复用脚本；主仓库真实待提交集未受 `backups/` 影响，待 Claude Code /oc-review OC-038 |
## 状态说明

- `TODO`: 未开始
- `IN_PROGRESS`: 进行中
- `BLOCKED`: 阻塞
- `REVIEW`: 待复核
- `DONE`: 完成
