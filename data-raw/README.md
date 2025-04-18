This directory contains all scripts to convert EukFunc database based on PR2 version 5.0.0 into the different databases available in the R package.
- EukFunc.pr2.5.0.0.tsv : EukFunc database in tab separated format
- EukFunc_to_DBu.R : R script to convert tab separated database into R format database DBu (one row per species)
- DBu_to_DBf.R : R script to convert DBu to DBf (one row per corresponding sequence in PR2 5.0.0)
- DBu_to_DBc.R : R script to convert DBu to DBc (condensed clade for consistent functional annotation)
- removed_taxa_5.0.0.rds : list of exclusively aquatic clades and animal clades other than nematodes originally present in PR2 version 5.0.0 and removed from the EukFunc databases; can be loaded with the function "readRDS"
- Nematoda.genus.corrected_taxonomy_vs_PR2.tsv: a tab separated table to assign family names to Nematoda genera
- EukFunc.references.tsv: details of all references as provided in the reference column

Version compatible with PR2 version 4.12.0 are provided:
- FuncDB_species.tsv: EukFunc database in tab separated format
- FuncDB_to_DBu.R : R script to create the DBu database for PR2 version 4.12.0
- PR2_species.R : initial script to generate the PR2 version 4.12.0 species list
- removed_taxa_4.12.0.rds : list of exclusively aquatic clades and animal clades other than nematodes originally present in PR2 version 4.12.0 and removed from the EukFunc databases

Scripts to get and format data to construct the example datasets taxo_exa and taxo_exa2 are also available:
- get_taxo_exa.R
- get_taxo_exa2.R

The supplementary code to the publish paper is also provided:
- Lentendu_et_al.2025.Supplementary_R_Code.Rmd
