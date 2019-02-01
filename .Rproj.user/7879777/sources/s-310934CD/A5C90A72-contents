#' @title A Set of Top Functions
#'
#' @description A set of top functions
#'
#' @param data
#'
#' @param varX
#'
#' @param varY
#'
#' @param categ
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
