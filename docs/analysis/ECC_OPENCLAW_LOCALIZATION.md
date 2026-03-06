# Everything-Claude-Code 对 OpenClaw 的本土化整合分析

参考源: `https://github.com/affaan-m/everything-claude-code`

## 1. 结论摘要

该项目是一个大而全的 Claude Code 能力仓库。对 OpenClaw 来说，最有价值的不是“全量搬运”，而是按优先级引入:

- 立即引入: 项目级 `.claude` 目录、规则分层、命令模板、成本控制参数。
- 逐步引入: hooks 自动化、MCP 精简策略、验证循环。
- 暂缓引入: 大量与当前业务无关的垂直技能（如特定框架/语言栈）。

## 2. 可复用能力映射

| ECC 能力 | 是否适配 OpenClaw | 本土化动作 |
|---|---|---|
| `.claude` 项目级配置 | 高 | 已创建 `.claude/settings.json` 与 `package-manager.json` |
| Rules 分层（common + language） | 高 | 已创建 `.claude/rules/common/*` |
| Commands 模板（plan/verify/handoff） | 高 | 已创建 `.claude/commands/oc-*.md` |
| Token 优化参数 | 高 | 已落地 `MAX_THINKING_TOKENS` 与自动压缩阈值 |
| 多 Agent 协作流程 | 高 | 已与 `docs/TASK_BOARD.md` + `docs/handoffs/` 对齐 |
| Hooks 自动化 | 中 | 建议二期引入（先做只读检查 hook） |
| 50+ Skills 全量导入 | 低 | 不建议，当前会引入过多上下文噪音 |
| 大而全 MCP 模板 | 中 | 建议按需启用，保持最小 MCP 集 |

## 3. 本土化改造原则

- 业务优先: 围绕 OpenClaw 网关、Agent 协作、配置治理。
- 渐进增强: 先流程一致性，再自动化，再扩展能力。
- 成本可控: 限制上下文膨胀，减少无关规则和工具。

## 4. 已完成改造清单

- 新增 `.claude/README.md`
- 新增 `.claude/settings.json`
- 新增 `.claude/package-manager.json`
- 新增 `.claude/rules/common/openclaw-workflow.md`
- 新增 `.claude/rules/common/openclaw-security.md`
- 新增 `.claude/rules/common/openclaw-verification.md`
- 新增 `.claude/commands/oc-plan.md`
- 新增 `.claude/commands/oc-verify.md`
- 新增 `.claude/commands/oc-handoff.md`

## 5. 二期建议（可选）

1. 引入轻量 hooks（只读提示，不自动改写文件）。
2. 增加 `.claude/contexts/`（dev/review/research）用于不同任务模式。
3. 对接 `security-scan` 思路，先做本仓库最小安全检查脚本。
4. 为 OpenClaw 常见任务补充 3-5 个项目专用 skills。

## 6. 风险与控制

- 风险: 规则过多会增加代理上下文负担。
- 控制: 当前只引入最小子集，避免一次性重配置。

- 风险: 未验证的 hooks 可能误拦截日常命令。
- 控制: hooks 放到二期，先文档规范后自动化。

## 7. 使用方式

1. 在任务开始前，读取 `.claude/README.md` 与 `docs/TASK_BOARD.md`。
2. 使用 `/oc-plan` 生成计划。
3. 完成后用 `/oc-verify` 输出验证结论。
4. 切换 Agent 前用 `/oc-handoff` 生成交接记录。
