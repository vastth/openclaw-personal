# OpenClaw 运行时目录说明

本文档用于说明当前仓库中几个容易让新用户困惑的运行时目录和文件，重点覆盖：

- `workspace/` 与 `workspace-analyst/` 的分工
- `cron/jobs.json`
- `canvas/index.html`
- `delivery-queue/`

如果你是第一次接触这个仓库，建议先阅读：

- `README.md`
- `docs/CONFIG_GUIDE.md`
- `docs/DEPLOY_ON_NEW_DEVICE.md`

## 总体原则

本仓库里有两类目录：

1. 配置与文档目录
例如 `.claude/`、`.github/`、`docs/`、`openclaw.example.json`

2. 运行时与工作区目录
例如 `workspace/`、`workspace-analyst/`、`browser/`、`delivery-queue/`、`logs/`

理解时可以把它们区分为：

- “规则资产”：定义系统怎么工作
- “运行状态”：记录系统正在做什么、做过什么

## 1. workspace/

作用：主 agent 的工作区根目录。

当前仓库中，`main` agent 默认使用这个目录。它承载的是主 agent 的长期身份、用户上下文和工作记忆。

常见文件：

- `AGENTS.md`: agent 的基础行为规则
- `BOOTSTRAP.md`: 首次启动时的自举说明
- `SOUL.md`: agent 身份定义
- `USER.md`: 当前服务对象说明
- `MEMORY.md`: 长期记忆
- `HEARTBEAT.md`: 心跳轮询时的提醒
- `TOOLS.md`: 本地环境专用笔记
- `memory/`: 每日或阶段性记忆文件

什么时候会改它：

- 主 agent 需要读写自己的长期上下文
- 你要给主 agent 增加本地习惯、偏好或环境说明

## 2. workspace-analyst/

作用：分析 agent 的独立工作区。

这个目录和 `workspace/` 结构相似，但它服务的是 `analyst` agent，而不是主 agent。

当前定位：

- `workspace/`：主代理，负责日常主会话与通用任务
- `workspace-analyst/`：分析代理，负责数据分析、专题研究或独立上下文任务

为什么要分开：

- 避免不同 agent 共享同一份长期记忆
- 减少上下文串扰
- 让不同角色的行为规则、用户视角和工作记忆独立演化

## 3. cron/jobs.json

作用：记录定时任务配置。

当前文件内容：

- `version: 1`
- `jobs: []`

这说明当前仓库虽然预留了定时任务能力，但还没有注册任何实际 job。

你可以把它理解为：

- 有“定时调度”能力的入口
- 当前默认是空表，不会主动执行任何周期性任务

什么时候需要关心它：

- 你希望 OpenClaw 定时执行某些操作
- 你在排查“为什么某个任务会自动发生”这类问题

## 4. canvas/index.html

作用：A2UI 或节点侧交互测试页。

从当前文件内容看，这个页面是一个简单的交互画布，用于测试按钮点击后通过桥接层向 OpenClaw 发送用户动作。

当前页面包含：

- `Hello`
- `Time`
- `Photo`
- `Dalek`

这些按钮通过 `openclawSendUserAction` 或移动端桥接接口，把动作发给宿主环境。

因此它更像：

- 一个本地交互测试页面
- 一个验证 canvas bridge 是否正常工作的 demo

什么时候需要关心它：

- 你在调试 iOS / Android 节点的 canvas 能力
- 你要验证 `openclaw:a2ui-action-status` 这类事件是否正常

## 5. delivery-queue/

作用：消息投递队列目录。

当前目录下至少有：

- `failed/`

从命名就可以推断，它用于承载投递失败或待重试的消息工作流状态。

当前仓库里 `failed/` 为空，说明此刻没有积压的失败投递项。

什么时候需要关心它：

- 飞书或其他消息渠道发送失败
- 你在排查“消息为什么没送达”
- 你需要确认是否有失败重试积压

## 6. browser/

作用：OpenClaw 浏览器运行目录。

当前仓库中，`browser/` 下包含浏览器 profile、缓存、崩溃记录和图形缓存等内容。它对应的是 `browser` 工具实际使用的本地浏览器环境。

意义：

- 浏览器能力与日常主浏览器隔离
- JS-heavy 页面、网页登录态页面、页面可视化核验都走这里

注意：

- 这是运行态目录，不适合纳入 Git 管理
- 出现浏览器异常时，可优先检查这里是否存在损坏或异常缓存

## 7. logs/

作用：运行日志目录。

适合排查：

- 网关启动问题
- 插件加载问题
- 消息收发异常

如果 OpenClaw 行为异常，但配置看起来没问题，日志通常是第一检查点之一。

## 8. media/inbound/

作用：外部渠道传入的媒体暂存目录。

典型场景：

- 飞书发来的图片、文件、音视频附件
- 其他渠道进入系统的媒体内容

这类目录属于运行态数据，不应视为稳定文档资产。

## 9. agents/*/sessions/

作用：各 agent 的历史会话记录。

当前仓库里可以看到 `agents/main/sessions/` 与 `agents/analyst/sessions/`。

意义：

- 保存会话历史
- 便于恢复或审计 agent 曾经的对话状态

注意：

- 这是高度运行态数据
- 不适合纳入公开仓库

## 10. 如何判断一个目录该不该进 Git

可以用下面这个经验法则：

- 如果它定义规则、模板、说明，通常适合进 Git
- 如果它记录缓存、会话、日志、队列、浏览器 profile，通常不适合进 Git

按这个标准：

- `docs/`、`.claude/`、`.github/`、`openclaw.example.json` 适合进 Git
- `browser/`、`logs/`、`delivery-queue/`、`agents/*/sessions/`、`media/inbound/` 不适合进 Git

## 11. 你最常需要记住的几条

1. `workspace/` 是主 agent 的脑子和家。
2. `workspace-analyst/` 是分析 agent 的独立脑子，不要和主 agent 混用。
3. `cron/jobs.json` 是定时任务入口，但当前是空的。
4. `canvas/index.html` 是交互测试页，不是业务页面。
5. `delivery-queue/failed/` 是排查消息投递失败的第一现场。