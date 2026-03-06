# OpenClaw 安全检查清单

**双 Agent 共用。** 任何变更在推 REVIEW 前，实现者（通常是 Copilot）自查；审查者（通常是 Claude Code）复核。

---

## Critical — 发现即阻断，不得推进 REVIEW

- [ ] 无硬编码 API Key / Token / Password（新增内容中）
- [ ] 无命令注入风险（shell 拼接用户输入未转义）
- [ ] 无目录遍历漏洞（`../` 拼接未校验）
- [ ] 敏感配置未暴露给消息/日志渠道
- [ ] 无已知高危漏洞依赖未修复

## High — 原则上修复后才 REVIEW，特殊情况需在 handoff 说明

- [ ] 所有外部调用（API / 文件 / Shell）有错误处理
- [ ] 用户输入 / 外部 API 响应在使用前已验证结构
- [ ] 无调试语句残留（`console.log`, `print`, `debug: true`）
- [ ] 无影响功能正确性的 TODO / FIXME 未处理

## Medium — 记录在 handoff 风险栏，择期修复

- [ ] 函数 ≤50 行，文件 ≤400 行
- [ ] 新增配置字段有注释说明
- [ ] 无不必要的权限提升（如 `chmod 777`）

---

## 安全事件响应（Critical 触发时）

1. 立即停止，不推进 REVIEW。
2. 在 handoff 中写明漏洞位置与类型。
3. 将任务状态回退至 `IN_PROGRESS`。
4. 修复后重新过清单。
