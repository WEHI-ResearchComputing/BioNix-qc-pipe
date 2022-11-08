# QC-pipe in BioNix

This repository aims to wrap a Snakemake pipeline for generating QC metrics from sequencing data into Bionix, please refer to this <a href=https://github.com/WEHIGenomicsRnD/qc-pipe>repository</a> for more about the pipeline. 
Some bioinformatics tools such as FastQScreen, Qualimap, Samtools_stats, and MultiQC that were used in the QC-pipe and yet to be available in BioNix's tools are wrapped. 

The directory `subread-wf` is an example workflow that I started with, to utilise bioinformatics tools already available in BioNix.

The following are some notes regarding wrapping some of the particular tools.

## FastQ-Screen
FastQ-Screen always require a config file where an aligner and a list of databases should be specified, here we are using bowtie2.

## MultiQC
This stage is specified solely through a flake. During this process, the FastQC was slightly redefined such that the output format is detectable by MultiQC
