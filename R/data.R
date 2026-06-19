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
