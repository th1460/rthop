#' @title Crosstabs
#'
#' @description Perform crosstabs
#'
#' @param data Dataset
#'
#' @param varX Variable
#'
#' @param varY Variable
#'
#' @param categ Choose category from y variable to analyse
#'
#' @return NULL
#'
#' @examples NULL
#'
#' @export

crosstab <- function(data, varX, varY, categ){

  varx <- enquo(varX)
  vary <- enquo(varY)

  table <-
    data %>%
    count(!! varx, !! vary) %>%
    group_by(!! vary) %>%
    mutate(`%` = round(n/sum(n, na.rm = TRUE) * 100, 2)) %>%
    filter(!! varx == categ) %>%
    select(- !! varx) %>%
    rename(vary = !! vary, N = n)

  table %>%
    mutate(Variable = quo_name(quo(!! varx))) %>%
    dcast(Variable ~ vary, value.var = "%")
}
