# OpenClaw 双 Agent 角色模型

**核心原则：角色跟着任务走，不跟着 Agent 固定。**

## 两种工作模式

### 模式 A：Copilot 实现 → Claude Code 审查

典型场景：日常功能开发、配置修改、小步重构。

| 阶段 | Agent | 动作 |
|---|---|---|
| 实现 | Copilot | 编写代码/配置，推至 REVIEW |
| 审查 | Claude Code | `/oc-review` 三级扫描，给出 PASS/FAIL |
| 修复 | Copilot | 根据审查意见修复，重新 REVIEW |
| 确认 | Claude Code | 无问题后推 DONE |

### 模式 B：Claude Code 架构 → Copilot 验证

典型场景：架构设计、大规模重构、跨文件改动、规范文档建设。

| 阶段 | Agent | 动作 |
|---|---|---|
| 设计 + 实现 | Claude Code | 架构拓展、批量改动，推至 REVIEW |
| 验证 | Copilot | `/oc-validate` 实际运行验证，确认改动可用 |
| 修复 | Claude Code | 根据验证反馈修复 |
| 确认 | Copilot | 验证通过后推 DONE |

## 如何选择模式

在 `TASK_BOARD.md` 中标注任务时，同时声明模式：

```
| OC-XXX | 任务标题 | Copilot | IN_PROGRESS | ... | 模式 A |
| OC-XXX | 架构任务 | Claude Code | IN_PROGRESS | ... | 模式 B |
```

未标注模式时，默认按实现者身份判断：Copilot 实现 = 模式 A，Claude Code 实现 = 模式 B。

## 各 Agent 的核心能力

### Claude Code 擅长
- 架构设计、跨文件一致性分析
- 安全深度扫描（可调用 `security-reviewer` 子 Agent）
- 配置结构验证（可调用 `config-validator` 子 Agent）
- 规范建设和文档化
- 三级代码审查（`/oc-review`）

### Copilot 擅长
- 快速代码编写、IDE 内联修复
- 实际运行验证（跑命令、看输出、确认行为）
- 配置格式校验（JSON5 可解析性）
- 功能回归检查（改动后原有功能是否正常）
- 实操验证报告（`/oc-validate`）

## 共同规则（两种模式都必须遵守）

- 同一时段同一文件只允许一个 Agent 修改（文件锁机制）。
- 实现者完成后必须写 handoff 记录，审查/验证者才能接手。
- REVIEW → DONE 必须经过另一方确认，不允许自审自过。
- 安全 Critical 问题出现时，任何一方都可以立即阻断。

## 质量门禁

### 模式 A（REVIEW → DONE 由 Claude Code 确认）
1. `/oc-review` 无 Critical / High 级问题。
2. 关键路径有验证记录。
3. handoff 记录完整。

### 模式 B（REVIEW → DONE 由 Copilot 确认）
1. `/oc-validate` 验证通过（实际运行无报错）。
2. 改动范围与 handoff 声明一致（未超范围修改）。
3. 原有功能未回归。
