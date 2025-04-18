% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functionize.R
\name{functionize}
\alias{functionize}
\title{Condense taxonomy across parameters}
\usage{
functionize(df, taxo_names, func_names, empty_string = c(NA, "NA", "", " "))
}
\arguments{
\item{df}{a data-frame}

\item{taxo_names}{a vector of column names containing the taxonomic information.
Column names are typically taxonomic ranks.
Order of the columns should follow the taxonomy hierarchy, with higher rank first (e.g. domain).}

\item{func_names}{a vector of column name(s) containing the functional information}

\item{empty_string}{a vector of element accepted for missing taxonomic information at a single taxonomic rank}
}
\value{
a data-frame with the reduced taxonomy from `taxo_names` for which a unique combination of parameter(s) from `func_names` was found.
        Condensed lower taxonomy rank(s) will be returned empty.
        Three columns, `level`, `taxa` and `count`, will be append to the data frame to provide the taxonomic rank, the name of the taxa at that rank and the amount of lowest taxonomic ranks included in that taxa for which a unique set of functional information was found.
}
\description{
Condense unique clade information along a taxonomic table
}
\details{
The function \code{functionize} is typically used to condense the taxonomy of one or multiple clades around one or multiple functional information or traits.

The less number of functional information use, the more condense the taxonomy will be.

The function \code{functionize} is used to create the condensed database \code{\link{DBc}} of the \code{EukFunc} using the species unique database \code{\link{DBu}} as input.
}
\examples{
kingdom<-rep("Eukaryota", 3)
division<-c(rep("Fungi", 2), "Ciliophora")
genus<-c("Antrodia", "Hypomyces", "Colpoda")
func<-c(rep("saprotroph", 2), "phagotroph")
detailed<-c("wood saprotroph", "litter saprotroph", "bacteria and small protist phagotroph")
x <- data.frame(kingdom=kingdom, division=division, genus=genus, func=func, detailed=detailed)
functionize(x, c("kingdom", "division", "genus"), "func")
functionize(x, c("kingdom", "division", "genus"), c("func", "detailed"))
}
\seealso{
\code{\link{DBc}}, \code{\link{DBc_main}}
}
