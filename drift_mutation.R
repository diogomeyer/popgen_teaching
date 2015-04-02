## Drift and mutation formulas and trajectories

# Functions: ----------------------------------------------------------------- #
# H.eq computes the equilibrium heterozygosity 
H.eq <- function(N, u) { 
  
  theta <- 4*N*u 
  H <- theta/(theta+1) 
  return(H) 
} 

# Example run 
#plot(H.eq(seq(100,1000000,10000), 10^-6)) 
 
# f_change computes the change in f under drift and mutation 
f_change <- function(f, N, u) { 
  
  f.prime <- (((1/(2*N)) + ((1 - (1/(2*N)))*f))*((1-u)^2)) 
  return(f.prime)
}
# ---------------------------------------------------------------------------- #

# Approach to equilibrium for 20000 generations assuming N=5000 and u=10^-4
# Parameters: ---------------------------------------------------------------- #
ngen <- 20000
N <- 5000
u <- 10^-4
# ---------------------------------------------------------------------------- #

f.res <- numeric(ngen)
f.res[1] <- 0.6

for(i in 2:ngen) {
  f.res[i] <- f_change(f.res[i-1], N, u)
}

plot(f.res, ylab = "homozygosity", xlab = "generations", ylim = c(0, 1))  
# lines(f.res) # add other values of 'N' or 'u' to the same plot  
  
# Consider the Amerindian populations with low values for 'H' 
## (around 0.6 for microsatellites). 
## For N=5000 and u=10^-4, how much time it would take to return to equilibrium?
    
# checking the relationship of the convergence with the equilibrium value:
f.res <- numeric(ngen)
f.res[1] <- 0.2

for(i in 2:ngen) {
  f.res[i] <- f_change(f.res[i-1], N, u)
}

plot(f.res, ylab = "homozygosity", xlab = "generations", ylim = c(0, 1))  

# checking the value of convergence and observed value:
abline(h = H.eq(N, u))           
