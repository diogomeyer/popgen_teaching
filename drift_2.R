# ---------------------------------------------------------------------------- #
# Parameters:
# Pop size
N <- 1000

# Number of generations
ngens <- 2000

# Number of populations
npops <- 10

# ---------------------------------------------------------------------------- #

# Create a matrix to store results.
# Each row will be a generation and each column, a population.

# Allele frequencies:
P <- matrix(nrow = ngens, ncol = npops) 

# ---------------------------------------------------------------------------- #

# for each population (N = 10)
for(i in 1:npops) {
  
  pop <- rep(0:1, each = N/2)
  P[1, i] <- mean(pop == 0)
  
  for(j in 2:ngens) {
    pop <- sample(pop, replace = TRUE)
    P[j, i] <- mean(pop == 0)
  }
}

H <- 2 * P * (1-P)

# ---------------------------------------------------------------------------- #

# plotting the heterozygosities:
plot(NA, type = "n", xlim = c(1, ngens), ylim = c(0, 0.5),
     xlab = "generation", ylab = "H", main = "heterozygosity change")

# plot H for each population (columns) individually. Noisy!
apply(H, 2, lines, col = "grey", lty = 2)

# plot the mean across generations (rows)
lines(rowMeans(H))

# Let's also draw the line of the theoretical decrease in the heterozygosity
h_theor <- 0.5 * (1-(1/N))^(1:ngens)
lines(h_theor, lty = 3, lwd = 3)

# ---------------------------------------------------------------------------- #

# plotting the average allele frequency
#### Check: this is not the correct plot
plot(rowMeans(P), type = "l", xlab = "generation", ylab = "average frequency")

# ---------------------------------------------------------------------------- #

# plotting the variance in allele frequency
plot(apply(P, 1, var), type = "l", xlab = "generation", ylab = "variance")
