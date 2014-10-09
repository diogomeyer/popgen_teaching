## set parameters
# population size
N <- 100

# generations
ngen <- 2000

# selection coefficient
s <- 0.05 

# initial allele frequency
f <- 0.1

# initializing value of the number of fixed populations
fix <- 0

#####

# Open plot device
plot(0, xlim=c(0, ngen), ylim=c(0, 1), type="n",
     xlab="generation", ylab="frequency", 
     main=paste("Allele frequency change over", ngen, "generations"))

## do the calculations
for(i in 1:20) { 
  
  # allele freq vector
  p <- numeric(ngen) 

  # initial frequency of allele "0"
  p[1] <- f
  
  # for each subsequent generation
  for(j in 2:length(p)) { 
    
    # calculate allele frequency after selection
    af <- p[j-1] / (1 - (s*(1-p[j-1])^2))

    # make population based on these allele frequencies
    pop <- rep(0:1, times=round(c(af, 1-af)*N))
    
    # sample with replacement to simulate drift
    pop <- sample(pop, replace=TRUE) 

    # take the frequency of allele "0"
    p[j] <- mean(pop == 0) 
    
    # count number of fixations
    if(p[ngen]==1){fix <- fix+1}
  } 
  
  # plot the values for population i
  lines(p, type="l", col="grey60", lty=2) 
} 

# deterministic curve 
pd <- numeric(ngen) 
pd[1] <- p[1]

for(i in 2:length(pd)) { 
  pd[i] <- (pd[i-1]) / (1 - (s*(1-pd[i-1])^2)) 
} 

# plot
lines(pd, lwd=3)
legend(x=1500, y=0.2, 
       legend=c("simulated", "deterministic"),
       lty=c(2,1), lwd=c(1,3), col=c("grey60","black"), bty="n")
       text(1800, 0.3, paste("fixed=",fix))
