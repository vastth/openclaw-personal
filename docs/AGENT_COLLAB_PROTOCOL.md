# OpenClaw 双 Agent 交接协议 (Copilot <-> Claude Code)

适用范围: 当前仓库 `c:\Users\Administrator\.openclaw`
目标: 让两个 Agent 可以并行开发，同时减少冲突、重复劳动与上下文丢失。

## 1. 角色分工

- `Copilot`: 快速代码修改、重构、小步验证、IDE 内联修复。
- `Claude Code`: 跨文件设计、较大改动、方案收敛、文档化与收尾。
- 任何时刻一个任务只能有一个 `Owner Agent`。

## 2. 单一事实源

使用以下 4 个文件作为协作协议的核心:

- `docs/TASK_BOARD.md`: 任务状态看板。
- `docs/HANDOFF_NOTE_TEMPLATE.md`: active/archive 双层交接模板。
- `docs/handoffs/YYYY-MM-DD.md`: 当日 active handoff，只保留最近 5 条最小可执行状态。
- `docs/handoffs/archive/YYYY-MM-DD.md`: 当日 archive handoff，保存完整历史记录。

规则:

- 所有任务状态变化先写 `TASK_BOARD.md`，再开始编码。
- 每次切换 Agent 必须同时更新 handoff 两层：active 刷新当前任务最小状态，archive 追加完整记录。
- 没有 active 或 archive handoff 记录，视为不可接手。

## 3. 任务状态机

任务只允许以下状态:

- `TODO`: 未开始。
- `IN_PROGRESS`: 正在开发 (必须标注 Owner Agent)。
- `BLOCKED`: 被依赖阻塞。
- `REVIEW`: 已完成开发，待另一 Agent 检查。
- `DONE`: 合并完成。

状态流转:

- `TODO -> IN_PROGRESS -> REVIEW -> DONE`
- 若出现阻塞: `IN_PROGRESS -> BLOCKED -> IN_PROGRESS`

## 4. 文件所有权与冲突规避

- 同一时段，同一文件只允许一个 Agent 修改。
- 大任务按目录分区，例如:
  - Agent A: `agents/main/**`
  - Agent B: `workspace/**`
- 若必须改同一文件:
  - 先在 `TASK_BOARD.md` 标记“文件锁”。
  - 交接时明确 `last touched lines/sections`。

## 5. 交接信息结构

active 最小状态必须包含:

- 任务 ID
- 当前状态
- 改动文件
- 验证结论
- 风险一句话
- 下一步可直接执行的第一条命令

archive 完整记录必须包含:

- 任务 ID 与标题
- 当前状态与下一状态建议
- 已改文件清单
- 关键决策与原因
- 验证结果 (已测/未测/测试命令)
- 风险与回滚点
- 下一步可直接执行的第一条命令

## 6. 提交流程 (建议)

- Commit 前缀:
  - `copilot: ...`
  - `claude: ...`
- 一个 commit 只做一类变更 (功能/修复/文档分离)。
- PR 或最终汇总中附上最近一条 active 状态摘要，必要时引用 archive 完整记录。

## 7. 日常执行 SOP

1. 打开 `docs/TASK_BOARD.md`，选择一个 `TODO`。
2. 把任务改成 `IN_PROGRESS`，填入 `Owner Agent` 和时间。
3. 开发并本地验证。
4. 追加完整记录到 `docs/handoffs/archive/YYYY-MM-DD.md`，并刷新 `docs/handoffs/YYYY-MM-DD.md` 中该任务的最小状态。
5. 将任务改为 `REVIEW` 或 `DONE`。
6. 下一个 Agent 接手前先读 `docs/TASK_BOARD.md`，再读 active handoff 中该任务最后一条；只有需要追溯历史时才读 archive。

## 8. 质量门禁

满足以下条件才允许从 `REVIEW` 到 `DONE`:

- 代码能运行或通过对应验证命令。
- 关键路径有最小验证记录。
- 文档与配置变更已同步。
- active 与 archive handoff 记录完整。

## 9. 禁止事项

- 未更新看板直接改代码。
- 未写 handoff 直接切换 Agent。
- 同时让两个 Agent 改同一文件。
- 只更新 active，不更新 archive。
- 交接只写“已完成”，不写验证和风险。

## 10. 快速开始

- 第一步: 创建 `docs/handoffs/archive/YYYY-MM-DD.md` 作为完整日志；`docs/handoffs/YYYY-MM-DD.md` 只保留最近 5 条最小状态。
- 第二步: 在 `docs/TASK_BOARD.md` 建 3 个当前任务 (建议: 功能、修复、文档各 1 个)。
- 第三步: 从今天开始强制执行“先看板、后编码、双写 handoff”。
