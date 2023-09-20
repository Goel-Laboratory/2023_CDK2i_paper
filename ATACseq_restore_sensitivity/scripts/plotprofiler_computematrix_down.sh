#!/bin/bash
#SBATCH --job-name=deeptools-job
#SBATCH -N 1
#SBATCH --partition=prod_med
#SBATCH --mem=8G
#SBATCH --cpus-per-task=15
#SBATCH -t 10:00:00
#SBATCH --mail-user=antonio.ahn@petermac.org
#SBATCH --mail-type=end
#SBATCH --output=DT_heatmap-%j.out
#SBATCH --error=DT_heatmap-%j.err

# script to make one compute matrix files for separate bigwig files (DMSO and LY treated in this case)
# saved as plotprofiler_computematrix_down.sh in /researchers/krutika.ambani/Goel_lab_members/Cath_Dietrich/20230125_CP_ATAC_MCF7M_CDK2i/R_analysis/4.diffbind_overcome_resistance/paper_figures/scripts

module load deeptools/3.5.0

BW_dir="/researchers/krutika.ambani/Goel_lab_members/Cath_Dietrich/20230125_CP_ATAC_MCF7M_CDK2i/results/bigwig"
BED_dir="/researchers/krutika.ambani/Goel_lab_members/Cath_Dietrich/20230125_CP_ATAC_MCF7M_CDK2i/R_analysis/4.diffbind_overcome_resistance/1.overcome_resist_LYvsDMSO/1.overview/data/bed"
output_dir="/researchers/krutika.ambani/Goel_lab_members/Cath_Dietrich/20230125_CP_ATAC_MCF7M_CDK2i/R_analysis/4.diffbind_overcome_resistance/paper_figures/figures_output/deeptools"

mkdir -p $output_dir
set -xe

computeMatrix reference-point --referencePoint center \
-b 1000 -a 1000 \
-R $BED_dir/ParLY_vs_ParDMSO_down.bed \
-S $BW_dir/Sample-1-DMSO-Rep-1_S10.bw \
$BW_dir/Sample-9-Cryo-Par-DMSO-Rep-2_S14.bw \
$BW_dir/Sample-2-Par-LY-Rep-1_S2.bw \
$BW_dir/Sample-10-Par-LY-Rep-2_S10.bw \
--skipZeros \
--binSize 10 \
--missingDataAsZero \
--sortUsingSamples 3 \
--sortRegions descend \
-p 14 \
-o $output_dir/PAR_LYvsDMSO_peaks_overcomeresist_down_PAR.gz

computeMatrix reference-point --referencePoint center \
-b 1000 -a 1000 \
-R $BED_dir/ParLY_vs_ParDMSO_down.bed \
-S $BW_dir/Sample-5-LYR-DMSO-Rep-1_S5.bw \
$BW_dir/Sample-13-Cryo-LYR-DMSO-Rep-2_S13.bw \
$BW_dir/Sample-6-LYR-ARC-Rep-1_S12.bw \
$BW_dir/Sample-14-LYR-ARC-Rep-2_S14.bw \
--skipZeros \
--binSize 10 \
--missingDataAsZero \
--sortUsingSamples 3 \
--sortRegions descend \
-p 14 \
-o $output_dir/PAR_LYvsDMSO_peaks_overcomeresist_down_LYR.gz

computeMatrix reference-point --referencePoint center \
-b 1000 -a 1000 \
-R $BED_dir/ParLY_vs_ParDMSO_down.bed \
-S $BW_dir/Sample-7-LYFR-DMSO-Rep-1_S7.bw \
$BW_dir/Sample-15-Cryo-LYFR-DMSO-Rep-2_S15.bw \
$BW_dir/Sample-8-LYFR-ARC-Rep-1-8-1_S13.bw \
$BW_dir/Sample-16-LYFR-ARC-Rep-1-8-2_S16.bw \
--skipZeros \
--binSize 10 \
--missingDataAsZero \
--sortUsingSamples 3 \
--sortRegions descend \
-p 14 \
-o $output_dir/PAR_LYvsDMSO_peaks_overcomeresist_down_LYFR.gz
