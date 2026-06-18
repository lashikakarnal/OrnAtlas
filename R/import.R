#' Import STAR count files into OrnAtlas
#'
#' @param file_paths Named character vector of paths to
#'   ReadsPerGene.out.tab files. Names become sample IDs.
#' @param col_data A data.frame with sample metadata.
#' @param strandedness One of "reverse", "forward", "unstranded"
#'
#' @return A SummarizedExperiment object
#' @export
#'
#' @examples
#' \dontrun{
#' files <- c(Stage1 = "path/to/sample1/ReadsPerGene.out.tab")
#' importRosaCounts(files, col_data = metadata)
#' }
importRosaCounts <- function(file_paths,
                             col_data,
                             strandedness = "reverse") {

  # Choose correct column based on strandedness
  col_idx <- switch(strandedness,
                    reverse     = 4L,
                    forward     = 3L,
                    unstranded  = 2L
  )

  message("Reading ", length(file_paths), " STAR count files...")

  # Read each file
  count_list <- lapply(seq_along(file_paths), function(i) {
    fp <- file_paths[i]
    if (!file.exists(fp))
      stop("File not found: ", fp)

    # Read STAR output - skip first 4 summary rows
    dat <- utils::read.table(fp, header = FALSE,
                      sep = "\t", skip = 4,
                      stringsAsFactors = FALSE)
    # Extract counts column
    counts <- dat[, col_idx]
    names(counts) <- dat[, 1]
    counts
  })

  # Keep only genes present in all samples
  common_genes <- Reduce(intersect, lapply(count_list, names))
  message("Common genes across all samples: ", length(common_genes))

  # Build count matrix
  count_matrix <- do.call(cbind, lapply(count_list, function(x) x[common_genes]))
  colnames(count_matrix) <- names(file_paths)
  rownames(count_matrix) <- common_genes
  storage.mode(count_matrix) <- "integer"

  # Build SummarizedExperiment object
  se <- SummarizedExperiment::SummarizedExperiment(
    assays  = list(counts = count_matrix),
    colData = S4Vectors::DataFrame(col_data)
  )

  message("Done! Created object with ",
          nrow(se), " genes x ", ncol(se), " samples")
  se
}
#' Normalize count data
#'
#' @param se A SummarizedExperiment object
#' @param method Normalization method: "CPM", "TMM", or "DESeq2_vst"
#' @param design Optional formula for DESeq2 methods
#'
#' @return SummarizedExperiment with normalized assay added
#' @export
#'
#' @examples
#' \dontrun{
#' se_norm <- normalizeCounts(se, method = "CPM")
#' }
normalizeCounts <- function(se,
                            method = c("CPM", "TMM", "DESeq2_vst"),
                            design = ~ 1) {

  method     <- match.arg(method)
  counts_mat <- SummarizedExperiment::assay(se, "counts")

  norm_mat <- switch(method,

                     "CPM" = {
                       t(t(counts_mat) / (colSums(counts_mat) / 1e6))
                     },

                     "TMM" = {
                       if (!requireNamespace("edgeR", quietly = TRUE))
                         stop("Install edgeR: BiocManager::install('edgeR')")
                       dge <- edgeR::DGEList(counts = counts_mat)
                       dge <- edgeR::calcNormFactors(dge, method = "TMM")
                       edgeR::cpm(dge, log = TRUE, prior.count = 1)
                     },

                     "DESeq2_vst" = {
                       if (!requireNamespace("DESeq2", quietly = TRUE))
                         stop("Install DESeq2: BiocManager::install('DESeq2')")
                       dds <- DESeq2::DESeqDataSet(se, design = design)
                       dds <- DESeq2::estimateSizeFactors(dds)
                       as.matrix(SummarizedExperiment::assay(
                         DESeq2::vst(dds, blind = TRUE)))
                     }
  )

  SummarizedExperiment::assay(se, method) <- norm_mat
  message("[OrnAtlas] Normalization complete: assay '",
          method, "' added.")
  se
}
