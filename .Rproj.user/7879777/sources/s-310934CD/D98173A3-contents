#' @title A Set of Top Functions
#'
#' @description A set of top functions
#'
#' @param x
#'
#' @param a
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
