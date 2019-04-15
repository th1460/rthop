#' @title Crosstabs to use with purrr::map
#'
#' @description Perform crosstabs to use with purrr::map
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

crosstab2 <- function(data, varX, varY, categ){

  varx <- rlang::sym(varX)
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
