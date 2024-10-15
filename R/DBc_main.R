#' Condensed version of the SoilEukFunc database.
#'
#' A database containing the condensed taxonomy of all soil-associated protists,
#' fungi and nematodes clades from PR2 version 4.12.0 and
#' their unique main functional assignments from the SoilEukFunc database.
#'
#' @format A data frame with 5749 rows and 6 variables:
#' \describe{
#'   \item{taxonomy}{Taxonomic path of clades for which a unique functional information is available}
#'   \item{main_functional_class}{Main nutrient uptake mode of a given taxon with additional information for symbiotroph}
#'   \item{secondary_functional_class}{Secondary nutrient uptake mode of a given taxon with additional information for symbiotroph}
#'   \item{level}{Taxonomic rank name at which the functional assignment is condensed/unique}
#'   \item{taxa}{Clade name at which the functional assignment is condensed/unique}
#'   \item{count}{Amount of species grouped under the same functional assignment}
#' }
#' @docType data
#' @usage data(DBc_main)
#' @seealso \code{\link{DBu}}, \code{\link{DBc}}
"DBc_main"
