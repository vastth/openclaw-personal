# OpenClaw Shared Standards

此目录存放 **Copilot 和 Claude Code 共同遵守** 的质量标准。

两个 Agent 各自通过自己的加载机制读取这些文档：
- Claude Code: `.claude/rules/common/` 中的规则文件引用此目录。
- Copilot: `.github/copilot-instructions.md` 中引用此目录。

## 文件清单

| 文件 | 用途 |
|---|---|
| `config-conventions.md` | JSON5 配置文件编写规范 |
| `security-checklist.md` | 三级安全检查清单（REVIEW 前必过） |
| `review-criteria.md` | 代码审查的统一评判标准 |
