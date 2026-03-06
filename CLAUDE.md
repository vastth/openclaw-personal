# Claude Code 项目指引

本仓库使用双 Agent 协作，**角色跟着任务走，不固定**。

## 两种工作模式

### 模式 A：Copilot 实现 → Claude Code 审查
- Copilot 写代码/改配置 → 推 REVIEW → Claude Code `/oc-review` → DONE
- 适用：日常功能、配置修改、小步重构

### 模式 B：Claude Code 架构 → Copilot 验证
- Claude Code 做架构/大改动 → 推 REVIEW → Copilot `/oc-validate` → DONE
- 适用：架构拓展、跨文件重构、规范建设

**关键规则：REVIEW → DONE 必须经过另一方确认，不允许自审自过。**

## 开始编码前的必读顺序

1. `docs/AGENT_COLLAB_PROTOCOL.md`
2. `docs/TASK_BOARD.md`
3. `docs/handoffs/` 中最新的文件
4. `.claude/README.md`
5. `.claude/rules/common/*.md` — 特别是 `openclaw-roles.md`

## 必须遵守

- 开始编码前，必须先把 `docs/TASK_BOARD.md` 更新为 `IN_PROGRESS` 并标注 Owner。
- 交接时，必须按 `docs/HANDOFF_NOTE_TEMPLATE.md` 追加记录到 `docs/handoffs/YYYY-MM-DD.md`。
- 不得修改 `TASK_BOARD.md` 中被其他 Agent 锁定的文件。
- 任务状态必须遵循：`TODO -> IN_PROGRESS -> REVIEW -> DONE`。
- 优先使用项目级 `.claude/` 配置，不要轻易改全局 `~/.claude`。
- **模式 A：Claude Code 审查 Copilot 的 REVIEW（`/oc-review`）。**
- **模式 B：Copilot 验证 Claude Code 的 REVIEW（`/oc-validate`）。**

## 中文优先约定

- 与用户的自然语言交互、说明、总结、风险提示默认尽量使用中文。
- 新增或更新的 Markdown 文档、handoff、review、验证报告默认使用中文。
- 代码注释默认优先使用中文；若涉及 API 名称、协议字段、配置 key、开源项目原名或业界固定术语，可保留英文。
- 命令、路径、环境变量、配置项 key、协议字段名保持原文，不做强制汉化。
- 若用户明确要求英文，或目标文件本身必须保持英文语境，再按用户要求处理。

## 可用命令

| 命令 | 用途 | 执行者 |
|---|---|---|
| `/oc-plan` | 生成任务执行计划 | 任一 Agent |
| `/oc-review` | 代码审查（静态分析 + 安全扫描） | **Claude Code**（审查 Copilot 的改动） |
| `/oc-validate` | 实操验证（运行 + 行为确认） | **Copilot**（验证 Claude Code 的改动） |
| `/oc-verify` | 轻量自验（实现者完成后自查） | 实现者自己 |
| `/oc-handoff` | 打包交接记录 | 任一 Agent |
| `/oc-checkpoint` | 创建/查看任务存档点 | 任一 Agent |

## 交接输出格式

交接记录至少包含：

- 改动文件
- 验证命令与结果
- 风险与回滚点（可引用 `/oc-checkpoint` 存档点名）
- 给下一位 Agent 的一条立即可执行动作
