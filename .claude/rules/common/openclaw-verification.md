# OpenClaw Verification Rule

## Minimum Validation

每次改动后，至少完成以下其中两项:

- 配置文件可解析（JSON/JSON5 结构正确）。
- 关键路径命令验证（例如 `openclaw gateway status` 或等价检查）。
- 与改动相关的 smoke test 或行为验证。

## Reporting Format

在 handoff 中使用固定结构:

- Commands Run
- Result
- Not Run Yet

## No Silent Assumptions

- 未验证项必须显式声明。
- 如果工具或网络受限，写明替代验证方案。
