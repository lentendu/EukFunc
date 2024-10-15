#' Taxonomic assignment of an example protist ASV dataset from neotropical rainforest soils
#'
#' This example taxonomic assignment dataset comes from a subset of an unpublished dataset of protist V4 ASV from La Selva Neotropical rainforest soil.
#' The subset is use as example sequence dataset to demonstrate standard bioinformatic procedure in the book chapter Lentendu, G., Lara, E., Geisen, S. (2022).
#' This dataset correspond to the taxonomic table at the end of the bioinformatic workflow, describing the taxonomic composition of each final ASV.
#'
#' @format A data frame with 1533 rows and 19 variables:
#' \describe{
#'   \item{repseq}{SHA1 of representative sequence}
#'   \item{kingdom}{consensus taxonomy at rank 1}
#'   \item{supergroup}{consensus taxonomy at rank 2}
#'   \item{division}{consensus taxonomy at rank 3}
#'   \item{class}{consensus taxonomy at rank 4}
#'   \item{order}{consensus taxonomy at rank 5}
#'   \item{family}{consensus taxonomy at rank 6}
#'   \item{genus}{consensus taxonomy at rank 7}
#'   \item{species}{consensus taxonomy at rank 8}
#'   \item{bootstrap1}{consensus percentage at rank 1}
#'   \item{bootstrap2}{consensus percentage at rank 2}
#'   \item{bootstrap3}{consensus percentage at rank 3}
#'   \item{bootstrap4}{consensus percentage at rank 4}
#'   \item{bootstrap5}{consensus percentage at rank 5}
#'   \item{bootstrap6}{consensus percentage at rank 6}
#'   \item{bootstrap7}{consensus percentage at rank 7}
#'   \item{bootstrap8}{consensus percentage at rank 8}
#'   \item{reference}{Genbank/PR2 accession(s) of best match(es) used to assign the consensus taxonomy}
#'   \item{similarity}{percentage similarity between the representative sequence and the best match(es)}
#' }
#' @references Lentendu, G., Lara, E., Geisen, S., 2023. Metabarcoding Approaches For Soil Eukaryotes, Protists and Microfauna, in: Martin, F., Uroz, S. (Eds.), Microbial Environmental Genomics (MEG), Methods in Molecular Biology. Springer, New York, NY
#' @source https://github.com/lentendu/V4_SSU_ASV_bioinformatic_pipeline
#' @docType data
#' @usage data(taxo_exa)
"taxo_exa"

