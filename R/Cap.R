#' Capitalize first letter
#' @param x is a character string or vector
#' @keywords internal
Cap <- function(x) paste0(toupper(substr(x, 1, 1)), substring(x, 2))
