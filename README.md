rthop
================

A set of top functions.

## Examples

Table with frequency analysis (`freq2`)

``` r
library(rthop)
library(dplyr)

dataset <- 
  titanic::titanic_train %>% 
  select(Survived, Pclass, Sex, Embarked) %>% 
  mutate_all(as.factor) %>% 
  filter(Sex != "", Embarked != "")

c("Survived", "Pclass", "Sex", "Embarked") %>% 
  purrr::map_dfr(~ freq2(dataset, var = .x))
```

    ## # A tibble: 10 x 4
    ##    Variable Categoria     N   `%`
    ##    <chr>    <chr>     <int> <dbl>
    ##  1 Survived 0           549 61.8 
    ##  2 ""       1           340 38.2 
    ##  3 Pclass   1           214 24.1 
    ##  4 ""       2           184 20.7 
    ##  5 ""       3           491 55.2 
    ##  6 Sex      female      312 35.1 
    ##  7 ""       male        577 64.9 
    ##  8 Embarked C           168 18.9 
    ##  9 ""       Q            77  8.66
    ## 10 ""       S           644 72.4

Transforme CEP in geographic coordinate (`cep2coo`)

``` r
c("20950240", "20090003", "22230090") %>% 
  purrr::map_dfr(~cep2coo(.x))
```

    ## # A tibble: 3 x 3
    ##   cep        lat   lon
    ##   <chr>    <dbl> <dbl>
    ## 1 20950240 -22.9 -43.3
    ## 2 20090003 -22.9 -43.2
    ## 3 22230090 -22.9 -43.2
