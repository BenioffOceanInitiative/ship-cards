library(tidyverse)
library(glue)
#library(shipr)
# devtools::install_github("mvisalli/shipr")
# devtools::install_local("../shipr", force=T)
# devtools::document("../shipr")
devtools::load_all("../shipr")

#data(sbais)

ships <- sbais %>% 
  group_by(name) %>% 
  summarize(n = n()) %>% 
  arrange(desc(n)) %>% 
  slice(c(10:20,300:310))

#View(ships)

make_card <- function(ship){
  out_html <- paste0("docs/ship/", ship, ".html")
  
  cat(glue("{ship}\n\n"))
  
  # cat(glue("  ship_segments\n\n"))
  segs <- ship_segments(sbais, ship, dir_data="data")
  # cat(glue("  ship_limits\n\n"))
  lims <- ship_limits(segs, limit_knots = 10, ship, dir_data="data")
  
  if (file.exists(out_html)) return()
    
  cat(glue("  {out_html}\n\n"))
  rmarkdown::render(
    "ship_card.Rmd",
    params = list(ship_name = ship),
    output_file = out_html)
}

#make_card("PINZA")
ships$name %>% walk(make_card)

# for (i in 1:length()){
#   ship <- ships$name[13:20][i]
#   out_html <- paste0("docs/ship/", ship, ".html")
#   if (!file.exists(out_html)) make_card(ship)
# }
