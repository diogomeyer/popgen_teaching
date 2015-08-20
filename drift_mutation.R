## Drift and mutation formulas and trajectories

# Functions: ----------------------------------------------------------------- #
# H_eq computes the equilibrium heterozygosity 
H_eq <- function(N, u) { 
  
  theta <- 4 * N * u 
  H <- theta / (theta + 1) 
  return(H) 
} 

# f_change computes the change in f under drift and mutation 
f_change <- function(f, N, u) { 
  
  f_prime <- ((1 / (2 * N)) + ((1 - (1 / (2 * N))) * f)) * (1 - u)^2 
  return(f_prime)
}
# ---------------------------------------------------------------------------- #

# Approach to equilibrium for 20000 generations assuming N=5000 and u=10^-4
# Parameters:
ngens <- 20000
N <- 5000
u <- 10^-4
# ---------------------------------------------------------------------------- #

# Plot:
f_res <- numeric(ngens)
f_res[1] <- 0.6

for (i in 2:ngens)
  f_res[i] <- f_change(f_res[i - 1], N, u)

plot(f_res, ylab = "homozygosity", xlab = "generations", ylim = c(0, 1))  

# checking the value of convergence and observed value
abline(h = H_eq(N, u)) # for heterozygosity
abline(h = 1 - H_eq(N, u)) # for homozygosity
