#' Species level version of the SoilEukFunc database.
#'
#' A database containing the taxonomy of all soil-associated protists,
#' fungi and nematodes species from PR2 version 4.12.0 and
#' the functional assignments of the SoilEukFunc database.
#'
#' @format A data frame with 14119 rows and 22 variables:
#' \describe{
#'   \item{kingdom}{taxonomic rank 1}
#'   \item{supergroup}{taxonomic rank 2}
#'   \item{division}{taxonomic rank 3}
#'   \item{class}{taxonomic rank 4}
#'   \item{order}{taxonomic rank 5}
#'   \item{family}{taxonomic rank 6}
#'   \item{genus}{taxonomic rank 7}
#'   \item{species}{taxonomic rank 8}
#'   \item{assignment_confidence}{Functional assignment precision from "possible" and "probable" to "highly probable"}
#'   \item{assignment_level}{Taxonomic rank at which the functional classification is made}
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
#' @usage
#' data(DBu)
#' @examples
#' # Extract mixotrophs:
#' DBu_mixo<-dplyr::filter(DBu,
#'        ((grepl("host phototroph",detailed_functional_class) |
#'            main_functional_class=="phototroph") &
#'           secondary_functional_class=="predator") |
#'          ((grepl("host phototroph",detailed_secondary_functional_class) |
#'              secondary_functional_class=="phototroph") &
#'             main_functional_class=="predator"))
#'
"DBu"
