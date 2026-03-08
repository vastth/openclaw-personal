# 交接记录模板

> 从当前版本起，handoff 分为两层：
> - active: `docs/handoffs/YYYY-MM-DD.md`，只保留最近 5 条最小可执行状态
> - archive: `docs/handoffs/archive/YYYY-MM-DD.md`，保存完整历史记录

## Active 模板

> 追加到 `docs/handoffs/YYYY-MM-DD.md`，同一任务保留最后一条即可。

## OC-XXX 最小状态

- 状态: `IN_PROGRESS` | `BLOCKED` | `REVIEW` | `DONE`
- 改动文件: `path/to/file`, `path/to/other`
- 验证结论: `PASS` | `FAIL` | `待验证`
- 风险: 一句话说明当前主要风险
- 下一条命令: `...`

## Archive 模板

> 追加到 `docs/handoffs/archive/YYYY-MM-DD.md`，保留完整上下文。

### 时间戳

- 时间戳:
- From Agent: `Copilot` | `Claude`
- To Agent: `Copilot` | `Claude`
- 任务 ID:
- 任务标题:
- 状态: `IN_PROGRESS` | `BLOCKED` | `REVIEW` | `DONE`

### 已完成内容

- 摘要:
- 改动文件:
  - `path/to/file`
- 行为变化:

### 验证情况

- 执行命令:
  - `...`
- 结果:
- 尚未执行:

### 关键决策

- 决策 1:
- 原因:
- 放弃方案:

### 风险与回滚

- 风险:
- 回滚点（commit / 文件备份）:

### 下一步动作（第一条命令）

- `...`

### 给下一位 Agent 的说明

- 待确认问题:
- 前提假设:
- 必读上下文文件:
  - `docs/TASK_BOARD.md`
  - `docs/AGENT_COLLAB_PROTOCOL.md`
