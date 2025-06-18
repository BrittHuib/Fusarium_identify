rule all:
    input:
        "results/fastqc/M2324-017_Fusarium-spp2_fastqc.html",
        "results/multiqc/multiqc_report.html",
        "results/nanoplot/NanoPlot-report.html",
        "results/assembly/flye/assembly.fasta",
        "results/assembly/medaka/consensus.fasta",
        "results/quast/quast_output_medaka/report.html",
        "results/telovision/telovision_output_medaka/telomere_summary.txt",
        "results/busco/busco_medaka/short_summary.txt",
        "results/quast/quast_output_flye/report.html",
        "results/telovision/telovision_output_flye/telomere_summary.txt",
        "results/busco/busco_flye/short_summary.txt",

rule fastqc:
    input:
        "fastq/M2324-017_Fusarium-spp2.fastq.gz"
    output:
        html="results/fastqc/M2324-017_Fusarium-spp2_fastqc.html"
    shell:
        'export _JAVA_OPTIONS="-Xmx4g" && fastqc {input} -o results/fastqc'

rule multiqc:
    input:
        expand("results/fastqc/{sample}_fastqc.html", sample=["M2324-017_Fusarium-spp2"])
    output:
        "results/multiqc/multiqc_report.html"
    shell:
        "multiqc results/fastqc -o results/multiqc"

rule nanoplot:
    input:
        "fastq/M2324-017_Fusarium-spp2.fastq.gz"
    output:
        "results/nanoplot/NanoPlot-report.html"
    shell:
        "NanoPlot --fastq {input} -o results/nanoplot --loglength --N50"

rule flye:
    input:
        "fastq/M2324-017_Fusarium-spp2.fastq.gz"
    output:
        "results/assembly/flye/assembly.fasta"
    shell:
        "flye --nano-raw {input} --out-dir results/assembly/flye --genome-size 46m"

# ---------- PIPELINE A (met Medaka) ----------

rule medaka:
    input:
        reads="fastq/M2324-017_Fusarium-spp2.fastq.gz",
        draft="results/assembly/flye/assembly.fasta"
    output:
        "results/assembly/medaka/consensus.fasta"
    shell:
        "medaka_consensus -i {input.reads} -d {input.draft} -o results/assembly/medaka -t 6"

rule quast_medaka:
    input:
        "results/assembly/medaka/consensus.fasta"
    output:
        "results/quast/quast_output_medaka/report.html"
    shell:
        "quast {input} -o results/quast/quast_output_medaka"

rule telovision_medaka:
    input:
        "results/assembly/medaka/consensus.fasta"
    output:
        "results/telovision/telovision_output_medaka/telomere_summary.txt"
    shell:
        "telovision -i {input} -o results/telovision/telovision_output_medaka --sorted"

rule busco_medaka:
    input:
        "results/assembly/medaka/consensus.fasta"
    output:
        "results/busco/busco_medaka/short_summary.txt"
    shell:
        "busco -i {input} -o busco_medaka -m genome --out_path results/busco/busco_medaka --auto-lineage"

# ---------- PIPELINE B (zonder Medaka) ----------

rule quast_flye:
    input:
        "results/assembly/flye/assembly.fasta"
    output:
        "results/quast/quast_output_flye/report.html"
    shell:
        "quast {input} -o results/quast/quast_output_flye"

rule telovision_flye:
    input:
        "results/assembly/flye/assembly.fasta"
    output:
        "results/telovision/telovision_output_flye/telomere_summary.txt"
    shell:
        "telovision -i {input} -o results/telovision/telovision_output_flye --sorted"

rule busco_flye:
    input:
        "results/assembly/flye/assembly.fasta"
    output:
        "results/busco/busco_flye/short_summary.txt"
    shell:
        "busco -i {input} -o busco_flye -m genome --out_path results/busco/busco_flye --auto-lineage"
