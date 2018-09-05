####### write functions ########

# functions have three parts
# argument, body, environment

## adding 
add <- function(x, y = 1) {
  x + y
}

add(1)

## return positive values (absolute value)
f <- function(x) {
  if (x < 0 ) {
    -x
  }
  else {    # return(value) will force the function from execution and return value
    x       # can be used if you want to teriminate the function early
  }
} # return the last evaluation of expression

f(-5)

## anonymous functions (without names)
function(x) {x+1}
(function(x) {x+1})(2) # call the function


##### practice
# Define ratio() function
ratio <- function(x, y) {
  x/y # body
}

# Call ratio() with arguments 3 and 4
ratio(3,4)

# Rewrite the call to follow best practices
mean(c(1:9, NA), trim = 0.1, na.rm = TRUE)

#### data structure
a <- list(
  a = 1:3,
  b = "a string",
  c = pi,
  d = list(-1, -5)
)

a # a list
a[1:2] # the first two elements in the list
a[4] # the fourth element within list is another lista
a[[4]] # return the fourth list by itself outside the original list structure
       # remove one level of the hierarchy

a[[4]][1] # the first element of the list 
a[[4]][[1]]

# subsetting a list
# Guess where the regression model is stored
names(tricky_list)

# Use names() and str() on the model element
names(tricky_list[["model"]])
str(tricky_list[["model"]])

# Subset the coefficients element
tricky_list[["model"]][["coefficients"]]

# Subset the wt element
tricky_list[["model"]][["coefficients"]][["wt"]]

## a better way to create index in for loop
# seq_along() instead of 1:ncol(df)

# Replace the 1:ncol(df) sequence
for (i in seq_along(df)) {
  print(median(df[[i]]))
}

# Change the value of df
df <- data.frame()

# Repeat for loop to verify there is no error
for (i in seq_along(df)) {
  print(median(df[[i]]))
} # no error

# compare with ncol(), gives error message
for (i in 1:ncol(df)) {
  print(median(df[[i]]))
}

## store the result from loop
# Create new double vector: output
output <- vector("double", ncol(df)) # create an empty vector for output

# Alter the loop
for (i in seq_along(df)) {
  # Change code to store result in output
  output[[i]] <- median(df[[i]]) # use double bracket (applied for both vectors and list)
}

# Print output
output


### 
# Define example vector x
x <- 1:10

# Rewrite this snippet to refer to x
(x - min(x, na.rm = TRUE)) /
  (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))

## rewrite above
# Define example vector x
x <- 1:10

# Define rng
rng <- range(x, na.rm = TRUE)

# Rewrite this snippet to refer to the elements of rng
(x - rng[1]) / (rng[2] - rng[1])

# write a function based on above
rescale01 <- function(x) {
  # body
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale01(x)


# how to write a function
## start with a simple problem
## write a snippet to see if there is the right answer
## rewrite using temporary variables
## finally turn the snippet into a function (all your temporary arguments become variables)

## example: find the number of elements in x and y that they are both NA
# Define example vectors x and y
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3,  4)

# Count how many elements are missing in both x and y
sum(is.na(x) & is.na(y)) 

# Turn this snippet into a function: both_na()
both_na <- function(x,y) {
  sum(is.na(x) & is.na(y))
}

# test our function
# Define x, y1 and y2
x <-  c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)

# Call both_na on x, y1
both_na(x,y1)

# Call both_na on x, y2
both_na(x,y2) # problem: vector length is different

## find confidence interval
# Rewrite mean_ci to take arguments named level and x
mean_ci <- function(x, level = 0.95) { # Data input come first, give default value to other arguments
  se <- sd(x) / sqrt(length(x))
  alpha <- 1 - level
  mean(x) + se * qnorm(c(alpha / 2, level / 2))
}

# test with 0
mean_ci(numeric(0)) # gives NA on both ends

# to fix this porblem, add warning message and adjustments
# Alter the mean_ci function
mean_ci <- function(x, level = 0.95) {
  if (length(x) == 0) {
    warning("`x` was empty", call. = FALSE)
    interval <- c(-Inf, Inf)
  } else {
    se <- sd(x) / sqrt(length(x))
    alpha <- 1 - level
    interval <- mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))    
  }
  interval
}

mean_ci(numeric(0))


## example; a function to replace all missing value with assigned value
# Rename the function f() to replace_missings()
replace_missings <- function(x, replacement) {
  # Change the name of the y argument to replacement
  x[is.na(x)] <- replacement
  cat(sum(is.na(x)), replacement, "\n")
  x
}

# Rewrite the call on df$z to match our new names
df$z <- replace_missings(df$z, 0)

# make the body cleaner
replace_missings <- function(x, replacement) {
  # Define is_miss to avoid duplications below
  is_miss <- is.na(x) 
  
  # Rewrite rest of function to refer to is_miss
  x[is_miss] <- replacement
  cat(sum(is_miss), replacement, "\n")
  x
}

# optimize further
replace_missings <- function(x, replacement) {
  is_miss <- is.na(x)
  x[is_miss] <- replacement
  
  # Rewrite to use message()
  message(sum(is_miss), "missings replaced by the value", replacement)
  x
}

# Check your new function by running on df$z
df$z <- replace_missings(df$z, 0)

###### for loops
## for loops emphasize nouns, objects

df <- data.frame(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

# Initialize output vector
output <- vector("double", ncol(df))  

# Fill in the body of the for loop
for (i in seq_along(df)) {            
  output[[i]] <- median(df[[i]])
}

# View the result
output

# Turn this code into col_median()

col_median <- function(df) {
  output <- vector("double", ncol(df))  
  for (i in seq_along(df)) {            
    output[[i]] <- median(df[[i]])      
  }
  output
}

col_median(df)

# Add a second argument called power
f <- function(x, power) {
  # Edit the body to return absolute deviations raised to power
  abs(x - mean(x)) ^ power
}


## functions can be arguments
col_summary <- function(df, fun) { # the second argument is a function
  output <- vector("numeric", length(df))
  for (i in seq_along(df)) {
    output[[i]] <- fun(df[[i]])
  }
  output
}

# Find the column IQRs using col_summary()
col_summary(df, IQR) 

# I want to test this

