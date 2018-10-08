# remotes::install_github("romainfrancois/travis")
# (fork from ropenscilabs/travis with ... in travis_get_builds)
library(travis)
library(tidyverse)
library(lubridate)

builds_tbl <- function(limit = 100, offset = 0) {
  builds <- travis_get_builds(
    repo = "tidyverse/dplyr", token = .travis_token,
    query = list(limit = limit, offset = offset)
  )

  tibble(
    number = as.integer(map_chr(builds, "number")),
    state = map_chr(builds, "state"),
    event_type = map_chr(builds, "event_type"),
    branch = map_chr(builds, ~pluck(., "branch", "name") %||% NA_character_),
    user = map_chr(builds, ~pluck(., "created_by", "login") %||% NA_character_),
    commit_msg = map_chr(builds, pluck, "commit", "message"),
    committed_at = map_chr(builds, ~pluck(., "commit", "committed_at") %||% NA_character_) %>% ymd_hms(),
    started_at = map_chr(builds, ~ .$started_at %||% NA_character_ ) %>% ymd_hms(),
    finished_at = map_chr(builds, ~ .$finished_at %||% NA_character_ ) %>% ymd_hms(),
    jobs = map_int(builds, ~length(.$jobs))
  )
}

dplyr5000 <- map_dfr(1:50, ~ {
    cat("\r", .)
    builds_tbl(offset = (.x - 1) * 100)
  })

use_data(dplyr5000, overwrite = TRUE)
