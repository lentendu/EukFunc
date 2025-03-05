#' Assign functional group at species level
#'
#' Read a species list and assign the corresponding functional group in the unique species database by exact matches of species names
#'
#' @param x a vector of species names OR a data-frame with species names in a column named "species" or "Species"
#' @return a data-frame composed of the input vector or columns, a new column `species_name` use to perform the match and all the columns of the species unique SoilEukFunc database without taxonomy.
#'         Species names with no match return the SoilEukFunc databases columns filled with NA.
#' @seealso \code{\link{assign_path}}, \code{\link{assign_genbank}}
#' @examples
#' data(taxo_exa)
#' sp_func_exa<-assign_sp(taxo_exa)
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom rlang sym .data
#' @export
assign_sp <- function(x) {
  if( is.character(x) & is.vector(x) ) {
    data.frame(species=x) %>%
      mutate(species_name=sub("^[a-z]:", "", .data$species)) %>%
      left_join(mutate(DBu,across(all_of(func_classes),as.character)) %>%
                  select("species", !!func_classes), by=c("species_name"="species"))
  } else if ( is.data.frame(x) ) {
    if ( any(grepl("[Ss]pecies", colnames(x))) ) {
      y <- rlang::sym(grep("[Ss]pecies", colnames(x), value=T))
      mutate(x, species_name=sub("^[a-z]:", "", !!y)) %>%
        left_join(mutate(DBu,across(all_of(func_classes),as.character)) %>%
                    select("species", !!func_classes), by=c("species_name"="species"))
    } else {
      stop("A 'species' or 'Species' column is expected in the input data-frame")
    }
  } else {
    stop("A vector or data-frame is expected as input")
  }
}
