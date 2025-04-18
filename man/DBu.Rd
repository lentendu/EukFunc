% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DBu.R
\docType{data}
\name{DBu}
\alias{DBu}
\title{Species level version of the EukFunc database.}
\format{
A data frame with 16850 rows and 19 variables:
\describe{
  \item{domain}{consensus taxonomy at rank 1}
  \item{supergroup}{consensus taxonomy at rank 2}
  \item{division}{consensus taxonomy at rank 3}
  \item{subdivision}{consensus taxonomy at rank 4}
  \item{class}{consensus taxonomy at rank 5}
  \item{order}{consensus taxonomy at rank 6}
  \item{family}{consensus taxonomy at rank 7}
  \item{genus}{consensus taxonomy at rank 8}
  \item{species}{consensus taxonomy at rank 9}
  \item{main_functional_class}{Main nutrient uptake mode of a given taxon}
  \item{detailed_functional_class}{Full description of the main mode of nutrition}
  \item{secondary_functional_class}{Secondary nutrient uptake mode of a given taxon}
  \item{detailed_secondary_functional_class}{Full description of the secondary mode of nutrition}
  \item{associated_organism}{Group of organisms involved in the trophic relationship, if any}
  \item{associated_material}{Type of material the organism is feeding on when this cannot be identified as organismal}
  \item{environment}{Predominant habitat or environment in which the organism is functionally active}
  \item{potential_human_pathogen}{Potential pathogenicity to humans: "opportunistic", "probably opportunistic" or empty for no known pathogenicity}
  \item{comment}{Miscellaneous information}
  \item{reference}{Source of information in the form of a DOI link to original publication, previous databases, review studies or textbooks listing rough functional classes, whenever possible}
}
}
\usage{
data(DBu)
}
\description{
A database containing the taxonomy of all soil-associated protists,
fungi and nematodes species from PR2 v5.0.0 and
the functional assignments of the EukFunc database.
}
\examples{
# Extract mixotrophs:
DBu_mixo<-dplyr::filter(DBu,
       ((grepl("host phototroph",detailed_functional_class) |
           main_functional_class=="phototroph") &
          secondary_functional_class=="predator") |
         ((grepl("host phototroph",detailed_secondary_functional_class) |
             secondary_functional_class=="phototroph") &
            main_functional_class=="predator"))

}
\keyword{datasets}
