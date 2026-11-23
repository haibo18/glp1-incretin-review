# glp1-incretin-review

GLP‑1 肠促胰素通路综述论文 + Lean 4 形式化核验骨架。

**English version: [README.en.md](./README.en.md)**

本仓库沉淀「GLP‑1 的发现与长效 GLP‑1 疗法（糖尿病、肥胖调控）」课题的
研究内容、结论与可机器核验的形式化命题，按语义化版本持续维护，
并提供中英双语论文与文档。

## 目录结构

```
glp1-incretin-review/
├── paper/
│   ├── GLP1_incretin_review.md    # 中文综述
│   └── GLP1_incretin_review_en.md # English review
├── Glp1Paper.lean                # Lean 库根模块
├── Glp1Paper/
│   ├── Basic.lean
│   └── Proofs.lean               # 时间线 / 试验数值 / 证据链形式化
├── lakefile.toml
├── lean-toolchain
├── lake-manifest.json
├── .github/workflows/             # Lean CI
├── CHANGELOG.md
└── README.md / README.en.md
```

## 论文要点

- **机制**：肠道 L 细胞分泌 GLP‑1，激活 GLP‑1R（GPCR），血糖依赖性促胰岛素分泌、抑制胰高血糖素、延缓胃排空、中枢性抑制食欲；天然肽被 DPP‑4 快速降解（半衰期 < 2 分钟）。
- **发现史**：1983 年 Mojsov 鉴定 GLP‑1(7‑37) 活性片段，1987 年 Holst/Bloom 确认其肠道激素属性，1991 年 Eng 分离 exendin‑4，2005 年首个 GLP‑1RA 获批，2010 年代后长效类似物与多靶点激动剂相继上市。
- **临床证据**：LEADER（liraglutide，MACE HR ≈ 0.87）、SUSTAIN‑6（semaglutide，HR ≈ 0.74）；STEP 1（semaglutide 2.4 mg，约 −14.9%）、SURMOUNT‑1（tirzepatide，−16.0% 至 −22.5%）。
- **边界**：胃肠道反应、胆囊与胰腺安全性信号、甲状腺 C 细胞肿瘤禁忌、瘦体重流失、停药反弹与可及性问题仍需长期队列验证。

## Lean 形式化工程

工具链：`leanprover/lean4:v4.36.0`，仅依赖核心库，**无 Mathlib**。

构建：

```bash
lake build
```

形式化只覆盖论文中**可数值判定**的陈述：

1. 发现史与获批年份严格递增（`chronology_ordered`）；
2. 减重试验试验组降幅大于安慰剂（`step1`、`surmount1`）；
3. CVOT 风险比小于 1（`leader`、`sustain6`）；
4. 证据等级与因果通路的类型化定义（`EvidenceGrade`、`Pathway`）。

> 医学因果解释以同行评审文献与临床试验报告为准；本工程不把临床结论
> 当作可由算术证明的命题。工程内 `sorry` / `admit` / `axiom` 数量为 0。

## 双语版本管理

- 论文：`paper/GLP1_incretin_review.md`（中文）与 `paper/GLP1_incretin_review_en.md`（英文）内容对齐；
- 文档：`README.md`（中文）与 `README.en.md`（英文）互相链接；
- 变更日志：`CHANGELOG.md` 同时保留中英两段说明；
- 论文修订时应同步更新两个语言版本，提交信息在 subject 中注明 `docs(zh)` / `docs(en)`。

## 版本维护

- 遵循语义化版本（SemVer）：`MAJOR.MINOR.PATCH`。
- 所有显著变更记录于 [`CHANGELOG.md`](CHANGELOG.md)。
- `main` 为主干分支；论文修订、形式化补充、依赖升级分别提交，提交信息
  采用 Conventional Commits（`feat:` / `docs:` / `fix:` / `chore:` 等）。
- 每个发布基线打 Git tag：`vX.Y.Z`。

## 参考文献

见论文末尾「参考文献」一节。
