# Multispecies Coalescent Model - Species Tree

In order to calculate phylogenetic trees, different methods can be used. [One method](https://gitlab.leibniz-lib.de/jwiggeshoff/ml-supermatrix-tree) concatenates multiple gene sequences into a single supermatrix alignment in order to calculate a species tree, while the other infers a tree for each gene, the so-called gene trees, to then create a consensus tree to represent the subject species. Among other things, incomplete lineage sorting may result in gene trees that are different from one another and from the species tree. Programs using the multi-species coalescent model have been shown to be statistically consistent when facing these issues.

This Snakemake workflow calculates gene trees based on the maximum- likelihood using [IQ-TREE](http://www.iqtree.org/).  Then, 100 bootstrap trees are generated for each gene. A consensus tree is generated for each gene. Lastly, the gene trees are combined into a single file to be used for species tree inference under the multi-species-coalescent model implemented with [ASTRAL](https://github.com/smirarab/ASTRAL).

