# Pre-Review Gate Hook

在 Claude Code 编辑 TASK_BOARD.md 前自动触发的 prompt 检查。

## settings.json 配置

```json
"PreToolUse": [
  {
    "matcher": "Edit|Write",
    "hooks": [
      {
        "type": "prompt",
        "prompt": "Check if the file being edited is TASK_BOARD.md. If so, remind: REVIEW->DONE requires /oc-review pass + handoff record. If the file is not TASK_BOARD.md, return ok.",
        "model": "claude-haiku-4-5"
      }
    ]
  }
]
```

## 工作原理

- **Hook 类型**: `prompt`（单轮 LLM 评估，由 Haiku 执行）
- **触发时机**: 每次 Edit 或 Write 工具调用前
- **行为**: Haiku 检查目标文件是否为 TASK_BOARD.md，如是则提醒检查前置条件

## 前置条件（Claude Code 应人工确认）

1. **handoff 记录存在？** — 当日 `docs/handoffs/YYYY-MM-DD.md` 中有该任务的交接记录。
2. **`/oc-review` 已执行？** — 当前会话中已输出过该任务的审查报告。
3. **无 Critical 问题？** — 审查报告中 Critical 栏为"无"。
4. **验证记录存在？** — handoff 中有至少 1 条验证命令 + 结果。

## 其他已接入的 Hooks

完整 hook 列表见 `.claude/settings.json`：
- **PostToolUse** (Write|Edit) — 安全敏感文件修改提醒（Haiku prompt）
- **ConfigChange** (project_settings) — 配置变更后提醒运行 `/oc-verify`
- **Stop** — 任务完成后提醒更新 TASK_BOARD 和写 handoff
