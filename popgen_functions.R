# Basic selection model with w 
delta.p.old <- function(p, w11, w12, w22)
        {
                    w.bar   <- p^2*w11 + 2*p*(1-p)*w12 + (1-p)^2*w22
        p.prime <- (p^2*w11 + p*(1-p)*w12)/w.bar
              return(p.prime)
            }


# Basic selection function, parametrized with h and s
delta.p <- function(p, s, h)
       {
        w11    <- 1
        w12    <- 1 - h * s
        w22    <- 1 - s
        w.bar  <- p^2*w11 + 2*p*(1-p)*w12 + (1-p)^2*w22
        
        p.prime <- (p^2*w11 + p*(1-p)*w12)/w.bar
        return(p.prime)
       }
