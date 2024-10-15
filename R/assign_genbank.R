#' Assign functional group based on genbank accession
#'
#' Read one or multiple genbank accessions, extract the corresponding taxonomy from the SoilEukFunc full database, compute consensus taxonomy if multiple accessions are provided and assign the corresponding functional group using \code{\link{assign_path}}
#'
#' @param x a vector or list of genbank accessions
#' @param ... further arguments passed to \code{\link{assign_path}} and \code{\link{consensing}}
#' @return a data-frame with the input list of accessions and the outputs of \code{\link{consensing}} and \code{\link{assign_path}}
#' @seealso \code{\link{consensing}}, \code{\link{DBf}}, \code{\link{assign_path}}, \code{\link{assign_sp}}
#' @examples
#' acc<-c("AB918716.1,EU039893.1,JF747215.1",
#'        "EU039893.1, JF747215.1",
#'        "AB918716.1,EU039893.1,JF747215.1",
#'        "ABC")
#' assign_genbank(acc)
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom methods formalArgs
#' @export
assign_genbank <- function(x,...) {
  argu<-list(...)
  if( length(argu) == 0 ) {
    consensing(x) %>%
      select("accession", "assigned_taxonomy") %>%
      rename(taxonomy="assigned_taxonomy") %>%
      assign_path()
  } else {
    argu_cons <- c(unlist(argu[names(argu) %in% formalArgs(consensing)[-1]]))
    if ( length(argu_cons) == 0 ) {
      tmp <- consensing(x)
    } else {
      tmp <- do.call(consensing, list(x, argu_cons))
    }
    tmp<-select(tmp, "accession", "assigned_taxonomy") %>%
      rename(taxonomy="assigned_taxonomy")
    argu_path <- list(c(unlist(argu[names(argu) %in% formalArgs(assign_path)[-1]])))
    if ( length(argu_path) == 0 ) {
      assign_path(tmp)
    } else {
      do.call(assign_path, list(tmp, argu_path))
    }
  }
}
