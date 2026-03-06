# /oc-review

由 **Claude Code** 执行，对 Copilot 提交至 `REVIEW` 状态的任务进行代码审查。

## 触发时机

- 任务状态变为 `REVIEW` 时，由用户或协议自动召唤 Claude Code 执行。
- 或在对话中显式输入 `/oc-review [Task ID]`。

## 执行步骤

### 1. 定位变更范围

识别本次任务涉及的文件清单（来自 handoff 记录或 `TASK_BOARD.md`）。

### 2. 三级问题扫描

按以下顺序检查，发现 Critical 立即停止并输出阻断结论。

#### Critical — 阻断级（任一命中即打回）

- 硬编码 API Key / Token / Secret（新增内容中）
- 命令注入 / 目录遍历 / 用户输入未转义
- 敏感信息写入日志或消息渠道

#### High — 强烈建议修复后再过

- 外部调用无错误处理（空 catch）
- 用户输入 / 外部 API 响应使用前未验证
- 调试语句残留（`console.log`, `debug: true`）
- 影响功能的 TODO / FIXME 未处理

#### Medium — 记录，可择期修复

- 函数 >50 行 / 文件 >400 行
- 配置字段无注释说明
- 命名不规范、废弃注释块未清理

### 3. 架构一致性检查

- 新增配置结构是否与 `openclaw.json` 现有风格一致。
- 新增文件是否在正确目录下。
- 跨文件改动是否存在遗漏（如改了 settings.json 但未更新 README）。

### 4. 输出审查报告

```
## /oc-review 报告
Task ID: OC-XXX
审查时间: YYYY-MM-DD

### Critical（阻断）
- (无 / 问题描述 + 文件位置)

### High
- (无 / 问题描述 + 文件位置)

### Medium
- (无 / 问题描述 + 文件位置)

### 结论
- [ ] PASS — 无 Critical/High 问题，可推进 DONE
- [ ] PASS WITH NOTES — 无 Critical，High 问题已知晓，风险可接受
- [ ] FAIL — 存在 Critical 或未说明的 High 问题，打回 IN_PROGRESS
```

### 5. 更新 TASK_BOARD 和 handoff

- PASS → 更新任务为 `DONE`，追加 handoff 记录。
- FAIL → 更新任务回 `IN_PROGRESS`，handoff 中写明具体问题，交还 Copilot。

## 注意

- `/oc-review` 不修改代码，只输出审查报告和结论。
- 修复动作交由 Copilot 执行，修复后重新提交 REVIEW。
