# Session Start Hook

Claude Code 每次会话开始时自动执行的上下文加载流程。

## 自动执行内容

1. 读取 `docs/TASK_BOARD.md`，展示当前任务状态摘要。
2. 读取最新的 `docs/handoffs/` 文件，了解上次交接内容。
3. 检查是否有状态为 `REVIEW` 的任务待审查。
4. 如果有 REVIEW 任务，提示用户是否执行 `/oc-review`。

## 输出格式

```
[Session Start]
TASK_BOARD 摘要:
  IN_PROGRESS: OC-XXX (Owner: Copilot) — 标题
  REVIEW: OC-XXX (Owner: Claude Code) — 标题

最近交接: 2026-03-06 — OC-006 由 Claude Code 完成

待审查: OC-XXX — 是否执行 /oc-review？
```
