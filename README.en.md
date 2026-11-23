# glp1-incretin-review

GLP-1 incretin pathway review + Lean 4 formalization skeleton.

**中文版：[README.md](./README.md)**

This repository collects the research output, conclusions, and machine-checkable
formalization of "the discovery of GLP-1 and long-acting GLP-1 therapeutics
(diabetes, obesity)", maintained under Semantic Versioning with bilingual
Chinese/English documents.

## Layout

```
glp1-incretin-review/
├── paper/
│   ├── GLP1_incretin_review.md    # 中文综述
│   └── GLP1_incretin_review_en.md # English review
├── Glp1Paper.lean                  # Lean library root
├── Glp1Paper/
│   ├── Basic.lean
│   └── Proofs.lean                # timeline / trial numbers / evidence chain
├── lakefile.toml
├── lean-toolchain
├── lake-manifest.json
├── .github/workflows/               # Lean CI
├── CHANGELOG.md
└── README.md / README.en.md
```

## Highlights

- **Mechanism**: intestinal L-cells secrete GLP-1, which activates GLP-1R (a GPCR), driving glucose-dependent insulin secretion, suppressing glucagon, slowing gastric emptying, and centrally suppressing appetite. Native peptide is rapidly degraded by DPP-4 (half-life < 2 min).
- **Discovery**: 1983 Mojsov identified GLP-1(7-37); 1987 Holst/Bloom confirmed its incretin nature; 1991 Eng isolated exendin-4; 2005 first GLP-1RA approved; long-acting analogues and multi-target agonists followed.
- **Clinical evidence**: LEADER (liraglutide, MACE HR ≈ 0.87), SUSTAIN-6 (semaglutide, HR ≈ 0.74); STEP 1 (semaglutide 2.4 mg, ~-14.9%), SURMOUNT-1 (tirzepatide, -16.0% to -22.5%).
- **Boundaries**: GI side effects, gallbladder/pancreatic safety signals, thyroid C-cell tumor contraindication, lean-mass loss, post-withdrawal rebound, and access issues require long-term cohort verification.

## Lean formalization

Toolchain: `leanprover/lean4:v4.36.0`, core library only, **no Mathlib**.

Build:

```bash
lake build
```

The formalization only covers **numerically decidable** claims in the review:

1. Discovery and approval chronology is strictly increasing (`chronology_ordered`);
2. Weight-loss trials show greater reduction on drug than placebo (`step1`, `surmount1`);
3. CVOT hazard ratios are below 1 (`leader`, `sustain6`);
4. Typed definitions of evidence grades and causal pathways (`EvidenceGrade`, `Pathway`).

> Clinical causal claims are sourced from peer-reviewed literature and trial
> reports; this project does not treat clinical conclusions as arithmetically
> provable. There are **zero** `sorry` / `admit` / `axiom` in the sources.

## Bilingual version management

- Papers: `paper/GLP1_incretin_review.md` (Chinese) and `paper/GLP1_incretin_review_en.md` (English) are kept in sync;
- Docs: `README.md` (Chinese) and `README.en.md` (English) cross-link each other;
- Changelog: `CHANGELOG.md` keeps both Chinese and English paragraphs;
- When revising the paper, update both language versions in the same commit, tagged `docs(zh)` / `docs(en)`.

## Versioning

- Semantic Versioning (`MAJOR.MINOR.PATCH`).
- All notable changes are recorded in [`CHANGELOG.md`](CHANGELOG.md).
- `main` is the trunk; commits use Conventional Commits (`feat:` / `docs:` / `fix:` / `chore:`).
- Each release baseline is tagged `vX.Y.Z`.

## References

See the "References" section at the end of the review papers.
