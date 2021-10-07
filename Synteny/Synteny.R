####################################
# TALLER 2 (Continuacion genoplotR)#
####################################

# https://genoplotr.r-forge.r-project.org/index.php
# https://genoplotr.r-forge.r-project.org/pdfs/genoPlotR.pdf


#Cargar libreria genoPlotR instalada en el taller #1
library(genoPlotR)

#Nuestra secuencia a, en formato fasta
a_23270 <- try(read_dna_seg_from_file("blast/2A_Acidithiobacillus_ferrooxidans_ATCC_23270.fna"))

#Nuestra secuencia b, en formato fasta
b_53993 <- try(read_dna_seg_from_file("blast/2A_Acidithiobacillus_ferrooxidans_ATCC_53993.fna"))

#Salida tabulada de blastn en
#blastn -query 2A_Acidithiobacillus_ferrooxidans_ATCC_23270.fna -subject 2A_Acidithiobacillus_ferrooxidans_ATCC_53993.fna -outfmt 6 -out 23270_53993.out
a_vs_b <- try(read_comparison_from_blast("blast/23270_53993.out"))

#Rango a graficar
xlims <- list(c(1,1000000), c(1,1000000))

#Argumentos secuencias a y b
plot_gene_map(dna_segs=list(a_23270, b_53993),
              #Salida de blast tabulada  
              comparisons=list(a_vs_b),
              xlims=xlims,
              #Encabezado plor
              main="23270 vs 53993, comparison",
              gene_type="side_blocks",
              dna_seg_scale=TRUE, scale=FALSE)




