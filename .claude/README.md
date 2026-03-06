# OpenClaw `.claude` 本土化配置

本目录是 Claude Code 的项目级配置，不影响全局 `~/.claude`。
基于 [everything-claude-code](https://github.com/affaan-m/everything-claude-code) 的五层架构本土化而来。

## 目录结构

```
.claude/
  settings.json          # 运行参数 + hooks 配置
  settings.local.json    # 本地环境（代理等，不提交）
  package-manager.json   # 包管理器声明
  rules/common/          # [Rules 层] 项目级规则（5 个）
    openclaw-roles.md      Copilot vs Claude Code 角色边界
    openclaw-workflow.md   工作流状态机
    openclaw-coding-style.md  代码/配置风格规范
    openclaw-security.md   安全规则 + 三级检查清单
    openclaw-verification.md  验证最低标准
  commands/              # [Skills 层] 可复用命令模板（6 个）
    oc-plan.md             生成执行计划
    oc-review.md           代码审查（Claude Code 核心，模式 A）
    oc-validate.md         实操验证（Copilot 核心，模式 B）
    oc-verify.md           最小验证
    oc-handoff.md          交接打包
    oc-checkpoint.md       任务存档点
  hooks/                 # [Hooks 层] 自动化触发器（Claude Code 专属）
    session-start.md       会话开始时加载上下文
    pre-review-gate.md     REVIEW→DONE 前的自动检查
  agents/                # [Subagents 层] 专用子 Agent（2 个）
    security-reviewer.md   深度安全扫描
    config-validator.md    配置结构验证
```

## 五层架构对照

| 层级 | 本项目状态 | Claude Code | Copilot |
|---|---|---|---|
| Skills/Commands | 6 个命令 | `.claude/commands/` 原生加载 | 通过 `docs/standards/` 共享标准 + `/oc-validate` |
| Rules | 5 个规则 | `.claude/rules/` 原生加载 | `.github/copilot-instructions.md` 引用 |
| Hooks | 2 个触发器 | `settings.json` hooks 字段 | 不支持（Claude Code 专属） |
| Subagents | 2 个子 Agent | Agent tool 调用 | 不支持（Claude Code 专属） |
| MCP | 未启用 | 支持（待需要时添加） | VS Code MCP 支持（待需要时添加） |

## 共享标准层

`docs/standards/` 目录存放双方共用的质量标准文档：
- `config-conventions.md` — 配置编写规范
- `security-checklist.md` — 三级安全清单
- `review-criteria.md` — 审查评判标准

## 与协作协议的关系

- 执行顺序仍以 `docs/AGENT_COLLAB_PROTOCOL.md` 为准。
- `.claude` 补强 Claude Code 的把关能力（review + hooks + subagents）。
- `.github/copilot-instructions.md` 补强 Copilot 的实现质量。
- 交接仍统一写入 `docs/TASK_BOARD.md` 与 `docs/handoffs/`。

## 语言约定

- 两个 Agent 在与用户交互时，默认尽量使用中文。
- 新增或维护的项目文档、handoff、验证报告默认使用中文。
- 代码注释默认优先使用中文；若涉及 API、协议、配置 key 或固定术语，可保留英文。
