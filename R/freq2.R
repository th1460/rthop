#' @title Frequency to use with purrr::map
#'
#' @description Perform frequencies to use with purrr::map
#'
#' @param data Dataset
#'
#' @param var Variable
#'
#' @return NULL
#'
#' @examples NULL
#'
#' @export

freq2 <- function(data, var){

  var <- rlang::sym(var)

  table <-
    data %>%
    filter(!is.na(!! var)) %>%
    count(!! var) %>%
    mutate(`%` = round(n/sum(n, na.rm = TRUE) * 100, 2)) %>%
    rename(Categoria = !! var, N = n)

  tibble(Variable = quo_name(quo(!! var))) %>%
    bind_rows(tibble(Variable = rep(NA, nrow(table) -1))) %>%
    bind_cols(table) %>%
    mutate(Variable = ifelse(is.na(Variable), "", Variable))

}
