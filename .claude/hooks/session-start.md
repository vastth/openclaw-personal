# Session Start Hook

Claude Code 每次会话开始时自动执行的上下文加载提醒。

## settings.json 配置

```json
"SessionStart": [
  {
    "matcher": "startup|resume",
    "hooks": [
      {
        "type": "command",
        "command": "echo '[Session Start] Read TASK_BOARD.md. Find your task. Read the last matching active handoff section. Use archive only if more history is needed.'"
      }
    ]
  }
]
```

## 触发条件

- `startup` — 新会话启动
- `resume` — 恢复已有会话

## Claude Code 收到提醒后应执行

1. 读取 `docs/TASK_BOARD.md`，了解当前任务状态。
2. 在 `docs/handoffs/YYYY-MM-DD.md` 中定位当前任务最后一条最小状态。
3. 只有在 active 信息不足时，才读取 `docs/handoffs/archive/YYYY-MM-DD.md` 中该任务的完整记录。
4. 检查是否有状态为 `REVIEW` 的任务待审查。
5. 如果有 REVIEW 任务，提示用户是否执行 `/oc-review`。
