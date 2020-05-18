library(tidyverse)

lizard <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter12/chap12e3HornedLizards.csv"))

lizard %>%
  na.omit(squamosalHornLength) %>% 
  ggplot(aes(Survival, squamosalHornLength)) +
  stat_boxplot(geom = "errorbar", width = 0.5) +
  geom_boxplot(fill = "lightgrey") +
  expand_limits(y=0) +
  ylab("horn length (mm)") +
  theme_classic()

lizard %>%
  na.omit(squamosalHornLength) %>% 
  ggplot(aes(Survival, squamosalHornLength)) +
  geom_jitter(width = 0.2, height = 0) +
  ylab("horn length (mm)") +
  theme_classic()

lizard %>%
  na.omit(squamosalHornLength) %>%
  group_by(Survival) %>% 
  summarise(mean_horn_length = mean(squamosalHornLength), 
            se = sd(squamosalHornLength)/sqrt(length(squamosalHornLength))) %>% 
  ggplot(aes(Survival, mean_horn_length)) +
  geom_col(fill = "lightgrey", color = "black") +
  geom_errorbar(aes(ymin = mean_horn_length - se,
                    ymax = mean_horn_length + se), width = 0.5) +
  ylab("horn length (mm)") +
  expand_limits(y=30) +
  theme_classic()

lizard %>%
  na.omit(squamosalHornLength) %>% 
  group_by(Survival) %>% 
  count()
