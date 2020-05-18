library(tidyverse)
library(readxl)

cijfers <- read_excel("../data/cijfers.xlsx")
t.test(cijfers$biologie, cijfers$biocalculus)
t.test(cijfers$biologie, cijfers$biocalculus, paired = TRUE)
cijfers <- cijfers %>% filter(jaar == "2018")
t.test(cijfers$biologie, cijfers$biocalculus)
t.test(cijfers$biologie, cijfers$biocalculus, paired = TRUE)

wiskunde <- sample(cijfers$biocalculus, 5)
scheikunde <- sample(cijfers$scheikunde, 5)
t.test(wiskunde, scheikunde)

