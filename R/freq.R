#' @title Frequency
#'
#' @description Perform frequencies
#'
#' @param data Dataset
#'
#' @param x Variable
#'
#' @return NULL
#'
#' @examples NULL
#'
#' @export

freq <- function(data, x) {

  table <-
    data %>%
    filter(!is.na({{x}})) %>%
    count({{x}}) %>%
    mutate(`%` = round(n/sum(n, na.rm = TRUE) * 100, 2)) %>%
    rename(Levels = {{x}}, N = n)

  tibble(Variable = quo_name(quo({{x}}))) %>%
    bind_rows(tibble(Variable = rep(NA, nrow(table) - 1))) %>%
    bind_cols(table) %>%
    mutate(Variable = ifelse(is.na(Variable), NA, Variable))

}
