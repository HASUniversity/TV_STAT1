library(tidyverse)
library(readxl)

blackbirds <- read_csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter12/chap12e2BlackbirdTestosterone.csv"))
View(blackbirds)
t.test(blackbirds$beforeImplant, blackbirds$afterImplant, paired = FALSE)

blackbirds %>% 
  ggplot(aes(logBeforeImplant, logAfterImplant)) +
  geom_point() +
  geom_abline(slope=1, intercept=0) +
  theme_classic()

blackbirds$verschil = blackbirds$logBeforeImplant-blackbirds$logAfterImplant
hist(blackbirds$verschil)
