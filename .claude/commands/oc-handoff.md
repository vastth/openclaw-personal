# /oc-handoff

将当前任务打包为下一位 Agent 可立即接手的交接记录。

## 执行步骤

1. 更新 `docs/TASK_BOARD.md` 状态与时间。
2. 追加 `docs/handoffs/YYYY-MM-DD.md`。
3. 使用 `docs/HANDOFF_NOTE_TEMPLATE.md` 的结构。

## 必须包含

- 任务 ID / 标题 / 状态
- 改动文件
- 验证命令与结果
- 风险与回滚点
- 下一步动作（精确到第一条命令）
