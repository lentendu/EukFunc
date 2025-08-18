#' Condensed version of the EukFunc database.
#'
#' A database containing the condensed taxonomy of all soil-associated protists,
#' fungi and nematodes clades from PR2 v5.0.0 and
#' their unique functional assignment from the EukFunc database.
#'
#' @format A data frame with 7072 rows and 13 variables:
#' \describe{
#'   \item{taxonomy}{Taxonomic path of clades for which a unique functional information is available}
#'   \item{main_functional_class}{Main nutrient uptake mode of a given taxon}
#'   \item{detailed_functional_class}{Full description of the main mode of nutrition}
#'   \item{secondary_functional_class}{Secondary nutrient uptake mode of a given taxon}
#'   \item{detailed_secondary_functional_class}{Full description of the secondary mode of nutrition}
#'   \item{associated_organism}{Group of organisms involved in the trophic relationship, if any}
#'   \item{associated_material}{Type of material the organism is feeding on when this cannot be identified as organismal}
#'   \item{environment}{Predominant habitat or environment in which the organism is functionally active}
#'   \item{potential_human_pathogen}{Potential pathogenicity to humans: "opportunistic", "probably opportunistic" or empty for no known pathogenicity}
#'   \item{level}{Taxonomic rank name at which the functional assignment is condensed/unique}
#'   \item{taxa}{Clade name at which the functional assignment is condensed/unique}
#'   \item{count}{Amount of species grouped under the same functional assignment}
#' }
#' @docType data
#' @usage data(DBc)
#' @seealso \code{\link{DBu}}, \code{\link{DBc_main}}
"DBc"
