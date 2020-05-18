library(tidyverse)
library(readxl)

mydata <- read_excel("../data/weer_20_juni.xlsx")
gemiddelde <- mean(mydata$gem_temp)
stdev <- sd(mydata$gem_temp)
range(mydata$gem_temp)

t <- seq(5, 30, by=0.1)
d <- dnorm(t, gemiddelde, stdev)
ndf <- data.frame(t,d)

ndf %>% 
  ggplot(aes(t,d)) +
  geom_line(color = "blue", size = 1) +
  scale_y_continuous(expand = c(0,0), limits = c(0, 0.14)) +
  ylab("density") +
  xlab("gem. temp. op 20 juni") +
  theme_classic(base_size = 13)

p <- round(pnorm(20, gemiddelde, stdev, lower.tail = FALSE), 2)

ndf %>% 
  ggplot(aes(t,d)) +
  geom_line(color = "blue", size = 1) +
  geom_ribbon(data=subset(ndf, t>20), 
              aes(ymin = 0, ymax = d), fill = "red") +
  scale_y_continuous(expand = c(0,0), limits = c(0, 0.14)) +
  ylab("density") +
  xlab("gem. temp. op 20 juni") +
  theme_classic(base_size = 13)

t.test(mydata$gem_temp)

mydata %>% 
  ggplot(aes(x="", y=gem_temp)) +
  geom_jitter(width = 0.05, height = 0, color = "blue") +
  xlab("20 juni (1901 t/m 2019)") +
  theme_classic(base_size = 13)

mydata %>% 
  ggplot(aes(gem_temp)) +
  geom_histogram(binwidth = 2) +
  theme_classic()

mydata %>% 
  ggplot(aes(jaar, gem_temp)) +
  geom_point() +
#  geom_hline(yintercept = gemiddelde, linetype = 2, size = 1, color = "red") +
#  geom_smooth(method = "lm", se = FALSE) +
  theme_classic(base_size =   13)

#Voorspelling voor 2019
fit <- lm(gem_temp~jaar, data = mydata)
summary(fit)
stdev2 <- sd(residuals(fit))
voorspelling <- predict(fit, data.frame(jaar <- c(2019)), se.fit = TRUE)
pnorm(20, voorspelling$fit, voorspelling$residual.scale, lower.tail = FALSE)

#Density plot voor 2019

density_2019 <- dnorm(t, voorspelling$fit, voorspelling$residual.scale)
d_2019 <- data.frame(t,density_2019)

d_2019 %>% 
  ggplot(aes(t,density_2019)) +
  geom_line(color = "blue", size = 1) +
  geom_ribbon(data=subset(d_2019, t>20), 
              aes(ymin = 0, ymax = density_2019), fill = "red") +
  scale_y_continuous(expand = c(0,0), limits = c(0, 0.14)) +
  ylab("density") +
  xlab("gem. temp. op 20 juni 2019") +
  theme_classic(base_size = 13)

#Een- of tweezijdig toetsen
ndf %>% 
  ggplot(aes(t, d)) +
  geom_line(color = "blue", size = 1) +
  geom_ribbon(data=subset(ndf, t<gemiddelde-7),
              aes(ymin = 0, ymax = d), fill = "red") +
  geom_ribbon(data=subset(ndf, t>gemiddelde+7),
              aes(ymin = 0, ymax = d), fill = "red") +
  scale_y_continuous(expand = c(0,0), limits = c(0, 0.14)) +
  ylab("density") +
  xlab("variabele") +
  theme_classic(base_size = 13)
  