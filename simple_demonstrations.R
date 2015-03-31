# Fraction of total A alleles that are carried by heterozygotes
# as a function of allele frequency

fraction.hetz <- function(p){(2*p*(1-p))/(((2*p*(1-p))+(p^2)))}
plot(hetz, ylab="fraction carried by hetz", xlab="Frequency of A allele (p)")
