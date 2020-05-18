library(tidyverse)


n <- 3
mu <- 540
sigma <- 5


#Z-toets

sample <- rnorm(n, mu, sigma)
mean(sample)
sd(sample)
pnorm(mean(sample), mu, sd(sample)/sqrt(n))



ps <- replicate(10000, Ztest(n, mu, sigma))

length(ps[ps<0.05])/length(ps)

#Functie om steekproef te nemen en z-toets erop uit te voeren
z_sigma <- function(n, mean, sigma) {
  sample <- rnorm(n, mean, sigma)
  p <- pnorm(mean(sample), mean, sigma/sqrt(n))
  return(p)
}

#10000 keer bovenstaande functie uitvoeren
ps <- replicate(10000, z_sigma(n=30, mean=540, sigma=5))
hist(ps)
length(ps[ps<0.05])/length(ps)

#Wanneer je standaardeviatie weet
Z <- function(n, mu, sigma) {
  sample <- rnorm(n, mu, sigma)
  return ((mean(sample)-mu)/(sigma/sqrt(n)))
}

Zs <- replicate(10000, Z(n, mu, sigma))


#Wanneer je standaarddeviatie niet weet
t <- function(n, mu, sigma) {
  sample <- rnorm(n, mu, sigma)
  return((mean(sample)-mu)/(sd(sample)/sqrt(n)))
}

ts <- replicate(10000, t(n, mu, sigma))
length(ts[ts<0.05])/length(ts)

#Nu met t-toets
ttoets <- function(n, mu, sigma) {
  sample <- rnorm(n, mu, sigma)
  return(t.test(sample, mu=mu)$p.value)
  
}

tp <- replicate(10000, ttoets(n, mu, sigma)) 
hist(tp)
length(tp[tp<0.05])/length(tp)

densityplot <- function(v) {
  data.frame(v) %>% 
    ggplot(aes(v)) +
    geom_histogram(aes(y=..density..), fill = "red") +
    stat_function(fun = dnorm, size = 1) +
    xlim(-4,4) +
    theme_classic()
  
}
densityplot(Zs)
densityplot(ts)
hist(ts)
range(ts)


t_s <- function(n, mu, sigma) {
  sample <- rnorm(n, mu, sigma)
  return((mean(sample)-mu)/(sd(sample)/sqrt(n)))
}
n <- 100000
m <- 1:n
s <- 1:n
for(i in 1:n) {
  sample <- rnorm(5,540, 5)
  m[i] <- mean(sample)
  s[i] <- sd(sample)
}
tibble(m,s) %>% 
  ggplot(aes(m,s)) +
  stat_density_2d(aes(fill = stat(level)), geom = "polygon") +
  geom_hline(aes(yintercept = 5, colour = "red")) +
  geom_vline(aes(xintercept = 540, colour = "red")) +
  theme_classic()
