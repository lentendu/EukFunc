#' Extract and format intermediate functional class information from symbiotroph detailed functional information
#' 
#' @param x a string from "detailed_functional_class" or "detailed_secondary_functional_class"
#' 
#' @return a string with intermediate symbiotroph class among parasite, mycorrhiza, host phototroph and other
#' 
#' @importFrom stringr str_replace
#' @importFrom magrittr %>%
#' @keywords internal
get_symbio_det<-function(x) {
  str_replace(x, "lichenized","host phototroph") %>%
    strsplit("; ") %>%
    unlist() %>%
    str_replace(".*(parasite|pathogen|mycorrhiz|host phototroph).*","\\1 #symbiotroph") %>%
    str_replace("^[^#]*$", "other symbiotroph") %>% 
    str_replace("#", "") %>%
    str_replace("mycorrhiz","mycorrhiza") %>%
    str_replace("pathogen","parasite") %>% 
    sort() %>%
    unique() %>% 
    paste(collapse="; ")
}
