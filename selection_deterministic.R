# Deterministic selection models
# Advantageous dominant mutation

source("popgen_functions")



# applying the to a deterministic simualtion
p.cod <- numeric()
p.dom <- numeric()
p.rec <- numeric()
#p.cod[1] <- 5e-03
p.cod[1] <- 0.001 
p.dom[1] <- 0.001
p.rec[1] <- 0.001
for(i in 2:1000)
    { 
        p.cod[i] <- delta.p(p.cod[i-1], 0.02, 0.5)
        p.dom[i] <- delta.p(p.dom[i-1], 0.02, 0)
        p.rec[i] <- delta.p(p.rec[i-1], 0.02, 1)
    }
plot(p.cod, type="l", col="red", xlab="Generation", ylab="Allele frequency (p)")              
lines(p.dom, type="l", col="black")
lines(p.rec, type="l", col="blue")



# Plot of delta p (change in frequency between two generations
# as a function of time
delta.p <- numeric()
for(i in 2:500){delta.p[i] <- p[i]-p[i-1]}
plot(delta.p, type="lines")

