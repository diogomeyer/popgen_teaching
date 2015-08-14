# GENETIC DRIFT

# This is a simulation of genetic drift. We define a population of a certain
# number of indivuduals (gametes, in this case). Next, we produce another
# generation (that is, a new population, descendant from the previous one). This
# new generation is of the same size of the parental one, and, to create it, we
# sample its gametes randomly from the parental population.

# In this case the gametes can be of two types: "A" or "T". This is an allusion
# to the DNA of each gamete. We could also call them "A" and "a", since there
# are only two types of gametes.

# At each generation, we measure the proportion of gametes "A" with respect to
# total. For example, if the population has 10 gametes, and five of them are "A"
# we would compute 0.5, since half of the gametes are "A". We store this number
# for each generation.

# What we will see is that, given the randomness of the process (remember we
# sampled the gametes randomly), after a big number of generations, either we
# fixate "A", or "T". In other words, either the proportion of gametes "A"
# converges to zero (it disapears from the population, and "T" dominates) or
# converges to one ("T" disapears from the population, and we only have "A"s).

# Finally, we plot the proportion of "A" in each generation.

# MODEL PARAMETERS
#------------------------------------------------------------------------------#
nindividuals <- 1000 # Number of gametes in the population
ngenerations <- 2000 # Number of generation we will simulate
#------------------------------------------------------------------------------#



# CREATE THE ORIGINAL POPULATION
#------------------------------------------------------------------------------#
# Here we create a haploid population of 1000 individuals with alleles "A" or
# "T". We store this population on a list (or vector, in the R jargon), called
# "population". On this simulation, we will plot only the frequencies of "A" on
# each generation, therefore, we don't need to store all populations at once.

# We create a population, compute the frequency of allele "A" of it, sample the
# next generation, and throw the population away. Actually, all the populations
# will be stored in "population". In other words: the list "population" holds
# only the latest generation we simulated.

# Create a list of gametes, half "A" and half "T": this is our first generation
population <- rep(c("A", "T"), each = nindividuals/2)
#------------------------------------------------------------------------------#



# ALLELIC FREQUENCIES
#------------------------------------------------------------------------------#
# Here we create a list of frequencies of allele "A" throughout the generations.
# At first, we create a empty list (actually, in R, its full of NAs, that
# simbolize that the values are still missing). While we simulate the
# generations, we will compute each one's frequency of "A", and put it inside
# this list.

# You can also notice that the 1st element of this list is the frequency of "A"
# in the 1st generation, the 2nd element corresponds to the second generation
# and so on. In programming jargon, we can state the same by saying: "the i'th
# element of this vector is the frequency of "A" in the i'th generation"

# Create a list of frequencies of "A" throughout the generations. The size of
# the vector is the number of generations. All elements are NA (Not Available).
freqA <- rep(NA, ngenerations)
#------------------------------------------------------------------------------#



# SIMULATION
#------------------------------------------------------------------------------#
# Here we simulate the generations, computing the frequency of "A" for each one,
# storing in the list "freqA".

# This frequency is the mean of the gametes that are equal to "A". For example,
# if we have 5 gametes "A" in a total of 10, the mean of the gametes "A" is 1/2,
# and that's the same that the frequency of "A" in the population.

# Here we compute the frequency of "A" for the original generation, and store
# this frequency in the first element of the list "freqA"
freqA[1] <- mean(population == "A")

# Now we have to simulate the next generations, and compute its "A" frequency.
# Intead of doing it by hand, we use a for-loop. Inside the loop, we have the
# variable i, that varies from 2 to maximum number of generations.
for(i in 2:ngens) {
  # Here, inside the for-loop, the variable "i" is the generation we are
  # simulating. For example, if "i" is equal to 5, we are simulating the 5'th
  # generation. Remember: this "i" varies from 2 to maximum number of
  # generations. These are the generations we simulate.

  # The next generation is created. To do so, we change the "population"
  # vector, by randomly sampling the gametes from the previous population.
  population <- sample(population, replace = TRUE)

  # Compute the frequency of "A" in the population we just simulated.
  freqA[i] <- mean(population == "A")
}
#------------------------------------------------------------------------------#



# PLOTTING
#------------------------------------------------------------------------------#
# Here we plot the frequence of A against the generations. What we see (most of
# the time), is that one of the alleles is fixed after some generations.

# Plot a line, with the data of "freqA"
plot(freqA, type = "l", ylim = c(0, 1),
     xlab = "generations", ylab = "frequency",
     main = "allele frequency change")
#------------------------------------------------------------------------------#
