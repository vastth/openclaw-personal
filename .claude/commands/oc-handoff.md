# /oc-handoff

将当前任务打包为下一位 Agent 可立即接手的交接记录。

## Steps

1. 更新 `docs/TASK_BOARD.md` 状态与时间。
2. 追加 `docs/handoffs/YYYY-MM-DD.md`。
3. 使用 `docs/HANDOFF_NOTE_TEMPLATE.md` 的结构。

## Must Include

- Task ID / Title / Status
- Files Changed
- Validation Commands + Results
- Risks + Rollback Point
- Next Action (exact first command)
