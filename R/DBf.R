#' Full version of the EukFunc database.
#'
#' A database containing sequence id and taxonomy of all soil-associated protists,
#' fungi and nematodes from PR2 v5.0.0 and
#' the functional assignments of the EukFunc database.
#'
#' @format A data frame with 105558 rows and 20 variables:
#' \describe{
#'   \item{pr2_accession}{PR2 specific accession number}
#'   \item{domain}{consensus taxonomy at rank 1}
#'   \item{supergroup}{consensus taxonomy at rank 2}
#'   \item{division}{consensus taxonomy at rank 3}
#'   \item{subdivision}{consensus taxonomy at rank 4}
#'   \item{class}{consensus taxonomy at rank 5}
#'   \item{order}{consensus taxonomy at rank 6}
#'   \item{family}{consensus taxonomy at rank 7}
#'   \item{genus}{consensus taxonomy at rank 8}
#'   \item{species}{consensus taxonomy at rank 9}
#'   \item{main_functional_class}{Main nutrient uptake mode of a given taxon}
#'   \item{detailed_functional_class}{Full description of the main mode of nutrition}
#'   \item{secondary_functional_class}{Secondary nutrient uptake mode of a given taxon}
#'   \item{detailed_secondary_functional_class}{Full description of the secondary mode of nutrition}
#'   \item{associated_organism}{Group of organisms involved in the trophic relationship, if any}
#'   \item{associated_material}{Type of material the organism is feeding on when this cannot be identified as organismal}
#'   \item{environment}{Predominant habitat or environment in which the organism is functionally active}
#'   \item{potential_human_pathogen}{Potential pathogenicity to humans: "opportunistic", "probably opportunistic" or empty for no known pathogenicity}
#'   \item{comment}{Miscellaneous information}
#'   \item{reference}{Source of information in the form of a DOI link to original publication, previous databases, review studies or textbooks listing rough functional classes, whenever possible}
#' }
#' @docType data
#' @usage data(DBf)
#' @seealso [DBu()], [pr2database::pr2()]
"DBf"
