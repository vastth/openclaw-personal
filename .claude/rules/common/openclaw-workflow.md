# OpenClaw 工作流规则

适用范围: 本仓库所有开发任务。

## 开始编码前必须完成

1. 读取 `docs/AGENT_COLLAB_PROTOCOL.md`。
2. 读取 `docs/TASK_BOARD.md` 与当日 active handoff：`docs/handoffs/YYYY-MM-DD.md`。
3. 如 active 信息不足，再按任务 ID 读取 `docs/handoffs/archive/YYYY-MM-DD.md` 中对应完整记录。
4. 将目标任务置为 `IN_PROGRESS` 并标注 Owner Agent。

## 交接前必须完成

1. 任务状态更新为 `REVIEW` 或 `DONE`。
2. 刷新 `docs/handoffs/YYYY-MM-DD.md` 中该任务的最小状态。
3. 追加完整记录到 `docs/handoffs/archive/YYYY-MM-DD.md`。
4. handoff 至少包含: 改动文件、验证结果、风险、下一条命令。

## 文件锁纪律

- 文件被其他 Agent 锁定时，不得修改。
- 如需接管，先更新 `TASK_BOARD.md`，再执行代码变更。
