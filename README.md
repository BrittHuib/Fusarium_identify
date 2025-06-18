# Fusarium_identify
A workflow to identify if Fusarium has Bikaverin

In this project, unknown Fusarium isolates are investigated to determine whether they produce bikaverin. This analysis was carried out partly through a Snakemake workflow and partly through manual processing. 
The quality of the raw sequencing data, the Flye assemblies, and the AUGUSTUS gene predictions were evaluated. In addition, OrthoFinder will be used to construct a potential phylogenetic tree.

# Snakefile
First, a Snakemake workflow was used to assess the quality of the raw sequencing reads. Subsequently, genome assembly was performed using Flye, followed by quality assessment using BUSCO and QUAST. To further improve the Flye assemblies, Medaka polishing was applied, after which the assemblies were evaluated using the same quality assessment. Additionally, TeloVision was used to assess chromosomal completeness by examining the presence of telomeric and centromeric regions
[snakefile](./Snakefile)

