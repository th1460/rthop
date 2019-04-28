#' @title source R code
#'
#' @description Source R code
#'
#' @param file
#'
#' @param a lines
#'
#' @return NULL
#'
#' @examples NULL
#'
#' @export

run <- function(file, lines) {source(textConnection(readLines(file)[lines]))}
