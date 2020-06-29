#' @title Crosstabs
#'
#' @description Perform crosstabs
#'
#' @param data Dataset
#'
#' @param x Variable x
#'
#' @param y Variable y
#'
#' @param simulate.p.value Use p-value simulated
#'
#' @return NULL
#'
#' @examples NULL
#'
#' @export

crosstab <- function(data, x, y, simulate.p.value = FALSE) {

  table <-
    data %>%
    count({{x}}, {{y}}) %>%
    group_by({{y}}) %>%
    mutate(perc = round(n/sum(n, na.rm = TRUE) * 100, 2)) %>%
    ungroup() %>%
    mutate(z = glue("{n} ({perc %>% round(1)}%)") %>% as.character()) %>%
    select(-c(n, perc)) %>%
    pivot_wider(names_from = {{y}}, values_from = z, values_fill = list(z = "0 (0%)")) %>%
    rename(Levels = {{x}})

  contig_table <-
    data %>%
    select({{x}}, {{y}}) %>%
    na.omit() %>%
    as.data.frame() %>%
    table()

  chisq_test <-
    contig_table %>%
    chisq.test()

  validate <-
    ((chisq_test %$% expected) < 5) %>%
    mean() * 100

  fisher_test <-
    contig_table %>%
    fisher.test(simulate.p.value = simulate.p.value)

  tibble(Variable = quo_name(quo({{x}}))) %>%
    bind_rows(tibble(Variable = rep(NA, nrow(table) - 1))) %>%
    bind_cols(table) %>%
    mutate(Variable = ifelse(is.na(Variable), NA, Variable)) %>%
    bind_cols(

      `P-value` = c(
                    glue::glue("{chisq_test %$% p.value %>% round(4)} (Chi-square)"),
                    glue::glue("{validate %>% round(1)}% < 5 (Fisher = {fisher_test %$% p.value %>% round(4)})"),
                    rep("", nrow(table) - 2))

    )

}
