#' Rosa chinensis Gene Annotation Database
#'
#' @description
#' A curated annotation table mapping generic gene IDs from the
#' RchiOBHm-V2 reference genome (used by STAR alignment output)
#' to official Rosa chinensis locus names and gene biotype
#' classifications. Extracted from the NCBI RchiOBHm-V2 GFF3
#' annotation file.
#'
#' @format A data frame with 51,302 rows and 3 variables:
#' \describe{
#'   \item{gene_id}{Generic gene identifier used in STAR
#'     ReadsPerGene.out.tab files (e.g., "gene0", "gene1")}
#'   \item{locus_name}{Official RchiOBHm-V2 locus name
#'     (e.g., "RchiOBHm_Chr1g0312971")}
#'   \item{gene_biotype}{Gene biotype classification
#'     (e.g., "protein_coding", "lncRNA")}
#' }
#'
#' @source NCBI RefSeq assembly GCF_002994745.2 (RchiOBHm-V2),
#'   Rosa chinensis 'Old Blush' reference genome.
#'   \url{https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_002994745.2/}
#'
#' @references
#' Hibrand Saint-Oyant L, et al. (2018) A high-quality genome
#' sequence of Rosa chinensis to elucidate ornamental traits.
#' Nature Plants 4: 473-484.
#'
#' @examples
#' data(rosa_annotation)
#' head(rosa_annotation)
#' table(rosa_annotation$gene_biotype)
"rosa_annotation"
#' Rosa chinensis Example Expression Dataset
#'
#' @description
#' A small subset of the OrnAtlas Rosa chinensis expression atlas
#' for use in package examples and testing. Contains 500 highly
#' variable genes across 6 samples: 3 petal and 3 abscission zone
#' samples from publicly available NCBI SRA data.
#'
#' @format A \code{SummarizedExperiment} object with:
#' \describe{
#'   \item{dim}{500 genes x 6 samples}
#'   \item{assays}{counts — raw read counts}
#'   \item{colData}{126 metadata columns including tissue_simple,
#'     tissue_clean, Cultivar, dev_stage, BioProject}
#'   \item{rowData}{gene_id — STAR gene identifiers}
#'   \item{metadata}{species, strandedness, import_date,
#'     ornAtlas_version}
#' }
#'
#' @source NCBI SRA BioProjects PRJNA562083 and PRJNA594099.
#'   Rosa chinensis 'Old Blush' and related cultivars.
#'   Aligned to RchiOBHm-V2 reference genome (GCF_002994745.2).
#'
#' @examples
#' data(rosa_example)
#' rosa_example
#' table(rosa_example$tissue_simple)
#' head(SummarizedExperiment::assay(rosa_example, "counts")[1:5, 1:3])
"rosa_example"
