% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DBu_main.R
\docType{data}
\name{DBu_main}
\alias{DBu_main}
\title{Species level version of the SoilEukFunc database.}
\format{
A data frame with 14119 rows and 22 variables:
\describe{
  \item{kingdom}{taxonomic rank 1}
  \item{supergroup}{taxonomic rank 2}
  \item{division}{taxonomic rank 3}
  \item{class}{taxonomic rank 4}
  \item{order}{taxonomic rank 5}
  \item{family}{taxonomic rank 6}
  \item{genus}{taxonomic rank 7}
  \item{species}{taxonomic rank 8}
  \item{assigned_from}{matched taxonomy path in the DBC_main condensed database with a unique functional class information}
  \item{main_functional_class}{Main nutrient uptake mode of a given taxon with additional information for symbiotroph}
  \item{secondary_functional_class}{Secondary nutrient uptake mode of a given taxon with additional information for symbiotroph}
  \item{assigned_at_rank}{deepest taxonomic rank name of the matched taxonomy path in the DBC_main condensed database with a unique functional class information}
  \item{assigned_from_taxa}{deepest clade name of the matched taxonomy path in the DBC_main condensed database with a unique functional class information}
}
}
\usage{
data(DBu_main)
}
\description{
A database containing the taxonomy of all soil-associated protists,
fungi and nematodes species from PR2 version 4.12.0 and
the functional assignments of the SoilEukFunc database.
}
\keyword{datasets}
