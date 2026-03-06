# OpenClaw Config Conventions

本文档定义 `openclaw.json` 及项目内所有 JSON5 / JSON 配置文件的编写规范。
**Copilot 和 Claude Code 均须遵守。**

## 结构规范

- Key 命名：`camelCase`（与 `openclaw.json` 现有风格一致）。
- 每个新增字段必须有行内注释说明用途。
- 嵌套深度不超过 4 层；超过时考虑提取为独立配置段或文件。
- 不在配置中嵌入逻辑表达式或动态计算。

## 变更规范

- 修改配置后，同步更新引用该配置的文档（`docs/` 或对应 `README.md`）。
- 涉及密钥/认证字段的变更，在 handoff 中记录旧值摘要 → 新值摘要（脱敏）。
- 新增顶层 section 前，先确认不与现有 section 语义重叠。

## 备份规范

- `openclaw.json` 修改前，系统自动生成 `.bak` 文件（已有机制）。
- 重大结构变更前，手动创建 `/oc-checkpoint`。

## 验证规范

- 每次修改后，至少验证 JSON5 可解析（格式正确）。
- 涉及 agents/models/channels 的变更，验证 gateway 能正常加载。
