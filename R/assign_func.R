#' Assign main and detailed functional group based on any PR2 clade
#'
#' Generalized approach to assign a functional group to a taxonomic path using either the condensed clade or unique clade databases.
#' When a taxonomic path could not be assigned to any functional group, assignment is the made on the database version containing only the main_functional class.
#'
#' @param x a vector of taxonomy path OR a data-frame with taxonomy path in a column named "taxonomy" or "Taxonomy" OR a data-frame with column named after PR2 v5.0.0 taxonomic ranks
#' @param assign function to apply, either \code{\link{assign_clade}} or \code{\link{assign_path}}
#' @param ref the reference database for performing the functional assignment, either \code{\link{DBc}}, \code{\link{DBu}} or a manual database containing at least a 'taxonomy' column
#' @param sep separator character used to separate taxonomic ranks in the taxonomic path
#' @param empty_string a vector of element accepted for missing taxonomic information at a single taxonomic rank
#' @return a data-frame composed of:
#' \itemize{
#'   \item the input taxonomy path 
#'   \item all other columns if `x` is a data-frame 
#'   \item assigned_from: the matched taxonomy path in the condensed database 
#'   \item assigned_at_rank: the deepest taxonomic rank name of the matched taxonomy path 
#'   \item assigned_from_taxa: the deepest clade name of the matched taxonomy path 
#'   \item all the columns of EukFunc database containing the functional informations
#' }
#' @seealso \code{\link{assign_clade}}, \code{\link{assign_path}}, \code{\link{DBu}}, \code{\link{DBc}}, \code{\link{DBu_main}}, \code{\link{DBc_main}}
#' @examples
#' taxo_path <-
#'   gsub("[\r\n ]","",
#'     c("Eukaryota;TSAR;Alveolata;Ciliophora;Colpodea;
#'       Colpodea_X;Colpodida;Colpoda;Colpoda_cucullus;",
#'       "Eukaryota;TSAR;Alveolata;Ciliophora;Colpodea;
#'       Colpodea_X;Platyophryida;Platyophrya;Platyophrya_sp.",
#'       "Eukaryota;Obazoa;Opisthokonta;Fungi;Ascomycota;
#'       Pezizomycotina;Sordariomycetes;Fusarium;Fusarium_sp.;"))
#' assign_func(taxo_path)
#'
#' # Using a data-frame with separated taxonomic rank columns as input:
#' path_func_exa <- assign_func(head(taxo_exa[10:19,]))
#' dplyr::count(path_func_exa, assigned_at_rank)
#' dplyr::count(path_func_exa, main_functional_class)
#' 
#' # Using a data-frame with a single taxonomy column:
#' path_func_exa <- assign_func(head(taxo_exa2))
#' dplyr::count(path_func_exa, assigned_at_rank)
#' dplyr::count(path_func_exa, main_functional_class)
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export
assign_func <- function(x, assign="clade", ref=DBc, sep=";", empty_string=c(NA, "NA", "", " ")) {
  if( assign == "clade" ) {
    tmp <- assign_clade(x, ref=ref, sep=sep, empty_string=empty_string)
  } else if ( assign == "path" ) {
    tmp <- assign_path(x, ref=ref, sep=sep, empty_string=empty_string)
  } else {
    stop(paste("unknown assign function: '",assign,"'"))
  }
  tmp_na <- filter(tmp, is.na(.data$assigned_at_rank))
  if ( nrow(tmp_na) > 0 ) {
    if (is.vector(x)) {
      tmp_na <- tmp_na$taxonomy
    } else {
      tmp_na <- select(tmp_na, all_of(colnames(x)))
    }
    DB <- deparse(substitute(ref))
    if( assign == "clade" ) {
      tmp2 <- assign_clade(tmp_na, ref=get(paste0(DB,"_main")), sep=sep, empty_string=empty_string)
    } else {
      tmp2 <- assign_path(tmp_na, ref=get(paste0(DB,"_main")), sep=sep, empty_string=empty_string)
    }
    # combine both results and sort to original order
    out <- bind_rows(filter(tmp, !is.na(.data$assigned_at_rank)), tmp2)
    if (is.vector(x)) {
      out2 <- left_join(data.frame(taxonomy=x), out, by="taxonomy", multiple="first")
    } else {
      out2 <- left_join(x, out, by=colnames(x), multiple="first")
    }
  } else {
    out2 <- tmp
  }
  # harmonize main_functional_class annotation for symbiotroph
  if( "main_functional_class" %in% colnames(out2) ) {
    rowwise(out2) %>%
      mutate(main_functional_class=ifelse(.data$main_functional_class=="symbiotroph" &
                                            !is.na(.data$detailed_functional_class) &
                                            .data$detailed_functional_class!="",
                                          get_symbio_det(.data$detailed_functional_class),
                                          .data$main_functional_class),
             secondary_functional_class=ifelse(.data$secondary_functional_class=="symbiotroph" &
                                                 !is.na(.data$detailed_secondary_functional_class) &
                                                 .data$detailed_secondary_functional_class!="",
                                               get_symbio_det(.data$detailed_secondary_functional_class),
                                               .data$secondary_functional_class)) %>%
      ungroup() %>%
      data.frame()
  } else {
    return(out2)
  } 
}
