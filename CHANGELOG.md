# Changelog

本仓库所有显著变更均记录于此。格式遵循
[Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
版本号遵循 [Semantic Versioning](https://semver.org/lang/zh-CN/)。

## [0.1.0] - 2026-11-18

### Added

- 综述论文 `paper/GLP1_incretin_review.md`：GLP‑1 分子基础与生理机制、
  发现史时间线、药物演进（exenatide → liraglutide/dulaglutide/semaglutide
  → tirzepatide 等多靶点激动剂）、里程碑临床证据、安全性与局限、展望及
  科学奖项潜质评估。
- Lean 4 形式化工程 `Glp1Paper/`（工具链 `leanprover/lean4:v4.36.0`，核心库）：
  - 发现史年份严格递增命题 `chronology_ordered`；
  - 减重试验记录 `WeightTrial` 与 STEP 1、SURMOUNT‑1 疗效比较；
  - CVOT 记录 `Cvot` 与 LEADER、SUSTAIN‑6 风险比 < 1 判定；
  - 证据等级 `EvidenceGrade` 与因果通路 `Pathway` 类型定义；
  - 汇总命题 `paper_evidence_summary`。
- GitHub Actions Lean CI（`leanprover/lean-action`）。
- 仓库说明 `README.md` 与本变更日志。

### Verification

- `lake build`：`Build completed successfully`，`errors=0`，`warnings=0`。
- `sorry` / `admit` / `axiom`：0 处。
