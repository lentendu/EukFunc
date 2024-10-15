#' Assign functional group based on a partial PR2 taxonomic path
#'
#' Read a taxonomy path and assign the corresponding functional group in the condensed clade database by partial matches of the provided taxonomy onto the full database clade path
#'
#' @param x a vector of taxonomy path OR a data-frame with taxonomy path in a column named "taxonomy" or "Taxonomy" OR a data-frame with column named after PR2 v4.12.0 taxonomic ranks
#' @param ref the reference database for performing the functional assignment, default to \code{\link{DBc}}
#' @param sep separator character used to separate taxonomic ranks in the taxonomic path
#' @param empty_string a vector of element accepted for missing taxonomic information at a single taxonomic rank
#' @details
#' Using ref parameter, other database can be used to assign a function
#' @return a data-frame composed of:
#' \itemize{
#'   \item{}{taxonomy: the input taxonomy path}
#'   \item{}{all other columns if `x` is a data-frame}
#'   \item{}{assigned_from: the matched taxonomy path in the condensed database}
#'   \item{}{assigned_at_rank: the deepest taxonomic rank name of the matched taxonomy path}
#'   \item{}{assigned_from_taxa: the deepest clade name of the matched taxonomy path}
#'   \item{}{all the columns of SoilEukFunc database containing the functional informations}
#' }
#' @seealso \code{\link{consensing}}, \code{\link{DBc}}, \code{\link{DBc_main}}
#' @examples
#' taxo_path <-
#'   c("Eukaryota;Alveolata;Ciliophora;Colpodea;Colpodea_X;Colpodida;Colpoda;Colpoda_cucullus;",
#'     "Eukaryota;Opisthokonta;Fungi;Ascomycota;Pezizomycotina;Sordariomycetes;Fusarium;Fusarium_sp.;")
#' assign_path(taxo_path)
#'
#' # Using a data-frame with separated taxonomic rank columns as input:
#' path_func_exa <- assign_path(taxo_exa)
#' dplyr::count(path_func_exa, assigned_at_rank)
#' dplyr::count(path_func_exa, main_functional_class)
#'
#' \dontrun{
#' # Using a data-frame with a taxonomy column as input:
#' path_func_exa2 <- assign_path(taxo_exa2)
#' dplyr::count(path_func_exa2, assigned_at_rank)
#' dplyr::count(path_func_exa2, main_functional_class)
#'
#' # Improve the assignment using the condensed database only for the main functional class:
#' path_func_exa2 <- assign_path(taxo_exa2, ref=DBc_main)
#' dplyr::count(path_func_exa2, assigned_at_rank)
#' dplyr::count(path_func_exa2, main_functional_class)
#'
#' # Compare with published results
#' dplyr::count(path_func_exa2, Functions, main_functional_class)
#' }
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom stats setNames
#' @export
assign_path <- function(x, ref=DBc, sep=";", empty_string=c(NA, "NA", "", " ")) {
  if ( is.vector(x) & is.character(x) ) {
    y <- sub(";*$", "", gsub(sep, ";", gsub(".:", "", x)))
  } else if ( is.data.frame(x) ) {
    if ( any(grepl("[Tt]axonomy", colnames(x))) ) {
      tx <- grep("[Tt]axonomy", colnames(x), value=T)
      y <- sub("(;NA)*$","",sub(";*$", "", gsub(sep, ";", gsub(".:", "", getElement(x, tx)))))
    } else if ( length(which(unlist(lapply(taxonomic_ranks,function(x) c(x,Cap(x)))) %in% colnames(x))) >= 4 ) {
      y <- select(x, any_of(unlist(lapply(taxonomic_ranks,function(x) c(x,Cap(x)))))) %>%
        mutate(across(everything(),~replace(., . %in% empty_string, NA))) %>%
        mutate(across(everything(),~gsub("^[^:]*:", "", .))) %>%
        tidyr::unite("tax", sep=";") %>%
        mutate(tax=sub("(;NA)*;NA$", "", .data$tax)) %>%
        pull(.data$tax)
    } else {
      stop("Input data-frame does not contain a 'taxonomy' or 'Taxonomy' column, or at least four taxonomic rank columns")
    }
  } else {
    stop("Input format error")
  }
  yu <- unique(y)
  z <- plyr::ldply(setNames(yu,yu), function(i) {
    ref[which(!is.na(pmatch(ref$taxonomy, i))),]
  }, .id="taxo") %>%
    select(-"count") %>%
    rename(assigned_from="taxonomy", assigned_at_rank="level", assigned_from_taxa="taxa", taxonomy="taxo")
  if ( is.vector(x) ){
    tmpo <- data.frame(inp=x, taxonomy=y)
  } else {
    if ( any(grepl("[Tt]axonomy", colnames(x))) ) {
      tmpo <- data.frame(inp=getElement(x, tx), select(x, -all_of(tx)), taxonomy=y)
    } else {
      tmpo <- data.frame(x, taxonomy=y)
    }
  }
  left_join(tmpo,z,by=c("taxonomy"="taxonomy")) %>%
    select(-"taxonomy") %>%
    rename(any_of(c("taxonomy"="inp")))
}
