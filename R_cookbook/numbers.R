###### numbers #######

#######Genrate random numbers ###########

# uniform random number
runif(1) 
runif(4) 
runif(3, min = 0, max = 100)

floor(runif(3,min = 0, max = 101)) # get three integers from 0 to 100, never equal 101
sample(1:100, 3, replace = TRUE) # do the same thing, generate with replacement
sample(1:100, 3, replace = FALSE) # without replacement

# normal distribution generator
rnorm(4) # default is N(0,1)
rnorm(4, mean = 50, sd = 10)

x <- rnorm(400, mean = 50, sd = 10)
hist(x) # generate histogram to see the distribution

# generate repeatable sequence (so it's reproducible)
set.seed(423)
runif(3)

set.seed(423)
runif(3)

# round numbers
x <- seq(-2.5, 2.5, by=.5)
round(x) # round to the nearest, with 0.5 to the even number
ceiling(x) # round up
floor(x) # round down
trunc(x) # round towards zero

# round to other decimal places
x <- c(.001, .07, 1.2, 44.02, 738, 9927) 
round(x, digits = 1) # round to one decimal place
round(x, digits = -1) # round to tenth place
round(x/5)*5 # round to nearest 5
round(x/0.02)*0.02 # round to nearest 0.02

# compare floating numbers
0.3 == 3*.1 # false
(0.1+0.1+0.1) - 0.3 # not zero
x <- seq(0,1,by=0.1)
x
10*x - round(10*x) # not zero
# there is no universal solution to this problem because of the inherent storage format of floating numbers


