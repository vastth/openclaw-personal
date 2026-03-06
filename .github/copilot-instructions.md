# Copilot 项目指引

本仓库使用双 Agent 协作，**角色跟着任务走，不固定**。

## 你有两种角色

### 模式 A（你是实现者）
- 编写代码/配置 → 推 REVIEW → Claude Code 用 `/oc-review` 审查 → DONE。
- 适用：日常功能开发、配置修改、小步重构。

### 模式 B（你是验证者）
- Claude Code 做了架构/大改动 → 推 REVIEW → **你用 `/oc-validate` 验证** → DONE。
- 你的验证重点：实际运行、行为确认、回归检查（不是静态分析）。

**关键规则：REVIEW → DONE 必须经过另一方确认，不允许自审自过。**

## 开始编码前的必读顺序

1. `docs/AGENT_COLLAB_PROTOCOL.md`
2. `docs/TASK_BOARD.md`
3. `docs/handoffs/` 中最新的文件
4. `docs/standards/` — 特别是 `config-conventions.md` 和 `security-checklist.md`

## 必须遵守

- 开始任何代码编辑前，先把 `docs/TASK_BOARD.md` 更新为 `IN_PROGRESS`。
- 每个任务只允许一个 owner，并遵守文件锁。
- 交接时，必须在 `docs/handoffs/YYYY-MM-DD.md` 追加记录。
- 遵循任务流转：`TODO -> IN_PROGRESS -> REVIEW -> DONE`。
- **作为实现者：REVIEW 前自查 `docs/standards/security-checklist.md`**。
- **作为验证者：按 `/oc-validate` 流程输出验证报告**。

## 中文优先约定

- 与用户的自然语言交互、解释、总结、风险说明默认尽量使用中文。
- 新增或维护的 Markdown 文档、handoff、验证报告默认使用中文。
- 代码注释默认尽量使用中文；若涉及 API、协议、配置 key、开源项目原名或固定术语，可保留英文。
- 命令、路径、环境变量、配置 key、协议字段名保持原样，不做强制翻译。
- 若用户明确要求英文，或目标文件必须保持英文语境，再按实际需要切换。

## 编码规范（作为实现者时）

参见 `docs/standards/` 目录：

- **Config**: `camelCase` key、行内注释、嵌套 ≤4 层、改配置同步文档。
- **Code**: 函数 ≤50 行、文件 ≤400 行、显式错误处理、不提交调试代码。
- **Security**: 不硬编码密钥、不拼接未转义用户输入、不静默失败。

## 验证重点（作为验证者时）

- 格式验证：JSON/JSON5 可解析、Markdown 结构完整。
- 行为验证：实际运行命令，确认改动可用。
- 回归检查：改动是否影响已有功能。
- 范围检查：改动是否超出 handoff 声明范围。

## 每次完成时都要包含

请至少包含：

- 改动文件
- 验证了什么、如何验证
- 针对 `docs/standards/security-checklist.md` 的自查（实现者）或 `/oc-validate` 报告（验证者）
- 已知风险
- 给另一位 Agent 的明确下一条命令/动作
