# Fusarium_identify
A workflow to identify if Fusarium has Bikaverin

In this project, unknown Fusarium isolates are investigated to determine whether they produce bikaverin. This analysis was carried out partly through a Snakemake workflow and partly through manual processing. 
The quality of the raw sequencing data, the Flye assemblies, and the AUGUSTUS gene predictions were evaluated. In addition, OrthoFinder will be used to construct a potential phylogenetic tree.

## Installation
To ensure proper execution of the Snakefile and associated commands, multiple Conda environments were created. One environment was specifically configured for running Snakemake, while a separate environment was used for the remaining tools.
conda env create -n <environment_name> -f environment.yml

### Environment_name:
snakefile_assembly (python=3.11)
medaka, fastqc, multiqc, nanoplot, flye, quast, busco, TeloVision.

novo_assembly: 
Barrmap, Augustus, Orthofinder, bedtools. 


## Snakefile
First, a Snakemake workflow was used to assess the quality of the raw sequencing reads. Subsequently, genome assembly was performed using Flye, followed by quality assessment using BUSCO and QUAST. To further improve the Flye assemblies, Medaka polishing was applied, after which the assemblies were evaluated using the same quality assessment. Additionally, TeloVision was used to assess chromosomal completeness by examining the presence of telomeric and centromeric regions
[snakefile](./Snakemake)
> [!IMPORTANT]
> Input files may differ depending on the dataset or experimental setup. Make sure to adjust file paths, formats, and naming conventions accordingly.

## AUGUSTUS
> [!NOTE]
> Switch over to the novo_assembly environment

Subsequently, AUGUSTUS was used for gene prediction:
Augustus - - species=fusarium_gramineasrum fusarium_unknown.faa > augustus_output.gff  
The resulting AUGUSTUS output was then used as input for antiSMASH to identify and annotate potential secondary metabolite biosynthetic gene clusters.

## Orthofinder
Orthofinder was used to find gene clusters: 
orthofinder -f ./fusarium_unknown.faa
The output was used to make a phylogenetic tree with different Fusarium species. and to visualize orthologous genes. 

## Dry-lab
If you want to see how this came together, follow this link [Dry Lab](./Dry-Lab).

