##
## Three genes
##(https://genoplotr.r-forge.r-project.org/screenshots.php)
## Load library & data
library(genoPlotR)
data("three_genes")

## Color scheme
comparisons[[1]]$col <- apply_color_scheme(c(0.6, 0.4, 0.5), "grey")

## Tree
names <- c("Huey", "Dewey", "Louie")
names(dna_segs) <- names
tree <- newick2phylog("(((Huey:4.2,Dewey:3.9):3.1,Louie:7.3):1);")

## Annotations
mid_pos <- middle(dna_segs[[1]])
annot <- annotation(x1=c(mid_pos[1], dna_segs[[1]]$end[2]),
                    x2=c(NA, dna_segs[[1]]$end[3]),
                    text=c(dna_segs[[1]]$name[1], "region1"),
                    rot=c(30, 0), col=c("grey", "black"))

## Plots
plot_gene_map(dna_segs=dna_segs, comparisons=comparisons,
              annotations=annot, annotation_height=1.3,
              tree=tree, tree_width=2,
              main="Comparison of Huey, Dewey and Louie")

print(comparisons)
