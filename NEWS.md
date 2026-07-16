# OrnAtlas 0.1.0

## New features

* `importCustomAtlas()` - universal import for any plant species
* `buildRosaAtlas()` - curated Rosa chinensis atlas import  
* `normalizeCounts()` - CPM, TMM, DESeq2-VST normalization
* `buildAtlas()` + `plotAtlas()` - expression atlas construction
* `plotPCA()` - PCA visualization with botanical theme
* `runDE()` - DESeq2-based differential expression analysis
* `plotVolcano()` - publication-quality volcano plot
* `annotateGenes()` + `annotateDEResults()` - Rosa chinensis annotation
* `getRosaAnnotation()` - access 51,302-gene annotation database
* `ornTheme()` - botanical ggplot2 theme

## Built-in data

* `rosa_annotation` - 51,302 Rosa chinensis gene annotations (RchiOBHm-V2)
* `rosa_example` - 500 genes x 6 samples example dataset

## First release

* First Bioconductor package for ornamental plant transcriptomics
* 270-sample Rosa chinensis expression atlas from 10+ NCBI BioProjects
* Validated on Tagetes erecta (marigold) as second species
* 0 errors, 0 warnings on R CMD check
