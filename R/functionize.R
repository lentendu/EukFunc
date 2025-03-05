#' Condense taxonomy across parameters
#'
#' Condense unique clade information along a taxonomic table
#'
#' @param df a data-frame
#' @param taxo_names a vector of column names containing the taxonomic information.
#'                   Column names are typically taxonomic ranks.
#'                   Order of the columns should follow the taxonomy hierarchy, with higher rank first (e.g. domain).
#' @param func_names a vector of column name(s) containing the functional information
#' @param empty_string a vector of element accepted for missing taxonomic information at a single taxonomic rank
#' @return a data-frame with the reduced taxonomy from `taxo_names` for which a unique combination of parameter(s) from `func_names` was found.
#'         Condensed lower taxonomy rank(s) will be returned empty.
#'         Three columns, `level`, `taxa` and `count`, will be append to the data frame to provide the taxonomic rank, the name of the taxa at that rank and the amount of lowest taxonomic ranks included in that taxa for which a unique set of functional information was found.
#' @details
#' The function \code{functionize} is typically used to condense the taxonomy of one or multiple clades around one or multiple functional information or traits.
#'
#' The less number of functional information use, the more condense the taxonomy will be.
#'
#' The function \code{functionize} is used to create the condensed database \code{\link{DBc}} of the \code{EukFunc} using the species unique database \code{\link{DBu}} as input.
#' @seealso \code{\link{DBc}}, \code{\link{DBc_main}}
#' @examples
#' kingdom<-rep("Eukaryota", 3)
#' division<-c(rep("Fungi", 2), "Ciliophora")
#' genus<-c("Antrodia", "Hypomyces", "Colpoda")
#' func<-c(rep("saprotroph", 2), "phagotroph")
#' detailed<-c("wood saprotroph", "litter saprotroph", "bacteria and small protist phagotroph")
#' x <- data.frame(kingdom=kingdom, division=division, genus=genus, func=func, detailed=detailed)
#' functionize(x, c("kingdom", "division", "genus"), "func")
#' functionize(x, c("kingdom", "division", "genus"), c("func", "detailed"))
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom rlang .data :=
#' @export
functionize <- function(df, taxo_names, func_names, empty_string=c(NA, "NA", "", " ")) {

  # count all unique combinations of full taxonomic path and function fields, if multiple
  mat<-mutate(df,across(all_of(taxo_names),~replace(as.character(.), . %in% empty_string, NA))) %>%
    summarize(count=n(),.by=all_of(c(taxo_names,func_names)))

  # loop over taxonomic levels, find the shortest taxonomic path with a single functional annotation
  res<-NULL
  for(i in 2:length(taxo_names)) {
    ti<-summarize(mat,count=sum(count),.by=c(taxo_names[1:i],func_names)) %>%
      group_by_at(taxo_names[1:i]) %>%
      mutate(n=n()) %>%
      ungroup()
    if( any(ti$n == 1) ) {
      if(is.null(res)) {
        res<-filter(ti,n==1) %>%
          select(-n) %>%
          mutate(level=taxo_names[i],
                 taxa=getElement(.data,taxo_names[i]))
      } else {
        res<-bind_rows(res,
                       filter(ti,n==1) %>%
                         select(-n) %>%
                         mutate(level=taxo_names[i],
                                taxa=getElement(.data,taxo_names[i])))
      }
      mat<-anti_join(mat,
                     filter(ti,n==1) %>%
                       select(!!taxo_names[1:i]),
                     by=taxo_names[1:i])
    }
    if (nrow(mat) == 0) {
      break
    } else if( i == length(taxo_names) ) {
      warning("some of the lowest taxonomic levels have multiple functional information")
      bind_rows(res,select(mat,-n))
    }
  }
  # return taxonomic ranks, functional annotation
  select(res,any_of(taxo_names),all_of(func_names),.data$level,.data$taxa,.data$count) %>%
    mutate(across(any_of(taxo_names),~tidyr::replace_na(as.character(.),"")))
}
