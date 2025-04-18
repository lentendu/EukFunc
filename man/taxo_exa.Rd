% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/taxo_exa.R
\docType{data}
\name{taxo_exa}
\alias{taxo_exa}
\title{Taxonomic assignment of an example protist ASV dataset from neotropical rainforest soils}
\format{
A data frame with 1447 rows and 13 variables:
\describe{
  \item{repseq}{SHA1 of representative sequence}
  \item{domain}{consensus taxonomy at rank 1}
  \item{supergroup}{consensus taxonomy at rank 2}
  \item{division}{consensus taxonomy at rank 3}
  \item{subdivision}{consensus taxonomy at rank 4}
  \item{class}{consensus taxonomy at rank 5}
  \item{order}{consensus taxonomy at rank 6}
  \item{family}{consensus taxonomy at rank 7}
  \item{genus}{consensus taxonomy at rank 8}
  \item{species}{consensus taxonomy at rank 9}
  \item{bootstrap}{consensus assignment percentage among best matches}
  \item{similarity}{percentage similarity between the representative sequence and the best match(es)}
  \item{reference}{Genbank/PR2 accession(s) of best match(es) used to assign the consensus taxonomy}
}
}
\source{
https://github.com/lentendu/V4_SSU_ASV_bioinformatic_pipeline
}
\usage{
data(taxo_exa)
}
\description{
This example taxonomic assignment dataset comes from a subset of an unpublished dataset of protist V4 ASV from La Selva Neotropical rainforest soil.
The subset is use as example sequence dataset to demonstrate standard bioinformatic procedure in the book chapter Lentendu, G., Lara, E., Geisen, S. (2023).
This dataset correspond to the taxonomic table at the end of the bioinformatic workflow, describing the taxonomic composition of each final ASV.
The taxonomy have been adjusted to PR2 v5.0.0 9 rank's taxonomy structure.
}
\references{
Lentendu, G., Lara, E., Geisen, S., 2023. Metabarcoding Approaches For Soil Eukaryotes, Protists and Microfauna, in: Martin, F., Uroz, S. (Eds.), Microbial Environmental Genomics (MEG), Methods in Molecular Biology. Springer, New York, NY
}
\keyword{datasets}
