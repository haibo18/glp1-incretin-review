/-!
# GLP-1 论文的形式化骨架（Lean 4，核心库，无 Mathlib）

本模块只机器核验论文中**可数值判定**的陈述：
1. 发现史与药物获批的年份先后顺序；
2. 减重试验中试验组体重下降幅度大于安慰剂组（以基点表示负的百分比）；
3. 心血管结局试验 MACE 风险比小于 1；
4. 证据等级与因果通路的类型化定义。

医学因果解释以同行评审文献与临床试验报告为准；本工程不把临床结论
当作可由算术证明的命题。
-/

namespace Glp1Paper

-- ======================================================================
-- 1. 发现史时间线（年份：Nat）
-- ======================================================================

/-- 关键历史节点年份。 -/
def year_mojsov_fragment : Nat := 1983
def year_intestine_source : Nat := 1986
def year_holst_bloom : Nat := 1987
def year_exendin4 : Nat := 1991
def year_exenatide_fda : Nat := 2005
def year_liraglutide_fda : Nat := 2010
def year_dulaglutide_fda : Nat := 2014
def year_semaglutide_fda : Nat := 2017
def year_oral_semaglutide : Nat := 2019
def year_obesity_semaglutide : Nat := 2021
def year_lasker : Nat := 2024

/-- 时间线严格递增：从肽段鉴定到拉斯克奖认可。 -/
theorem chronology_ordered :
    year_mojsov_fragment < year_intestine_source ∧
    year_intestine_source < year_holst_bloom ∧
    year_holst_bloom < year_exendin4 ∧
    year_exendin4 < year_exenatide_fda ∧
    year_exenatide_fda < year_liraglutide_fda ∧
    year_liraglutide_fda < year_dulaglutide_fda ∧
    year_dulaglutide_fda < year_semaglutide_fda ∧
    year_semaglutide_fda < year_oral_semaglutide ∧
    year_oral_semaglutide < year_obesity_semaglutide ∧
    year_obesity_semaglutide < year_lasker := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · decide
  · decide
  · decide
  · decide
  · decide
  · decide
  · decide
  · decide
  · decide
  · decide

-- ======================================================================
-- 2. 减重试验（体重变化，基点；负值表示下降）
-- ======================================================================

/-- 一项减重试验的记录：试验组与安慰剂组的体重变化（基点，1% = 100 bp）。 -/
structure WeightTrial where
  activeBp : Int
  placeboBp : Int

/-- STEP 1：司美格鲁肽 2.4 mg，68 周；约 −14.9% 对 −2.4%。 -/
def step1 : WeightTrial := ⟨-1490, -240⟩

/-- SURMOUNT-1：替尔泊肽最高剂量，72 周；约 −22.5% 对 −2.4%。 -/
def surmount1 : WeightTrial := ⟨-2250, -240⟩

/-- 试验组体重下降幅度大于安慰剂组（active 数值更负）。 -/
theorem active_loss_exceeds_placebo (t : WeightTrial)
    (h : t.activeBp < t.placeboBp) : t.activeBp < t.placeboBp := h

theorem step1_active_loss_exceeds_placebo : step1.activeBp < step1.placeboBp := by
  simp [step1]

theorem surmount1_active_loss_exceeds_placebo :
    surmount1.activeBp < surmount1.placeboBp := by
  simp [surmount1]

-- ======================================================================
-- 3. 心血管结局试验（MACE 风险比，基点；1.00 = 1000 bp）
-- ======================================================================

/-- 一项 CVOT 的记录：MACE 风险比（×1000，整数基点）。 -/
structure Cvot where
  hrBp : Nat

/-- LEADER：liraglutide，HR ≈ 0.87。 -/
def leader : Cvot := ⟨870⟩

/-- SUSTAIN-6：semaglutide，HR ≈ 0.74。 -/
def sustain6 : Cvot := ⟨740⟩

/-- 风险比小于 1（1000 bp）即相对风险下降。 -/
theorem hr_below_one (c : Cvot) (h : c.hrBp < 1000) : c.hrBp < 1000 := h

theorem leader_hr_below_one : leader.hrBp < 1000 := by
  simp [leader]

theorem sustain6_hr_below_one : sustain6.hrBp < 1000 := by
  simp [sustain6]

-- ======================================================================
-- 4. 证据等级与因果通路定义
-- ======================================================================

/-- 证据等级：从基础发现到硬终点结局试验。 -/
inductive EvidenceGrade where
  | basicDiscovery   -- 基因/肽段/受体的基础发现
  | mechanism        -- 生理与信号机制阐明
  | drugDevelopment  -- 稳定化分子与药物开发
  | rct              -- 随机对照疗效试验
  | cvot             -- 心血管硬终点结局试验

/-- GLP-1 作用通路上游信号。 -/
inductive Upstream where
  | lCellSecretion   -- 肠道 L 细胞分泌 GLP-1
  | receptorBinding  -- GLP-1 结合并激活 GLP-1R

/-- GLP-1 作用下游效应。 -/
inductive Downstream where
  | insulinSecretion       -- 血糖依赖性促胰岛素分泌
  | glucagonSuppression    -- 抑制胰高血糖素
  | gastricEmptyingDelay   -- 延缓胃排空
  | centralAppetiteControl -- 中枢性食欲抑制

/-- 因果链：上游信号经受体激活到达下游效应（类型层定义，不承载数值证明）。 -/
structure Pathway where
  upstream : Upstream
  receptor : Upstream
  downstream : Downstream

/-- 示例通路：L 细胞分泌 → 受体激活 → 促胰岛素分泌。 -/
def insulinPathway : Pathway :=
  ⟨Upstream.lCellSecretion, Upstream.receptorBinding, Downstream.insulinSecretion⟩

/-- 示例通路：L 细胞分泌 → 受体激活 → 中枢食欲抑制。 -/
def appetitePathway : Pathway :=
  ⟨Upstream.lCellSecretion, Upstream.receptorBinding, Downstream.centralAppetiteControl⟩

-- ======================================================================
-- 5. 汇总
-- ======================================================================

theorem paper_evidence_summary :
    year_mojsov_fragment < year_lasker ∧
    step1.activeBp < step1.placeboBp ∧
    surmount1.activeBp < surmount1.placeboBp ∧
    leader.hrBp < 1000 ∧
    sustain6.hrBp < 1000 := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · decide
  · exact step1_active_loss_exceeds_placebo
  · exact surmount1_active_loss_exceeds_placebo
  · exact leader_hr_below_one
  · exact sustain6_hr_below_one

end Glp1Paper
