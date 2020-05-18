library(tidyverse)

heat <- read_csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter11/chap11e3Temperature.csv"))
heat <- read.table("http://venus.unive.it/romanaz/statistics/data/bodytemp.txt")
heat <- read_delim("http://venus.unive.it/romanaz/statistics/data/bodytemp.txt", delim = " ")

heat %>% 
  mutate(tc = round((tf-32)*(5/9), digits=1)) %>%
  mutate(hr = as.numeric(hr)) %>% 
  mutate(gen = recode(gen, "   1"="man", "   2"="vrouw")) %>% 
  select(tc,gen, hr) %>% 
  write_csv("../data/lichaamstemperatuur.csv")
