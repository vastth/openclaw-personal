下面是 **Zeus AI 工作站完整上下文 v2**。
这是基于本轮实测 + 和 Gemini 的讨论迭代后的版本。

# Zeus AI 工作站完整上下文 v2

## 1. 主机与系统信息

### 主机

* 主机名：`Zeus`

### 硬件配置

* CPU：`AMD Ryzen 7 7800X3D`
* GPU：`AMD Radeon RX 6800`
* 显存：`16GB VRAM`
* 内存：`32GB RAM`

### 操作系统

* `Windows 11 Pro 23H2`
* `x64`

---

## 2. AI 工作站目标

这台机器当前不是单纯聊天机，目标是：

1. `OpenClaw Agent` 长期运行
2. 本地 AI 自动化
3. 数据分析 / SQL 辅助
4. 编程助手
5. 个人助手
6. 本地模型实验环境

---

## 3. 当前软件栈

### Agent 框架

* 已部署：`OpenClaw`
* 当前运行环境：`Windows 原生`

### 本地推理引擎

* 使用：`Ollama for Windows`
* 版本：

  * `ollama version is 0.17.4`

### Ollama 可执行文件

* `C:\Users\Administrator\AppData\Local\Programs\Ollama\ollama.exe`

### 模型目录

* `D:\AIModel\ollama\models`

---

## 4. 当前关键环境变量

当前确认过的变量：

* `OLLAMA_MODELS=D:\AIModel\ollama\models`
* `OLLAMA_FLASH_ATTENTION=1`
* `OLLAMA_KV_CACHE_TYPE=q8_0`
* `OLLAMA_VULKAN=1`

### 说明

* `OLLAMA_MODELS`：模型目录已迁移到 D 盘
* `OLLAMA_FLASH_ATTENTION=1`：开启更高效 attention 路径
* `OLLAMA_KV_CACHE_TYPE=q8_0`：KV cache 使用 `q8_0`
* `OLLAMA_VULKAN=1`：当前 AMD Windows GPU 路线跑通的关键变量之一；Ollama 官方文档确认 Windows/Linux 提供 Vulkan 路径，但 Vulkan 仍是 **Experimental**。

---

## 5. WSL / Ubuntu 路线结论

### 已做过的尝试

* 安装 `WSL2`
* 安装 `Ubuntu 22.04`
* 更新 WSL
* 安装 AMD Windows 驱动
* 在 WSL 中测试 `/dev/kfd`
* 测试 `lspci`
* 尝试 WSL + ROCm 路线

### 实测结果

在 WSL 中未获得可用 GPU 计算设备：

* `ls /dev | grep kfd` 无输出
* `lspci | grep VGA` 无有效 GPU 计算透传结果

### 当前结论

**这台机器不再继续走 WSL GPU 计算路线。**

原因不是“理论绝对不可能”，而是：

* 这条路在你的机器上已经实测不通
* AMD 的 WSL 兼容矩阵并不覆盖 RX 6800
* 当前最优路径已被本机实测确认是 **Windows 原生 Ollama**。

---

## 6. GPU 加速最终结论

### 关键结论

这台机器已经确认：

**Windows 原生 Ollama + RX 6800 + `OLLAMA_VULKAN=1` 可以跑通 GPU 推理。**

这不是理论推断，是本机实测结论。

---

## 7. GPU 路线验证过程（关键上下文）

### 阶段 1：大上下文时出现混合推理

曾出现：

* `qwen3.5:9b`
* `CONTEXT = 262144`
* `PROCESSOR = 44%/56% CPU/GPU`

这说明：

* GPU 已参与
* 但由于上下文太大，模型无法纯显存运行
* 导致 CPU/GPU 混合推理

### 阶段 2：降低 context 后成功全 GPU

后续在更合理的 context 下，出现：

* `PROCESSOR = 100% GPU`

这证明：

* 问题不在“显卡不能跑”
* 问题在于：**模型大小 + context 设置是否适合 16GB 显存**

---

## 8. 关于 `OLLAMA_VULKAN` 的当前结论

### 已确认

* 在 PowerShell 中设置 `OLLAMA_VULKAN=1` 后，GPU 路线跑通
* 当前本机测试结果表明，该变量是有价值的

### 重要修正

`OLLAMA_VULKAN=1` 不是唯一判断标准。
更重要的运行时证据是：

* `ollama ps`
* 任务管理器中的 GPU 专用显存
* `PROCESSOR` 列是否显示 `100% GPU`

### 当前实战判断

只要出现：

* `PROCESSOR = 100% GPU`

就说明这条路已经工作，不需要再陷入“变量有没有生效”的宗教争论。

---

## 9. Thinking 控制结论

Ollama 官方支持两种 thinking 控制方式：

* `--think=false`：彻底关闭 thinking
* `--hidethinking`：隐藏 thinking，但保留内部思考能力

### 当前策略结论

不能一刀切。

#### 对复杂分析主模型（如 `qwen3.5:9b`）

* **不建议默认 `think=false`**
* 更推荐：`hidethinking`

原因：

* 你选择它，就是因为它在业务建模、归因、数仓分层上更强
* 这类能力通常更依赖深一点的推理

#### 对执行型模型（如 `qwen2.5-coder:7b`）

* `think=false` 合理

#### 对轻量模型（如 `gemma3:4b`）

* `think=false` 合理

---

## 10. 统一测试口径下的模型记分牌

以下是当前最有价值的一轮测试：
**统一 `32768 context`，重点看 GPU 占用、速度、回答风格（standalone ollama 直调）。**

| 模型                 |     上下文 |      GPU占用 |     载入大小 |    用时 | 输出特点                 | 角色判断            |
| ------------------ | ------: | ---------: | -------: | ----: | -------------------- | --------------- |
| `gemma3:4b`        | `32768` | `100% GPU` | `4.7 GB` | `19秒` | 快，但偏泛化、偏浅            | 轻任务 / 路由 / 快问快答 |
| `qwen2.5-coder:7b` | `32768` | `100% GPU` | `7.3 GB` | `16秒` | 最快，适合代码 / SQL / 工具执行 | 执行模型 / 编程助手     |
| `qwen3.5:9b`       | `32768` | `100% GPU` | `9.4 GB` | `54秒` | 业务理解、归因、分层意识最强       | 分析模型 / 复杂任务主炮   |
| `deepseek-r1:8b`   | `32768` | `100% GPU` | `~7.7 GB` | —    | 有推理能力，中英双强          | **OpenClaw 主脑（推荐）** |

> ⚠️ **OpenClaw 重要修正（2026-03-07）**：`qwen3.5:9b` 的 standalone `ollama run` 实测为 100% GPU，但在 OpenClaw 下加载完整 workspace 系统提示后 VRAM 溢出，同时 `contextWindow=16384` 会触发 OpenClaw 内置 `warn<32000` compaction loop 导致 Agent 启动失败。`deepseek-r1:8b` 虽 VRAM 足够但不支持 tool call，同样无法作为 OpenClaw 主脑。**当前 OpenClaw 实际主脑：`qwen2.5:7b`（通用版，支持 tool call，~7.2 GB，32K VRAM 有余量）。**

---

## 11. 模型风格判断

### `gemma3:4b`

**优点**

* 快
* 轻
* 100% GPU
* 适合高频调用

**缺点**

* 偏泛化
* 更像通用产品文档
* 业务建模深度不够

**适合**

* 意图识别
* 路由
* 摘要
* 简单问答
* 高频轻任务

---

### `qwen2.5-coder:7b`

**优点**

* 三者里最快
* 100% GPU
* 对代码 / SQL / Shell / 脚本更贴脸

**缺点**

* 复杂业务建模弱于 `qwen3.5:9b`
* 更像执行工兵，不像业务架构师

**适合**

* SQL
* Python
* ETL
* Shell
* 工具调用
* 编程助手

---

### `qwen3.5:9b`

**优点**

* 三者里业务理解最强
* 对 ODS / DWD / DWS / ADS、归因、指标体系意识更完整
* 更适合复杂分析和方案设计

**缺点**

* 慢于另外两个
* 不适合所有小任务都调用
* **⚠️ 不适合作 OpenClaw 主脑**：模型体积 9.4 GB + 32K KV cache 超出 OpenClaw 加载 workspace 系统提示后的 VRAM 余量；`contextWindow=16384` 又会触发 OpenClaw 内置 compaction loop 导致 Agent 启动失败

**适合**

* standalone `ollama run` 直调 / 外部脚本调用
* 数据模型设计
* 数仓方案
* 指标体系设计
* 复杂业务分析
* 长文档总结
* 关键任务评审

**不适合**

* OpenClaw Agent 主脑（已确认 VRAM 溢出）

---

## 12. 关于 context 的最终结论

### 已实测现象

* `262144`：会导致 `qwen3.5:9b` 出现 CPU/GPU 混合推理
* `65536`：可以做到 `100% GPU`
* `131072`：也能 `100% GPU`，但更重
* `32768`：目前最均衡

### 当前建议

* `qwen2.5:7b`：`32768`（**OpenClaw 主脑（当前）**，通用版，支持 tool call，~7.2 GB，有余量）
* `gemma3:4b`：`32768`（OpenClaw 备选，VRAM 宽裕）
* `qwen2.5-coder:7b`：`32768`
* `deepseek-r1:8b`：不支持 tool call，仅 standalone 直调；**不用于 OpenClaw**
* `qwen3.5:9b`：仅 standalone 直调，`32768`；**不用于 OpenClaw**

### 不建议

* 全局默认 `131072`
* 全局默认 `256k`

原因：

* 会显著增加显存压力
* 会拖慢响应
* 对 OpenClaw 长期运行不划算

---

## 13. 与 Gemini 讨论后修正的关键结论

### 修正 1：多模型梯队不是不能做，但不能想当然

之前曾提出：

* Planner → `qwen3.5:9b`
* Coder → `qwen2.5-coder:7b`
* Router → `gemma3:4b`

这个战术意识没问题。
**问题在于工程落地不能想得太简单。**

### 真实工程风险

#### 风险 A：显存 / 模型切换风险

Gemini指出：

* `9.4 GB + 7.3 GB > 16 GB`
* 多模型短时间连续唤醒会有风险

这条方向对，但需要修正为更准确的说法：

* Windows Radeon 下，Ollama 官方 FAQ 明确说明默认最大并发加载模型数偏保守，默认通常就是单模型加载；内存不够时，请求会排队，旧模型会卸载腾空间。
* 所以风险不是“数学加法后必炸”
* 更真实的风险是：

  * 模型切换等待
  * 重新加载延迟
  * OpenClaw 若并发调度，会卡在排队和切换上

### 修正 2：`think=false` 不能全局一刀切

Gemini指出：

* 不能把 `qwen3.5:9b` 这种分析主炮做“额叶切除”

这条方向对。
当前结论是：

* `qwen3.5:9b` → `hidethinking`
* `qwen2.5-coder:7b` → `think=false`
* `gemma3:4b` → `think=false`

### 修正 3：OpenClaw 的多模型路由不能被想象成现成功能

这是 Gemini 说得最对的一条。

OpenClaw 官方当前支持的主要是：

* `primary`
* `fallbacks`
* 按 agent 覆盖模型
* allowlist / catalog

但 **fallback 不是智能任务路由器**。
它更偏向故障切换，不是“SQL 自动走 coder、业务分析自动走 planner”的成熟现成功能。官方文档对 failover 的定义也是认证失败、限流、超时等场景。

社区层面也存在：

* 缺少真正动态模型路由的诉求
* 某些模型覆盖 / 本地 Ollama 子代理覆盖不稳定
* 本地 Ollama 通过 OpenClaw 跑时存在挂起/超时反馈
  这些都说明：**不要把三级自动路由当作今天就能无痛落地的生产能力。**

---

## 14. 当前最稳的生产建议

### 推荐策略 A：单默认模型，最稳

如果你现在要优先稳定，不追求华丽架构：

* `OpenClaw 默认模型：qwen2.5:7b`

原因：

* 模型 ~4.7 GB + 32K KV cache 约 2.5 GB = ~7.2 GB，16GB VRAM 有余量
* `contextWindow=32768` 高于 OpenClaw 内置警戒阈值 32000，不触发 compaction loop
* 通用版，支持 tool call，中英双语，实测 embedded 路径成功响应
* `qwen3.5:9b` VRAM 溢出、`deepseek-r1:8b` 不支持 tool call，均已排除

### 推荐策略 B：双轨使用，但不依赖 OpenClaw 自动路由

* OpenClaw 主脑：`qwen2.5:7b`
* 需要写 SQL / 代码 / 脚本时，手动或外部脚本直调：`qwen2.5-coder:7b`
* 高质量业务分析需要时，standalone 直调：`qwen3.5:9b`
* `gemma3:4b` 先只做备用轻模型，不放核心生产链路

### 当前不推荐

* 直接上“三模型自动路由”
* 直接假设 OpenClaw 能原生稳定完成复杂多模型调度

---

## 15. 当前建议的 Ollama 稳定性参数

结合本机情况和官方 FAQ，当前更稳的建议是：

* `OLLAMA_VULKAN=1`
* `OLLAMA_MAX_LOADED_MODELS=1`
* `OLLAMA_NUM_PARALLEL=1`
* `OLLAMA_KEEP_ALIVE=30s` 或 `60s`

### 说明

* `MAX_LOADED_MODELS=1`：更符合你当前 Windows Radeon 路线的稳态策略
* `NUM_PARALLEL=1`：避免并发调用导致切换/排队问题
* `KEEP_ALIVE=30s/60s`：比默认 5 分钟更保守，但不建议一开始就设 `0`
* `KEEP_ALIVE=0` 会导致每次都冷启动重新加载，可能让体感更差。Ollama 官方确认 `keep_alive=0` 会立即卸载。

---

## 16. 当前最合理的模型分工结论

### 如果只上一个默认模型

```text
qwen2.5:7b（OpenClaw 主脑）
```

### 如果允许手工双轨协作

```text
OpenClaw 主脑：qwen2.5:7b
执行 / 代码SQL：qwen2.5-coder:7b（standalone 或外部脚本直调）
业务深度分析：qwen3.5:9b（standalone 直调，不走 OpenClaw）
轻任务 / 路由：gemma3:4b（暂时不进核心生产链）
```

---

## 17. 当前版最终工作站架构

```text
Windows 11
├─ OpenClaw
│  └─ 主脑：qwen2.5:7b（contextWindow=32768）
├─ Ollama
│  ├─ qwen2.5:7b         （OpenClaw 主脑 / 通用对话，支持 tool call）
│  ├─ qwen3.5:9b         （standalone 直调 / 业务分析，不走 OpenClaw）
│  ├─ qwen2.5-coder:7b   （编程 / SQL / 工具执行）
│  ├─ deepseek-r1:8b     （standalone 直调备用，不支持 tool call）
│  └─ gemma3:4b          （轻任务 / 路由 / 备用）
└─ RX 6800 16GB GPU 推理
```

---

## 18. 当前版一页结论

### 已确认

1. **Windows 原生 Ollama + RX 6800 已成功跑通 GPU 推理**
2. **WSL GPU 路线对这台机器不值得继续投入**
3. **`OLLAMA_VULKAN=1` 路线已实测有效**
4. **四个模型（含 deepseek-r1:8b）都已在本机跑到 `100% GPU`**
5. **`32768 context` 是 standalone 直调的均衡甜点位**
6. **`qwen3.5:9b` 在 OpenClaw 下 VRAM 溢出，不再作 OpenClaw 主脑**
7. **OpenClaw 现在最稳的打法不是自动三模型路由，而是单主脑 / 双轨协作**

### 当前最终建议

* **OpenClaw 默认模型：`qwen2.5:7b`（contextWindow=32768，已验证）**
* **不要上自动三模型路由**
* **fallback 只做故障保底（云端 DeepSeek）**
* **`qwen2.5-coder:7b` 作为手动/外部执行模型**
* **`qwen3.5:9b` 仅 standalone 直调，不走 OpenClaw**
* **`deepseek-r1:8b` 不支持 tool call，仅 standalone 直调**
* **`gemma3:4b` 暂作轻任务备用**

---

## 19. 下一步建议

### 优先级 1

把 OpenClaw 的默认模型定为：

* `qwen2.5:7b`（已落地并验证；qwen3.5:9b VRAM 溢出、deepseek-r1:8b 不支持 tool call，均已排除）

### 优先级 2

把稳定性参数收紧：

* `MAX_LOADED_MODELS=1`
* `NUM_PARALLEL=1`
* `KEEP_ALIVE=30s`

### 优先级 3

把你的业务规则、指标口径、数仓范式、历史样例喂给 OpenClaw
因为现在决定上限的，已经不是硬件，而是：

* 业务上下文
* 规则模板
* 数仓口径
* 历史样例

---

## 20. 一句话版

**Zeus 现在已经是一台真正跑通了 Windows 原生 AMD GPU 推理的本地 AI 工作站；当前最稳的生产打法，是让 `qwen2.5:7b` 独挑 OpenClaw 主脑（qwen3.5:9b VRAM 溢出、deepseek-r1:8b 不支持 tool call，均已排除），`qwen2.5-coder:7b` 做外部执行补位，`qwen3.5:9b` 仅 standalone 直调用于深度分析，而不是幻想 OpenClaw 现阶段原生稳定支持华丽的三模型自动路由。**

