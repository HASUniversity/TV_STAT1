c <- rnorm(5,0,1)
d <- rnorm(5,5,10)
t.test(c,d)
var.test(c,d)

ttoets <- function(n, sa,sb) {
  a <- rnorm(n, 0, sa)
  b <- rnorm(n, 0, sb)
  return(t.test(a,b, var.equal = FALSE)$p.value)
}

tp <- replicate(10000, ttoets(n=5, sa=1, sb=5))

alpha <- 0.05
length(tp[tp<alpha])/length(tp)
