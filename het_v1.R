# ---------------------------------------------------------------------------- #
# Parameters:
# Pop size
N <- 1000

# Number of generations
ngens <- 2000

# Number of populations
npops <- 10

# ---------------------------------------------------------------------------- #

# Create matrices to store results.
# Each row will be a generation and each column, a population.

# Heterozygosities:
H <- matrix(nrow = ngens, ncol = npops)

# Allele frequencies:
P <- matrix(nrow = ngens, ncol = npops) 

# ---------------------------------------------------------------------------- #

 H <- 2 * P * (1-P)


# ---------------------------------------------------------------------------- #

# plotting the heterozygosities:
plot(NA, type = "n", xlim = c(0, ngens), ylim = c(0, 0.5),
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
plot(apply(P, 1, mean), type = "l", 
     xlab = "generation", ylab = "average frequency")

# ---------------------------------------------------------------------------- #

# plotting the variance in allele frequency
plot(apply(P, 1, var), type = "l", xlab = "generation", ylab = "variance")
