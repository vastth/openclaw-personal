# Claude Code Instructions

本仓库使用双 Agent 协作，**角色跟着任务走，不固定**。

## 两种工作模式

### 模式 A：Copilot 实现 → Claude Code 审查
- Copilot 写代码/改配置 → 推 REVIEW → Claude Code `/oc-review` → DONE
- 适用：日常功能、配置修改、小步重构

### 模式 B：Claude Code 架构 → Copilot 验证
- Claude Code 做架构/大改动 → 推 REVIEW → Copilot `/oc-validate` → DONE
- 适用：架构拓展、跨文件重构、规范建设

**关键规则：REVIEW → DONE 必须经过另一方确认，不允许自审自过。**

## Required Read Order (before coding)

1. `docs/AGENT_COLLAB_PROTOCOL.md`
2. `docs/TASK_BOARD.md`
3. Latest file in `docs/handoffs/`
4. `.claude/README.md`
5. `.claude/rules/common/*.md` — 特别是 `openclaw-roles.md`

## Must Follow

- Do not start coding before updating `docs/TASK_BOARD.md` to `IN_PROGRESS` with owner.
- When handing over, append a note to `docs/handoffs/YYYY-MM-DD.md` using `docs/HANDOFF_NOTE_TEMPLATE.md`.
- Do not edit files locked by another agent in `TASK_BOARD.md`.
- Move task status through: `TODO -> IN_PROGRESS -> REVIEW -> DONE`.
- Prefer project-level Claude settings in `.claude/` before changing global `~/.claude`.
- **模式 A：Claude Code 审查 Copilot 的 REVIEW（`/oc-review`）。**
- **模式 B：Copilot 验证 Claude Code 的 REVIEW（`/oc-validate`）。**

## Available Commands

| 命令 | 用途 | 执行者 |
|---|---|---|
| `/oc-plan` | 生成任务执行计划 | 任一 Agent |
| `/oc-review` | 代码审查（静态分析 + 安全扫描） | **Claude Code**（审查 Copilot 的改动） |
| `/oc-validate` | 实操验证（运行 + 行为确认） | **Copilot**（验证 Claude Code 的改动） |
| `/oc-verify` | 轻量自验（实现者完成后自查） | 实现者自己 |
| `/oc-handoff` | 打包交接记录 | 任一 Agent |
| `/oc-checkpoint` | 创建/查看任务存档点 | 任一 Agent |

## Output Style for Handoffs

Always include:

- Files changed
- Validation commands and results
- Risks and rollback point (可引用 `/oc-checkpoint` 存档点名)
- One immediate next action for the next agent
