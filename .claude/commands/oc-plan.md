# /oc-plan

为 OpenClaw 任务生成执行计划。

## Input

- 任务目标
- 影响范围（文件/模块）
- 风险点

## Output

1. Task ID 建议与状态变更（写入 `docs/TASK_BOARD.md`）
2. 3-7 步可执行计划
3. 需要的验证命令
4. 交接时必须记录的证据清单

## Constraints

- 计划必须兼容 `TODO -> IN_PROGRESS -> REVIEW -> DONE`。
- 如涉及多 Agent 并行，必须先定义文件锁边界。
