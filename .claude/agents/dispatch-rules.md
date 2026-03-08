# Subagent Dispatch Rules

当 `/oc-review` 执行时，根据变更文件列表自动决定调用哪些子 Agent。

## 触发规则

### security-reviewer

**匹配文件模式（任一命中即触发）：**
- `openclaw.json` — 含 API Key、Token、飞书凭据
- `.claude/settings.json` / `.claude/settings.local.json` — 含代理配置、环境变量
- `*.key` / `*.pem` / `*.env` — 密钥/证书/环境文件
- 任何文件内容中新增了疑似密钥模式（`sk-`、`xoxb-`、`Bearer `）

**调用方式：**
```
使用 Agent tool，subagent_type = "general-purpose"
Prompt: 读取 .claude/agents/security-reviewer.md 获取角色定义，然后对以下文件执行安全审查：[文件列表]
```

### config-validator

**匹配文件模式（任一命中即触发）：**
- `openclaw.json` — 主配置文件
- `.claude/settings.json` — Claude Code 配置
- `.claude/package-manager.json` — 包管理器声明

**调用方式：**
```
使用 Agent tool，subagent_type = "general-purpose"
Prompt: 读取 .claude/agents/config-validator.md 获取角色定义，然后验证以下配置文件：[文件列表]
```

## 优先级

- 如果同时匹配两个规则，先调用 security-reviewer，再调用 config-validator。
- 安全问题为 Critical 时，config-validator 结果仅供参考。

## 不触发的情况

- 仅修改 `docs/**` 或 `.github/**` 中的 Markdown 文件 → 跳过子 Agent，直接进入三级扫描。
- 仅修改 handoff 记录 → 跳过子 Agent。
