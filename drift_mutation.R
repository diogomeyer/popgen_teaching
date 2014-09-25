## Drift and mutation formulas and trajectories


# Function for computing equlibrium heterozygosity 
H.eq <- function(N,u) 
    { 
    theta <- 4*N*u 
   H <- theta/(theta+1) 
    return(H) 
    } 
 
# Example run 
#plot(mut.drift(seq(100,1000000,10000), 10^-6) ) 
 
 
 
# Formula for change in f under drift and mutation 
 f <- function(f, N, u) 
    { 
    f.prime <- (((1/(2*N)) + ((1 - (1/(2*N)))*f))*((1-u)^2)) 
    return(f.prime)
    }

## approach to equilibrium for 20000 generations assuing N=5000 and u=10^-4

f.res    <- numeric()
f.res[1] <- 0.2
for(i in seq(2,20000) )
    {
     f.res[i] <- f(f.res[i-1], 5000, 10^-4)
    }
plot(f.res)  
    
# checando relação da convergência com valor de equilíbrio
f.res    <- numeric()
f.res[1] <- 0.2
for(i in seq(2,20000) )
    {
     f.res[i] <- f(f.res[i-1], 5000, 10^-4)
    }
plot(f.res)  

# checando valor de convergência com valor observado
abline(h=H.eq(5000, 10^-4))           
    
    
    
    
    
    
    
    
