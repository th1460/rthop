#' @title Frequency
#'
#' @description Perform frequencies
#'
#' @param data
#'
#' @param var
#'
#' @return NULL
#'
#' @examples NULL
#'
#' @export

freq <- function(data, var){

  var <- enquo(var)

  table <-
    data %>%
    count(!! var) %>%
    mutate(`%` = round(n/sum(n, na.rm = TRUE) * 100, 2)) %>%
    rename(Categoria = !! var, N = n)

  tibble(Variable = quo_name(quo(!! var))) %>%
    bind_rows(tibble(Variable = rep(NA, nrow(table) -1))) %>%
    bind_cols(table) %>%
    mutate(Variable = ifelse(is.na(Variable), "", Variable))

}
