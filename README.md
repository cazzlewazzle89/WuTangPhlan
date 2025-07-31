# Enter the Wu-TangPhlAn
The goal is to turn this into a (w)rapper script for **Ph**y**l**ogenetic **An**alysis of metagenomic data.  

This page is just acting as a to-do list for myself - I will put together a wiki when I get it in a working state.

The plan is to structure this similar to a nextflow pipieline (pulling options from a config file and using separate scripts for each step/option).

I will write it in bash for now - but aim to build a nextflow version eventually

- [x] main script
- [x] config file
- [ ] quality control
    - [ ] fastp
    - [ ] trimmomatic
- [ ] host removal
    - [ ] bowtie2
        - [ ] human
        - [ ] mouse
        - [ ] user-defined
    - [ ] hostile
    - [ ] skip
- [ ] compositional profiling
    - [ ] kraken2
    - [ ] metaphlan3
- [ ] functional profiling
    - [ ] superfocus
- [ ] combined composition and function
    - [ ] humann3
    - [ ] OGUs - woltka
        - [ ] alignment approach
            - [ ] bowtie2
            - [ ] shogun
        - [ ] reference database only
            - [ ] SGB
            - [ ] MGBC
            - [ ] UHGG
            - [ ] GTDB
        - [ ] user MAGs only
            - [ ] binning strategy
                - [ ] single sample
                - [ ] group
                - [ ] dataset
            - [ ] dereplication cutoff
        - [ ] reference genomes plus MAGs
            - [ ] binning stragy
            - [ ] reference database
            - [ ] dereplication cutoff
        - [ ] functional annotation of genomes
            - [ ] emapper
- [ ] strain-level profiling
    - [ ] instrain
    - [ ] strainscan
