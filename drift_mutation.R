## Drift and mutation formulas and trajectories


# Function for computing equilibrium heterozygosity 
H.eq <- function(N, u) 
{ 
  theta <- 4*N*u 
  H <- theta/(theta+1) 
  return(H) 
} 
 
# Example run 
#plot(H.eq(seq(100,1000000,10000), 10^-6)) 
 
 
# Formula for change in f under drift and mutation 
f <- function(f, N, u) 
{ 
  f.prime <- (((1/(2*N)) + ((1 - (1/(2*N)))*f))*((1-u)^2)) 
  return(f.prime)
}

## approach to equilibrium for 20000 generations assuming N=5000 and u=10^-4

f.res <- numeric()
f.res[1] <- 0.6
for(i in seq(2,20000))
{
  f.res[i] <- f(f.res[i-1], 5000, 10^-4)
}

plot(f.res, ylab="homozygosity", xlab="generations", ylim=c(0,1))  
# lines(f.res) # para plotar outros valores de N ou u no mesmo gráfico  
  
# Pense nos valores das populações Ameríndias com H baixo (para micros), com valores em torno 
# de 0,6. Supondo N=5000 e u=10^-4, quanto tempo demorariam para voltar ao equilíbrio?
   
    
# checando relação da convergência com valor de equilíbrio
f.res <- numeric()
f.res[1] <- 0.2
for(i in seq(2,20000))
{
  f.res[i] <- f(f.res[i-1], 5000, 10^-4)
}

plot(f.res)  

# checando valor de convergência com valor observado
abline(h=H.eq(5000, 10^-4))           
