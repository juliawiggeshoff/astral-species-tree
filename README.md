# Multispecies Coalescent Model - Species Tree

In order to calculate phylogenetic trees, different methods can be used. [One method](https://gitlab.leibniz-lib.de/jwiggeshoff/ml-supermatrix-tree) concatenates multiple gene sequences into a single supermatrix alignment in order to calculate a species tree, while the other infers a tree for each gene, the so-called gene trees, to then create a consensus tree to represent the subject species. Among other things, incomplete lineage sorting may result in gene trees that are different from one another and from the species tree. Programs using the multi-species coalescent model have been shown to be statistically consistent when facing these issues.

This Snakemake workflow calculates gene trees based on the maximum- likelihood using [IQ-TREE](http://www.iqtree.org/).  Then, 100 bootstrap trees are generated for each gene. A consensus tree is generated for each gene. Lastly, the gene trees are combined into a single file to be used for species tree inference under the multi-species-coalescent model implemented with [ASTRAL](https://github.com/smirarab/ASTRAL).

# System requirements
## Local machine

I recommend running the workflow on a HPC system, as the analyses are resource and time consuming.

- If you don't have it yet, it is necessary to have conda or miniconda in your machine.
Follow [these](https://conda.io/projects/conda/en/latest/user-guide/install/linux.html) instructions.
	- After you are all set with conda, I highly (**highly!**) recommend installing a much much faster package manager to replace conda, [mamba](https://github.com/mamba-org/mamba)
	- First activate your conda base
	`conda activate base`
	-Then, type:
	`conda install -n base -c conda-forge mamba` 

- Likewise, follow [this](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) tutorial to install Git if you don't have it.

## HPC system

Follow the instructions from your cluster administrator regarding loading of  modules, such as loading a root distribution from Conda.
For example, with the cluster I work with, we use modules to set up environmental variables, which have to first be loaded within the jobscripts. They modify the $PATH variable after loading the module.

e.g.:
`module load anaconda3/2022.05`

You usually don't have sudo rights to install anything to the root of the cluster. So, as I wanted to work with a more updated distribution of conda and especially use mamba to replace conda as a package manager, I had to first create my own "local" conda, i.e. I first loaded the module and then created a new environment I called localconda 
1. `module load anaconda3/2022.05`
2. `conda create -n localconda -c conda-forge conda=22.9.0`
3. `conda install -n localconda -c conda-forge mamba`
4. `conda activate localconda`

If you run `conda env list` you'll probably see something like this:
`/home/myusername/.conda/envs/localconda/`

# Data requirements

Multiple sequence alingment (MSA) files on the amino acid level. The files **need** to be in fasta format and have the suffix .fas or .fasta, otherwise it will not work.

Create a folder within `resources/` and add all of your MSA files to it. 

e.g. `resources/mollusca_astral`

The workflow automatically recognizes the names of the files and processes them accordingly. The name of the subdirectory will be used to name the output directories and files from the workflow.

e.g.:

`resources/mollusca_astral/12345at6447.fas`

One of the output files will be named like this:

`results/mollusca_astral/ml_bs_trees/12345at6447_mollusca_astral.treefile`

The final species tree, for example, would be:

`results/mollusca_astral/final_species_tree_mollusca_astral.treefile`

Because of how I structured the workflow, you are able to run several different analyses in parallel :)

e.g.: `resources/mollusca_astral/`, `resources/arthropoda`, etc


# Installation 

1. Clone this repository

`git clone https://gitlab.leibniz-lib.de/jwiggeshoff/msc-species-tree.git`

2. Activate your conda base

`conda activate base`

- If you are working on a cluster or have your own "local", isolated environment you want to activate instead (see [here](https://gitlab.leibniz-lib.de/jwiggeshoff/msc-species-tree#hpc-system)), use its name to activate it

`conda activate localconda`

3. Install **msc-species-tree** into an isolated software environment by navigating to the directory where this repo is and run:

`conda env create --file environment.yaml`

If you followed what I recommended in the [System requirements](https://gitlab.leibniz-lib.de/jwiggeshoff/msc-species-tree#local-machine), run this instead:

`mamba env create --file environment.yaml`

The environment from msc-species-tree is created

4. *Always* activate the environment before running the workflow

On a local machine:

`conda activate msc-species-tree`

If you are on a cluster and/or created the environment "within" another environment, you want to run this first:

`conda env list`

You will probably see something like this among your enviornments:

`home/myusername/.conda/envs/localconda/envs/msc-species-tree`

From now own, you have to give this full path when activating the environment prior to running the workflow

`conda activate /home/myusername/.conda/envs/localconda/envs/msc-species-tree`
