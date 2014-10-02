# Deterministic selection models
# Advantageous dominant mutation


delta.p <- function(p, s)
    { p.prime <- p /(1 - (s*((1-p)^2)))
      return(p.prime)
    }

p <- numeric()
p[1] <- 0.05 
for(i in 2:500)
    { p[i] <- delta.p(p[i-1], 0.2)}

plot(p, type="lines")

# Plot of delta p (change in frequency between two generations
# as a function of time
delta.p <- numeric()
for(i in 2:500){delta.p[i] <- p[i]-p[i-1]}
plot(delta.p, type="lines")

