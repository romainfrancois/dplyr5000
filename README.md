
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dplyr5000

The package contains a tibble with 5000 rows, one for each of the first
5000 travis builds of [dplyr](https://github.com/tidyverse/dplyr).

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
# remotes::install_github("romainfrancois/dplyr5000")
library(dplyr5000)

dplyr5000 %>% 
  group_by(state) %>% 
  tally(sort = TRUE)
#> # A tibble: 4 x 2
#>   state        n
#>   <chr>    <int>
#> 1 passed    3133
#> 2 failed     952
#> 3 errored    767
#> 4 canceled   148
```
