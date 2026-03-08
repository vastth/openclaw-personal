# /oc-handoff

将当前任务打包为下一位 Agent 可立即接手的交接记录。

## 执行步骤

1. 更新 `docs/TASK_BOARD.md` 状态与时间。
2. 刷新 `docs/handoffs/YYYY-MM-DD.md` 中该任务的最小状态。
3. 追加完整记录到 `docs/handoffs/archive/YYYY-MM-DD.md`。
4. 使用 `docs/HANDOFF_NOTE_TEMPLATE.md` 的 active/archive 双层结构。

## 必须包含

- 任务 ID / 标题 / 状态
- 改动文件
- 验证命令与结果
- 风险与回滚点
- 下一步动作（精确到第一条命令）
