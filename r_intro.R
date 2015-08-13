# assignment
x <- 10
x = 10

x <- y <- 10

# ls() lists all objects in your environment
ls()

# rm() remove specific objects
rm(x, y)

ls()

# error
x <- y = 10

# Math operations
10 + 3
10 - 3
10 * 3
10 / 3
10 %/% 3
10 %% 3
10 ^ 3
10 > 3
10 < 3
10 >= 10

# precedence
10 + 3 * 2

-1^2

?Syntax

# vectors
x <- 10
x

1:100

c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
c(1, 1, 2, 3, 5, 8, 13)

# R is vectorized
x <- 1:10
x

x * 10

# types
typeof(x)

l <- c(FALSE, TRUE, TRUE)
typeof(l)

ch <- c("A", "C", "T", "G")
typeof(ch)

mean(x)
mean(l)
mean(ch)

# NA values
x <- c(1, 15, 27, NA, 41)
x

# matrices
m <- matrix(data = c(10, 20, 30, 40), ncol = 2)
m

m <- matrix(data = c(10, 20, 30, 40), ncol = 2, byrow = TRUE)
m

rownames(m) <- c("A", "B")
colnames(m) <- c("m", "f")
m

class(m)
dim(m)
attributes(m)

# subset
m[1, 1]

m[1, ]
m[, 1]

# apply functions to matrices
mean(m[1, ])
mean(m[, 1])

apply(m, MARGIN = 1, mean)
apply(m, MARGIN = 2, mean)

rowMeans(m)
colMeans(m)

# loops
x <- 1:10
x

x * 10

for (i in x) 
  x[i] <- x[i] * 10

x

m <- matrix(nrow = 2, ncol = 2)
m

k <- 1
for (i in 1:nrow(m)) {
  for(j in 1:ncol(m)) {
    
    m[i, j] <- x[k]
   
    k <- k + 1
  }
}

m

plot(x, pch = 19, col = rainbow(10))