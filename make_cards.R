library(tidyverse)
library(shipr)
# devtools::install_github("mvisalli/shipr")
# devtools::install_local("../shipr", force=T)
# devtools::document("../shipr")
# devtools::load_all("../shipr")

# get subset of ships based on number of locations, some high, some low
ships <- sbais %>% 
  group_by(name) %>% 
  summarize(n = n()) %>% 
  arrange(desc(n)) %>% 
  slice(c(10:20,300:310))

make_card <- function(ship){
  rmarkdown::render(
    input       = "ship_card.Rmd",
    params      = list(ship_name = ship),
    output_file = paste0("docs/ship/", ship, ".html"))
}

# make_card("NAUTILUS")
ships$name %>% walk(make_card)
