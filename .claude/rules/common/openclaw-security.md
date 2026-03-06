# OpenClaw Security Rule

## Secrets

- 不在任何文件中粘贴完整 API Key、Token、Secret（新增内容中）。
- 输出日志时对密钥做脱敏，仅展示前后少量字符（如 `sk-0ae...efba`）。
- 已存在于配置中的密钥不在对话/文档中复述。

## Safe Operations

- 禁止未确认的破坏性命令（如批量删除、重置历史、`rm -rf`）。
- 对外部系统写操作（消息发送、远程执行、飞书群消息）需明确任务目的。
- 推送代码 / 合并变更前，先确认 handoff 记录存在。

## Config Hygiene

- 优先项目级配置（`.claude/settings.json`），减少对全局 `~/.claude` 的副作用。
- 涉及代理/认证修改时，记录回滚路径（旧值 → 新值）。

---

## 三级安全检查清单（REVIEW 前必须通过）

### Critical — 发现即阻断，不得推进 REVIEW

- [ ] 无硬编码 API Key / Token / Password（新增内容）
- [ ] 无命令注入风险（shell 拼接用户输入未转义）
- [ ] 无目录遍历漏洞（`../` 拼接未校验）
- [ ] 敏感配置未暴露给消息/日志渠道

### High — 原则上修复后才 REVIEW，特殊情况需在 handoff 说明

- [ ] 所有外部调用有错误处理（无空 catch）
- [ ] 用户输入 / 外部 API 响应在使用前已验证结构
- [ ] 无调试语句残留（`console.log`, `print`, `debug: true` 等）
- [ ] 无未处理的 TODO / FIXME 标记影响功能正确性

### Medium — 记录在 handoff 风险栏，择期修复

- [ ] 函数/文件体积符合 coding-style 规范
- [ ] 新增配置字段有注释说明
- [ ] 无不必要的权限提升

## 安全事件响应

当发现 Critical 级问题时：

1. 立即停止当前任务，不推进 REVIEW。
2. 在 handoff 中写明漏洞位置与类型。
3. 将任务状态回退至 `IN_PROGRESS`。
4. 修复后重新过三级检查清单。
