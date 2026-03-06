# Copilot Instructions

本仓库使用双 Agent 协作，**角色跟着任务走，不固定**。

## 你有两种角色

### 模式 A（你是实现者）
- 编写代码/配置 → 推 REVIEW → Claude Code 用 `/oc-review` 审查 → DONE。
- 适用：日常功能开发、配置修改、小步重构。

### 模式 B（你是验证者）
- Claude Code 做了架构/大改动 → 推 REVIEW → **你用 `/oc-validate` 验证** → DONE。
- 你的验证重点：实际运行、行为确认、回归检查（不是静态分析）。

**关键规则：REVIEW → DONE 必须经过另一方确认，不允许自审自过。**

## Required Read Order (before coding)

1. `docs/AGENT_COLLAB_PROTOCOL.md`
2. `docs/TASK_BOARD.md`
3. Latest file in `docs/handoffs/`
4. `docs/standards/` — 特别是 `config-conventions.md` 和 `security-checklist.md`

## Must Follow

- Update `docs/TASK_BOARD.md` to `IN_PROGRESS` before any code edits.
- Set one owner per task and respect file locks.
- On transfer, append a handoff record in `docs/handoffs/YYYY-MM-DD.md`.
- Use the task flow: `TODO -> IN_PROGRESS -> REVIEW -> DONE`.
- **作为实现者：REVIEW 前自查 `docs/standards/security-checklist.md`**。
- **作为验证者：按 `/oc-validate` 流程输出验证报告**。

## Coding Standards（作为实现者时）

参见 `docs/standards/` 目录：

- **Config**: `camelCase` key、行内注释、嵌套 ≤4 层、改配置同步文档。
- **Code**: 函数 ≤50 行、文件 ≤400 行、显式错误处理、不提交调试代码。
- **Security**: 不硬编码密钥、不拼接未转义用户输入、不静默失败。

## Validation Focus（作为验证者时）

- 格式验证：JSON/JSON5 可解析、Markdown 结构完整。
- 行为验证：实际运行命令，确认改动可用。
- 回归检查：改动是否影响已有功能。
- 范围检查：改动是否超出 handoff 声明范围。

## For Every Completion

Include:

- Changed files
- What was validated and how
- Self-check against `docs/standards/security-checklist.md` (作为实现者) 或 `/oc-validate` 报告 (作为验证者)
- Known risks
- Exact next command/action for the other agent
