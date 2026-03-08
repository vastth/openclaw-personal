# OpenClaw 配置指南

本文档用于说明 `openclaw.json` / `openclaw.example.json` 中最关键的配置字段，目标是让新用户能够基于示例配置独立完成本地部署。

适用场景：

- 第一次部署 OpenClaw
- 从 `openclaw.example.json` 生成自己的 `openclaw.json`
- 理解当前仓库里各配置块的作用与依赖关系

建议配合以下文件一起阅读：

- `openclaw.example.json`
- `docs/DEPLOY_ON_NEW_DEVICE.md`
- `README.md`

## 最小部署路径

如果你只想尽快跑起来，至少需要补齐以下内容：

1. `env`：模型 API Key
2. `models`：至少 1 个可用 provider 和 model
3. `agents.defaults.workspace`：真实工作区路径
4. `channels.feishu`：如果你要接飞书，就必须填 `appId` / `appSecret`
5. `gateway.auth.token`：改成自己的 token
6. `bindings`：把私聊 / 群聊路由到正确的 agent

完成后建议执行：

```powershell
openclaw config validate
openclaw gateway status
```

## 顶层结构速览

当前示例配置的关键顶层字段如下：

| 字段 | 作用 | 是否部署必需 |
|---|---|---|
| `env` | 存放 API Key 等环境变量 | 是 |
| `auth` | 定义 provider 的鉴权方式 | 视 provider 而定 |
| `models` | 声明模型提供商与模型列表 | 是 |
| `agents` | 定义默认 agent 行为与多 agent 列表 | 是 |
| `tools` | 定义工具集，含网页检索与抓取 | 建议 |
| `browser` | 定义浏览器工具行为 | 若使用网页能力则建议 |
| `messages` | 消息确认与响应行为 | 建议 |
| `commands` | 原生命令与重启控制 | 建议 |
| `session` | 会话隔离策略 | 建议 |
| `bindings` | 将不同对话路由到不同 agent | 是 |
| `channels` | 飞书等外部渠道接入 | 若接渠道则必需 |
| `gateway` | 本地网关配置与访问控制 | 是 |
| `plugins` | 已安装插件与启用状态 | 若接渠道则必需 |

以下两个字段通常由系统维护，不建议手动编辑：

- `meta`
- `wizard`

## 1. env

作用：统一存放模型或服务的密钥，避免把明文密钥散落到多个配置块。

示例：

```json5
"env": {
  "DEEPSEEK_API_KEY": "YOUR_DEEPSEEK_API_KEY"
}
```

建议：

- 只在这里放需要被 `${VAR_NAME}` 引用的值
- 提交到 Git 的示例文件里使用占位符，不要写真实密钥
- 真实 `openclaw.json` 中的密钥不要在 handoff 或 README 中重复出现

## 2. auth

作用：声明某些 provider 的认证档案。

当前示例中：

- `minimax-cn:default` 使用 `api_key` 模式

什么时候需要改：

- 新增 provider，且该 provider 需要显式 auth profile
- provider 名称或默认 profile 名称改变

## 3. models

作用：定义 OpenClaw 可以使用哪些模型提供商，以及每个 provider 下有哪些模型。

关键字段：

- `mode`: 常见为 `merge`，表示与内置模型列表合并
- `providers`: 所有 provider 的集合
- `baseUrl`: 模型服务地址
- `api`: 协议类型，例如 `anthropic-messages`、`openai-completions`
- `apiKey`: 直接写 key 或引用 `env` 中变量
- `models[]`: 具体模型清单

每个模型至少建议定义：

- `id`
- `name`
- `reasoning`
- `input`
- `contextWindow`
- `maxTokens`

当前仓库的模型策略：

- `deepseek/deepseek-chat` 作为主力模型
- `minimax-cn/MiniMax-M2.5` 作为长上下文兜底

常见错误：

- `agents.defaults.model.primary` 指向了不存在的 provider/model
- `apiKey` 没有配置，或引用了不存在的环境变量
- `contextWindow` / `maxTokens` 乱填，导致预期与实际不一致

## 4. agents

作用：定义默认 agent 行为，以及多 agent 列表。

### agents.defaults

关键字段：

- `model.primary`: 默认主模型
- `model.fallbacks`: 主模型不可用时的兜底列表
- `workspace`: 默认工作区路径
- `compaction.mode`: 上下文压缩策略
- `memorySearch`: 向量检索 / embedding / 本地记忆索引配置
- `maxConcurrent`: 主 agent 最大并发数
- `subagents.maxConcurrent`: 子 agent 最大并发数

当前仓库的重点：

- `workspace` 必须改成你本机真实路径
- `compaction.mode` 会影响长会话稳定性
- `memorySearch` 建议先显式预留，即使暂时关闭，也能把未来的 embedding / 检索接入点固定下来

### agents.defaults.memorySearch

作用：为未来的向量检索、embedding、记忆索引预留正式配置位。

当前推荐思路：

- 先把 `enabled` 设为 `false`，避免未验证时影响主聊天链路
- 本地优先可用 `provider: "ollama"`
- 真正上云时，再补 `remote.apiKey`、`remote.baseUrl` 或切换 `provider`
- `store.path` 单独放到固定目录，避免和会话文件混在一起

### agents.list

作用：定义具体 agent 实例。

当前示例中常见会有多个 agent：

- `main`: 主 agent
- `analyst`: 分析 agent
- `heavy`: 重任务 / 云端高质量 agent（可先不绑定渠道，保留给手动切换或后续路由）

什么时候需要改：

- 你想新增专门 agent
- 你想把不同渠道或对话对象路由到不同工作区

## 5. tools

作用：定义工具集。当前仓库重点是 `tools.web`。

### tools.profile

- 当前值为 `messaging`
- 适合飞书等消息渠道场景

### tools.web.search

作用：联网搜索互联网结果。

关键字段：

- `enabled`: 是否启用
- `maxResults`: 默认返回结果数
- `timeoutSeconds`: 单次搜索超时
- `cacheTtlMinutes`: 搜索结果缓存时间

注意：

- 仅把 `enabled` 设为 `true` 不代表一定能搜索
- 真正调用 `web_search` 仍需要搜索提供商 API Key

### tools.web.fetch

作用：直接抓取网页正文，适合已知 URL 的文档、文章和静态页面。

关键字段：

- `enabled`
- `maxChars`
- `maxCharsCap`
- `timeoutSeconds`
- `cacheTtlMinutes`
- `maxRedirects`

当前仓库的已验证结论：

- 未配置搜索 API Key 时，飞书端已验证 `web_fetch + browser fallback` 可完成联网取数与结果回传

## 6. browser

作用：定义浏览器工具行为，用于 JS-heavy 页面、需要点击或需要可视化确认的页面。

关键字段：

- `enabled`: 是否启用浏览器工具
- `defaultProfile`: 浏览器 profile 名称
- `headless`: 是否无头运行
- `snapshotDefaults.mode`: 页面快照策略

当前仓库为什么保留 `headless: false`：

- 便于本地观察 agent 是否真的打开了页面

## 7. messages

作用：定义消息层行为。

当前关键字段：

- `ackReactionScope: group-mentions`

意义：

- 在群里只有被 @ 时才响应，减少刷屏

## 8. commands

作用：定义 OpenClaw 原生命令相关行为。

关键字段：

- `native`
- `nativeSkills`
- `restart`
- `ownerDisplay`

如果你只是普通部署，通常保持示例值即可。

## 9. session

作用：定义会话隔离策略。

当前关键字段：

- `dmScope: per-channel-peer`

意义：

- 每个对话对象独立 session，避免跨人串上下文

## 10. bindings

作用：把不同渠道 / 对话类型路由到不同 agent。

当前仓库示例：

- 飞书私聊路由到 `main`
- 指定飞书群路由到 `analyst`

关键字段：

- `agentId`
- `match.channel`
- `match.peer.kind`
- `match.peer.id`

常见错误：

- `agentId` 不存在于 `agents.list`
- 群 ID 或用户 ID 填错，导致消息进来但不命中任何绑定

## 11. channels

作用：配置外部消息渠道。当前仓库重点是 `channels.feishu`。

关键字段：

- `enabled`
- `appId`
- `appSecret`
- `connectionMode`
- `domain`
- `groupPolicy`
- `groupAllowFrom`

部署时必须关注：

- `appId` / `appSecret` 要换成你自己的飞书应用凭据
- `groupAllowFrom` 要换成你自己的群 ID
- 如果只是先测私聊，也建议先核对 `bindings` 中的 direct peer 配置

## 12. gateway

作用：定义本地网关监听、认证和节点安全策略。

关键字段：

- `port`: 网关端口
- `mode`: 当前为 `local`
- `bind`: 当前为 `loopback`，只绑定本机
- `auth.mode`: 当前为 `token`
- `auth.token`: Web UI 和 API 访问令牌
- `tailscale`: 是否启用异地组网
- `nodes.denyCommands`: 对节点命令做黑名单控制

部署建议：

- 一定要改 `auth.token`
- 如果没有远程访问需求，保持 `bind: loopback`
- `denyCommands` 建议保留，避免节点权限过大

## 13. plugins

作用：记录插件启用状态和安装信息。

### plugins.entries

当前最关键的是：

- `feishu.enabled: true`

### plugins.installs

作用：记录已安装插件的来源、版本和安装路径。

说明：

- 这一段主要由系统维护
- 普通部署时更关注插件是否正确安装，而不是手动修改这些字段

## 14. 不建议手动编辑的字段

以下字段一般由 OpenClaw 自动维护，除非你明确知道自己在做什么，否则不要手改：

- `meta`
- `wizard`
- `plugins.installs`

## 15. 新用户部署检查清单

复制 `openclaw.example.json` 为 `openclaw.json` 后，至少逐项确认：

- [ ] 已填入真实模型 API Key
- [ ] `agents.defaults.workspace` 与 `agents.list[].workspace` 已改为本机路径
- [ ] `channels.feishu.appId` / `appSecret` 已替换
- [ ] `bindings` 中的私聊 / 群聊 ID 已替换
- [ ] `gateway.auth.token` 已替换
- [ ] 运行 `openclaw config validate` 通过
- [ ] 运行 `openclaw gateway status` 通过

## 16. 推荐修改顺序

为了降低出错率，建议按这个顺序改：

1. `env`
2. `models`
3. `agents`
4. `bindings`
5. `channels`
6. `gateway`
7. `tools.web` / `browser`

这样可以先保证模型和工作区可用，再接渠道，最后补网页能力。