# Enter the Wu-TangPhlAn
The goal is to turn this into a (w)rapper script for **Ph**y**l**ogenetic **An**alysis of metagenomic data.  

This page is just acting as a to-do list for myself - I will put together a wiki when I get it in a working state.

The plan is to structure this similar to a nextflow pipieline (pulling options from a config file and using separate scripts for each step/option).

I will write it in bash for now - but aim to build a nextflow version eventually

- [x] main script
- [x] config file
- [x] quality control
    - [x] fastp
    - [x] trimgalore
    - [x] skip
- [x] host removal
    - [x] bowtie2
        - [x] user-defined
    - [x] hostile
        - [x] user-defined
    - [x] skip
- [ ] compositional profiling
    - [ ] kraken2
    - [ ] metaphlan3
    - [ ] singlem
- [ ] functional profiling
    - [ ] superfocus
- [ ] MAG reconstruction
    - [ ] binning strategy
        - [ ] single sample
        - [ ] group
        - [ ] dataset
    - [ ] metawrap
    - [ ] metabat2
    - [ ] groopm
    - [ ] checkm
    - [ ] functional annotation of genomes
            - [ ] emapper
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
            - [ ] GTDB (reps, dereplicated)
        - [ ] user MAGs only
            - [ ] dereplication cutoff
        - [ ] reference genomes plus MAGs
            - [ ] reference database
            - [ ] dereplication cutoff
- [ ] strain-level profiling
    - [ ] instrain
        - [ ] reference database only
        - [ ] user MAGs only
        - [ ] reference genomes plus MAGs
    - [ ] strainscan
- [ ] download script for pre-built databases
    - [ ] host
    - [ ] composition
    - [ ] OGU
    - [ ] instrain
