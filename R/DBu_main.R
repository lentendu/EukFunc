#' Species level version of the EukFunc database.
#'
#' A database containing the taxonomy of all soil-associated protists,
#' fungi and nematodes species from PR2 v5.0.0 and
#' the functional assignments of the EukFunc database.
#'
#' @format A data frame with 16850 rows and 14 variables:
#' \describe{
#'   \item{domain}{consensus taxonomy at rank 1}
#'   \item{supergroup}{consensus taxonomy at rank 2}
#'   \item{division}{consensus taxonomy at rank 3}
#'   \item{subdivision}{consensus taxonomy at rank 4}
#'   \item{class}{consensus taxonomy at rank 5}
#'   \item{order}{consensus taxonomy at rank 6}
#'   \item{family}{consensus taxonomy at rank 7}
#'   \item{genus}{consensus taxonomy at rank 8}
#'   \item{species}{consensus taxonomy at rank 9}
#'   \item{assigned_from}{matched taxonomy path in the DBC_main condensed database with a unique functional class information}
#'   \item{main_functional_class}{Main nutrient uptake mode of a given taxon with additional information for symbiotroph}
#'   \item{secondary_functional_class}{Secondary nutrient uptake mode of a given taxon with additional information for symbiotroph}
#'   \item{assigned_at_rank}{deepest taxonomic rank name of the matched taxonomy path in the DBC_main condensed database with a unique functional class information}
#'   \item{assigned_from_taxa}{deepest clade name of the matched taxonomy path in the DBC_main condensed database with a unique functional class information}
#' }
#' @docType data
#' @usage
#' data(DBu_main)
#'
"DBu_main"
