#' Minimal condensed version of the SoilEukFunc database.
#'
#' A database containing the condensed taxonomy of all soil-associated protists,
#' fungi and nematodes clades from PR2 version 4.12.0 and
#' their unique main functional class from the SoilEukFunc database.
#'
#' @format A data frame with 4901 rows and 5 variables:
#' \describe{
#'   \item{taxonomy}{Taxonomic path of clades for which a unique functional information is available}
#'   \item{main_functional_class}{Main nutrient uptake mode of a given taxon}
#'   \item{level}{Taxonomic rank name at which the functional assignment is condensed/unique}
#'   \item{taxa}{Clade name at which the functional assignment is condensed/unique}
#'   \item{count}{Amount of species grouped under the same functional assignment}
#' }
#' @docType data
#' @usage data(DBc_minimal)
#' @seealso \code{\link{DBu}}, \code{\link{DBc}}, \code{\link{DBc_main}}
"DBc_minimal"
