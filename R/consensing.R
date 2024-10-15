#' Compute consensus taxonomy
#'
#' A consensus taxonomy is created from multiple Genbank accessions matching PR2 accessions present in the EukFunc full database
#'
#' @param x a vector or list of comma separated genbank accessions
#' @param cons consensus threshold in percent, default to 60
#' @param sep_string separator for multiple accessions in one element, default to comma
#' @param no_match value to search for for an absence of math, default to "no_match"
#' @return a data-frame with the provided accessions, the assign taxonomy path, the assign clade and the assign taxonomic rank
#' @seealso \code{\link{DBf}}
#' @examples
#' acc<-c("AB918716.1,EU039893.1,JF747215.1",
#'        "EU039893.1, JF747215.1",
#'        "AB918716.1,EU039893.1,JF747215.1",
#'        "ABC")
#' consensing(acc)
#'
#' \dontrun{
#' # Compare to already assigned taxonomy:
#' cons_exa <- consensing(taxo_exa$reference)
#' cbind(input=tidyr::unite(taxo_exa, taxonomy, 2:9, sep=";")$taxonomy,
#'       dplyr::select(cons_exa, assigned_taxonomy, matched_accession, assigned_consensus))
#' }
#'
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom stats setNames
#' @importFrom utils tail
#' @export
consensing <- function(x, cons=60, sep_string=",", no_match="no_match") {
  plyr::ldply(setNames(x,x), function(y) {
    if ( y == no_match ) {
      c(assigned_taxonomy="no_match", assigned_consensus=NA, matched_accession=NA, assigned_to=NA, assigned_level=NA)
    } else {
      trows<-pmatch(sub("\\..*", "", unlist(strsplit(gsub(" ", "", y), sep_string))), DBf$pr2_accession)
      if ( all(is.na(trows)) ) {
        c(assigned_taxonomy="unknown", assigned_consensus=NA, matched_accession=paste0("0/", length(trows)) , assigned_to=NA, assigned_level=NA)
      } else {
        tmp <- DBf[trows[!is.na(trows)], taxonomic_ranks] %>% droplevels()
        if ( any(plyr::laply(plyr::llply(tmp, levels), length) > 1) ) {
          tmpt <- c(assigned_taxonomy="no_consensus", assigned_consensus=NA,
                    matched_accession=paste(length(which(!is.na(trows))), length(trows), sep="/"),
                    assigned_to=NA, assigned_level=NA)
          for (i in rev(taxonomic_ranks) ) {
            tmpm <- tail(sort(summary(tmp[, i])), 1)
            if ( tmpm/nrow(tmp)*100 >= cons )  {
              tmpt <- c(assigned_taxonomy=paste(unlist(filter(tmp, !!as.name(i) == names(tmpm)) %>%
                                                       slice_head() %>%
                                                       select(1:which(taxonomic_ranks==i))),
                                              collapse=";"),
                        assigned_consensus=unname(round(tmpm/nrow(tmp)*100)),
                        matched_accession=unname(tmpt["matched_accession"]),
                        assigned_to=names(tmpm),
                        assigned_level=i)
              break
            }
          }
          return(tmpt)
        } else {
          c(assigned_taxonomy=paste(unlist(tmp[1,]), collapse=";"),
            assigned_consensus=100,
            matched_accession=paste(length(which(!is.na(trows))), length(trows), sep="/"),
            assigned_to=as.character(tmp[1, 8]),
            assigned_level=taxonomic_ranks[8])
        }
      }
    }
  }, .id="accession")
}
