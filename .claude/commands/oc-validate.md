# /oc-validate

由 **Copilot** 执行，对 Claude Code 提交至 `REVIEW` 状态的任务进行实操验证。
这是模式 B（Claude Code 架构 → Copilot 验证）的核心命令。

## 触发时机

- Claude Code 将架构/重构类任务推至 `REVIEW` 后，用户指派 Copilot 执行验证。
- 或在对话中显式输入 `/oc-validate [Task ID]`。

## 与 /oc-review 的区别

| 维度 | `/oc-review`（Claude Code） | `/oc-validate`（Copilot） |
|---|---|---|
| 关注点 | 代码质量、安全、架构一致性 | 实际可用性、运行结果、行为正确 |
| 方法 | 静态分析 + 规则扫描 | 运行命令 + 观察输出 |
| 工具 | 子 Agent（security-reviewer 等） | IDE 运行、终端命令 |

## 执行步骤

### 1. 确认改动范围

读取 handoff 记录，对照 TASK_BOARD 的文件锁，确认 Claude Code 声明改动了哪些文件。

### 2. 格式验证

- JSON/JSON5 文件：能否正常解析？
- Markdown 文件：结构是否完整、链接是否有效？
- 配置文件：必需字段是否存在？

### 3. 行为验证（至少 1 项）

- 配置类：`openclaw gateway status` 或等价的加载检查。
- 规则/命令类：在对话中实际触发一次，确认行为符合预期。
- 脚本类：实际运行，确认输出正确。

### 4. 回归检查

- 改动是否影响了已有功能？
- 是否超出 handoff 声明的范围修改了其他文件？

### 5. 输出验证报告

```
## /oc-validate 报告
Task ID: OC-XXX
验证时间: YYYY-MM-DD
验证者: Copilot

### 格式验证
- openclaw.json: OK / ERROR
- settings.json: OK / ERROR

### 行为验证
- 命令: <执行的验证命令>
- 结果: <输出摘要>
- 状态: PASS / FAIL

### 回归检查
- 改动范围与 handoff 一致: YES / NO
- 已有功能影响: NONE / <问题描述>

### 结论
- [ ] PASS — 验证通过，可推进 DONE
- [ ] PASS WITH NOTES — 基本通过，有小问题记录在案
- [ ] FAIL — 验证未通过，打回 IN_PROGRESS（附具体问题）
```

### 6. 更新 TASK_BOARD 和 handoff

- PASS → 更新任务为 `DONE`，追加 handoff 记录。
- FAIL → 更新任务回 `IN_PROGRESS`，handoff 中写明问题，交还 Claude Code。
