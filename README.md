
# rthop <img src='man/figures/hexsticker.png' align="right" height="139" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/th1460/rthop/workflows/R-CMD-check/badge.svg)](https://github.com/th1460/rthop/actions)
<!-- badges: end -->

A set of top functions.

## Install

``` r
remotes::install_github("th1460/rthop")
```

### Install dependencies

``` r
remotes::install_github("rCarto/photon")
```

## Examples

Frequency analysis (`freq`)

``` r
library(rthop)
library(dplyr)

dataset <- 
  titanic::titanic_train %>% 
  select(Survived, Pclass, Sex, Embarked) %>% 
  filter(Sex != "", Embarked != "") %>% 
  mutate_all(as.factor)

c("Survived", "Pclass", "Sex", "Embarked") %>% 
  purrr::map_dfr(~ freq(dataset, !! rlang::sym(.x)))
```

    ## # A tibble: 10 x 4
    ##    Variable Levels     N   `%`
    ##    <chr>    <fct>  <int> <dbl>
    ##  1 Survived 0        549 61.8 
    ##  2 <NA>     1        340 38.2 
    ##  3 Pclass   1        214 24.1 
    ##  4 <NA>     2        184 20.7 
    ##  5 <NA>     3        491 55.2 
    ##  6 Sex      female   312 35.1 
    ##  7 <NA>     male     577 64.9 
    ##  8 Embarked C        168 18.9 
    ##  9 <NA>     Q         77  8.66
    ## 10 <NA>     S        644 72.4

Contigency tables (`crosstab`)

``` r
c("Pclass", "Sex", "Embarked") %>%
  purrr::map_dfr(~ crosstab(dataset, !! rlang::sym(.x), Survived))
```

    ## # A tibble: 8 x 5
    ##   Variable Levels `0`         `1`         `P-value`            
    ##   <chr>    <fct>  <chr>       <chr>       <chr>                
    ## 1 Pclass   1      80 (14.6%)  134 (39.4%) "0 (Chi-square)"     
    ## 2 <NA>     2      97 (17.7%)  87 (25.6%)  "0% < 5 (Fisher = 0)"
    ## 3 <NA>     3      372 (67.8%) 119 (35%)   ""                   
    ## 4 Sex      female 81 (14.8%)  231 (67.9%) "0 (Chi-square)"     
    ## 5 <NA>     male   468 (85.2%) 109 (32.1%) "0% < 5 (Fisher = 0)"
    ## 6 Embarked C      75 (13.7%)  93 (27.4%)  "0 (Chi-square)"     
    ## 7 <NA>     Q      47 (8.6%)   30 (8.8%)   "0% < 5 (Fisher = 0)"
    ## 8 <NA>     S      427 (77.8%) 217 (63.8%) ""

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
