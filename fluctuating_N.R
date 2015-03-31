# vector of popsizes

n <- round(100*(runif(100)))
h <- numeric()
h[1] <- 0.5

for(i in 2:100)
    {
    h[i] <- h[i-1]* (1- (1/(n[i-1])))
    }
plot(h)

ne <- (sum(n^-1)/length(n))^-1
lines(0.5 * (1 - (1/ne))^(1:100))


