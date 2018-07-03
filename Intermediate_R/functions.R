#### functions

# consult function usage
?mean # R document
args(mean)  # see the arguments of a function

## compare arithmetic mean and trimmed mean
# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Calculate the mean of the sum
avg_sum <- mean(linkedin + facebook)
avg_sum
# Calculate the trimmed mean of the sum
avg_sum_trimmed <- mean(linkedin + facebook, trim = 0.2)

# Inspect both new variables
avg_sum
avg_sum_trimmed

######## write functions #######
triple <- function(x) {
  3*x
}
triple(3)

math_magic <- function(a,b) {
  a*b + a/b
}
math_magic(4,2)
math_magic(4) # gives error because second argument is not optional

math_magic <- function(a,b=1) {
  a*b + a/b
} # give the second argument a default value
math_magic(4)
math_magic(4,0) # you can still specify the second argument, give inf

# to solve this inf problem
math_magic <- function(a,b=1) {
  if (b==0) {
    return(0)
  }
  a*b + a/b
}
math_magic(4,0)

# function that does not require input
throw_die <- function() {
  number <- sample(1:6, size = 1)
  number
} 

throw_die() # get a random integer from 1 to 6

## example
# Finish the pow_two() function
pow_two <- function(x, print_info = TRUE) {
  y <- x ^ 2
  if (print_info) {
    print(paste(x, "to the power two equals", y))
  }
  return(y)
}

# Some calls of the pow_two() function
pow_two(5)
pow_two(5, FALSE)
pow_two(5, TRUE)

# R pass the value in the argument
triple <- function(x) {
  x <- 3*x
  x
}
a <- 5
triple(a)
a

# example
# The linkedin and facebook vectors have already been created for you

# Define the interpret function
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
    
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Call the interpret function twice
interpret(linkedin[1])
interpret(facebook[2])

# example
# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# The interpret() can be used inside interpret_all()
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Define the interpret_all() function
# views: vector with data to interpret
# return_sum: return total number of views on popular days?
interpret_all <- function(views, return_sum=TRUE) {
  count <- 0
  
  for (v in views) {
    count <- count + interpret(v)
  }
  
  if (return_sum == TRUE) {
    return(count)
  } else {
    return(NULL)
  }
}

# Call the interpret_all() function on both linkedin and facebook
interpret_all(linkedin)
interpret_all(facebook)

###### load packages ######
library(data.table)
require(rjson) # load a package that is not installed in R


