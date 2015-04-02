## set parameters
# population size

# 
# source("popgen_functions.R")

# Call function for the deterministic selection model
source("popgen_functions.R")

N <- 50000 # number of chromossomes in sample (i.e. twice the number of diploid individuals)

# generations
ngen <- 600

# selection coefficient
s <- 0.05

# dominance coefficient # h=0 dominant for fitness
h <- 0.5

# initial allele frequency
#f <- 0.1
f <- 1/N

# number of replicates

reps <- 100

# number of fixations
fix <- 0
#####

# Open plot device
plot(0, xlim=c(0, ngen), ylim=c(0, 1), type="n",
#plot(0, xlim=c(0, 120), ylim=c(0, 10/N), type="n",
     xlab="generation", ylab="frequency", 
     main=paste("s =", s, "h =", h, "N =", N, ""))


## do the calculations reps times
for(i in 1:reps) { 
  
  # allele freq vector
  p <- numeric(ngen) 

  # initial frequency of allele "0"
  p[1] <- f
  # create the initial population vector
  pop <- rep(x=0:1, times=round(c(f, 1-f)*N))  

  # for each subsequent generation
  for(j in 2:length(p)) { 
    pop <- sample(pop, replace=TRUE)  # one round of drift
    af  <- mean(pop == 0)            # take the frequency of allele "0" 
    p[j] <- delta.p(af, s, h)       # selectoin on the allele 
    pop <- rep(x=0:1, times=round(c(p[j], 1-p[j])*N))  # make population based on new allele freq
    if(p[ngen] > 0){fix <- fix +1} # count fixations
  } 
 

  # plot the values for population i
  lines(p, type="l", col="grey60", lty=2) 
} 

# deterministic curve 
pd <- numeric(ngen) 
pd[1] <- f

for(i in 2:length(pd)) { 
#  pd[i] <- (pd[i-1]) / (1 - (s*(1-pd[i-1])^2)) 
   # pd[i] <- delta.p(pd[i-1], 1, 0.975 , 0.95) 
   pd[i] <- delta.p(pd[i-1],  s , h) 
} 

# plot
lines(pd, lwd=3, col="red")


legend(x=1500, y=0.2, 
       legend=c("simulated populations", "deterministic curve"),
       lty=c(2,1), lwd=c(1,3), col=c("grey60","black"), bty="n")


