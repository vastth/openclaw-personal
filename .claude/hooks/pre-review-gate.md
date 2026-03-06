# Review 前置门禁 Hook

在 Claude Code 将任何任务从 REVIEW 推进到 DONE 之前自动触发的检查。

## 触发条件

当 Claude Code 即将修改 `TASK_BOARD.md` 中某任务为 `DONE` 状态时。

## 检查内容

1. **handoff 记录存在？** — 当日 `docs/handoffs/YYYY-MM-DD.md` 中有该任务的交接记录。
2. **`/oc-review` 已执行？** — 当前会话中已输出过该任务的审查报告。
3. **无 Critical 问题？** — 审查报告中 Critical 栏为"无"。
4. **验证记录存在？** — handoff 中有至少 1 条验证命令 + 结果。

## 未通过时行为

- 输出缺失项提示，阻止推进 DONE。
- 建议先补全缺失内容再重试。

```
[Pre-Review Gate] BLOCKED
缺失项:
  - [ ] /oc-review 报告未找到
  - [ ] handoff 中无验证记录
请先完成上述检查再推进 DONE。
```
