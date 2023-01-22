#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -o cluster_logs/
#$ -q small.q,medium.q,large.q
#$ -N msc-species-tree
#$ -pe smp 61
#$ -M user.email@gmail.com
#$ -m be

module load anaconda3/2022.05
conda activate /home/myusername/.conda/envs/localconda/envs/msc-species-tree

#one core will be used by snakemake to monitore the other processes
THREADS=$(expr ${NSLOTS} - 1)

snakemake \
    --snakefile workflow/Snakefile \
    --keep-going \
    --latency-wait 300 \
    --use-conda \
    --cores ${THREADS} \
    --verbose \
    --printshellcmds \
    --reason \
    --nolock 
