# Genetic Drift

## Create a haploid population of 1000 individuals with alleles 0 or 1 --------#

# Number of individuals:
N <- 1000

# Population of individuals '0' or '1':
pop <- rep(0:1, each = N/2)

# or:
pop <- rep(0:1, times = c(500, 500))

# or:
pop <- rep(0:1, times = c(0.5, 0.5)*N)

## define vector with the frequencies of allele 0 in 2000 generations ---------#

# Number of generations
ngens <- 2000

# vector:
p <- numeric(ngens)

# The 1st element of vector 'p' will be the allele frequency in 1st generation:
p[1] <- mean(pop == 0)

# Now we have to calculate the allele frequencies in the next generations.
# Let's use a 'for loop' to calculate the frequency in each generation and
# save the result as an element of vector 'p':
for(i in 2:ngens) {
  
  # the next generation is a random sample of the parental population:
  pop <- sample(pop, replace = TRUE)
  
  # allele frequency in the ith generation:
  p[i] <- mean(pop == 0)
}

# Plot
plot(p, type = "l", 
     xlab = "generations", ylab = "frequency", 
     main = "allele frequency change")
