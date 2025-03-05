#' Eukaryotic Soil Functional assignment tools and database
#'
#' Assign functional information to terrestrial protist, fungi and nematodes.
#'
#' Provide the database of functional assignment at sequence, species and aggregated clade levels
#' 
#' @author Guillaume Lentendu \email{guillaume.lentendu@@unine.ch}
#' 
#' @keywords internal
"_PACKAGE"

#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom plyr ldply laply llply
#' @importFrom tidyr unite separate replace_na
#' @importFrom rlang sym
globalVariables(c("DBc","DBc_main","DBc_minimal","DBf","DBu","DBu_main"))
NULL
