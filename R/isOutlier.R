#' @title Is a outlier
#'
#' @description In a distribution is defined whether a value is a outlier
#'
#' @param x Variable
#'
#' @param a Multiplicative factor (a * interquartile range)
#'
#' @return NULL
#'
#' @examples NULL
#'
#' @export

isOutlier <- function(x, a){

  outlier <- function(x, a){

    iiq <- x %>%
      quantile(c(.25, .75), names = FALSE, na.rm = TRUE) %>%
      diff()

    lim <- x %>%
      quantile(c(.25, .75), names = FALSE, na.rm = TRUE) + c(- a * iiq, a * iiq)

    return(lim)

  }

  ifelse(between(x, outlier(x, a)[1], outlier(x, a)[2]), FALSE, TRUE)

}
