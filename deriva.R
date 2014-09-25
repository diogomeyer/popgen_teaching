# Genetic Drift

# Simulate a haploid population of 1000 individuals with alleles 0 or 1
pop <- rep(x=0:1, times=c(500,500))

# define an allele frequency vector (allele 0) over 2000 generations
p <- numeric(length=2000)

# the frequency of the allele 0 in the first generation (parental)
## will be the first element of our vector p:
p[1] <- mean(pop == 0)

# For each of the next generations
## calculate the allele frequency:
for(i in 2:2000) {
  
  # the next generation is a random sample of the parental pop:
  pop <- sample(pop, replace=TRUE)
  
  # allele frequency in the ith generation
  p[i] <- mean(pop == 0)

}

# Plot
plot(p, type="l", ylim=c(0,1), 
     xlab="generations", ylab="frequency", main="allele frequency change")



# Now, let's do the same for multiple populations
plot(0, type="n", xlim=c(0, 2000), ylim=c(0, 1),
     xlab="generations", ylab="frequency", main="allele frequency change")

# for each population (N = 10)
for(i in 1:10) {
  
  pop <- rep(x=0:1, times=c(500, 500))
  p <- numeric(2000)
  p[1] <- mean(pop == 0)

  for(j in 2:2000) {
    pop <- sample(pop, replace=TRUE)
    p[j] <- mean(pop == 0)
  }
  
  lines(p, type="l", col=rainbow(10)[i])
}


# Now, instead of the allele frequency, let's plot the heterozygosity

# call the plot function
plot(0, type="n", xlim=c(0, 2000), ylim=c(0, 0.5),
     xlab="generations", ylab="H", main="heterozygosity change")

# for each population (N = 10)
for(i in 1:10) {
  
  pop <- rep(x=0:1, times=c(500,500))
  p <- numeric(2000)
  p[1] <- mean(pop == 0)
  
  for(j in 2:2000) {
    pop <- sample(pop, replace=TRUE)
    p[j] <- mean(pop == 0)
  }
  
  # calculate the heterozygosity
  H <- 2*p*(1-p)
  
  # plot
  lines(H, type="l", col = rainbow(10)[i])
}

# Let's also draw the line of the theoretical decrease in the heterozygosity

N <- 1000
hetz <- numeric(2000)

for(i in 1:2000) {
 hetz[i] <- 0.5 * (1-(1/N))^i
}

# vectorized alternative:
hetz <- 0.5 * (1-(1/N))^(1:2000)

# add theoretical line to the plot
lines(hetz, lty=2, lwd=3)
text(x=1900, y=0.1, labels="theoretical value")
