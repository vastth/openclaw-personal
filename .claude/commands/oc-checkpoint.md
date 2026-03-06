# /oc-checkpoint

在复杂任务开发过程中创建命名存档点，便于回滚和进度追踪。

## 子命令

### create `<name>`

在当前状态创建一个检查点：

1. 验证关键文件可解析（JSON5 格式检查）。
2. 将以下信息追加到 `.claude/checkpoints.log`：

```
[CHECKPOINT] name=<name> task=<Task ID> time=<ISO时间> agent=<Claude Code|Copilot>
files=<已改文件列表>
notes=<可选备注>
```

3. 输出确认信息，包含存档点名称和时间。

**示例：**
```
/oc-checkpoint create before-model-routing-refactor
```

---

### verify `<name>`

对比当前状态与指定存档点的差异：

- 列出存档点之后新增/修改的文件。
- 提示是否存在未验证的变更。

---

### list

显示 `.claude/checkpoints.log` 中所有存档点，格式：

```
#  名称                              任务     时间              Agent
1  before-model-routing-refactor    OC-001  2026-03-05 14:30  Copilot
2  after-gateway-cleanup            OC-002  2026-03-05 16:00  Claude Code
```

---

### clear

保留最近 5 条，清除更早的存档点记录。

---

## 推荐使用时机

| 场景 | 操作 |
|---|---|
| 开始一个 IN_PROGRESS 任务前 | `create before-<task-name>` |
| 完成核心改动、准备推 REVIEW 前 | `create ready-for-review-<task-id>` |
| 发现问题需要回溯时 | `list` → `verify <name>` |

## 与 handoff 的关系

- Checkpoint 是轻量存档，不替代 handoff 记录。
- 存档点名称可在 handoff 的 "Rollback Point" 字段中引用：`rollback: /oc-checkpoint verify before-xxx`。
