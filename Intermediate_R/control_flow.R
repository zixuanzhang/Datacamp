##### conditional and control flow
## relational operator

# test equality
TRUE == TRUE
TRUE == FALSE

"hello" == "goodbye"
3 == 2

# test inequality
"hello" != "goodbye"
3 != 2

# > and <
3 > 2
3 < 2
"Hello" > "Goodbye" # TRUE! R use alphabetical order to order this!!
TRUE < FALSE # TRUE is 1, FALSE is 0; 1 is not less than 0

5 >= 3
3 >= 3

# comparison in vectors
linkedin <- c(16,9,13,5,2,7,14)
linkedin > 10
facebook <- c(17,7,5,16,8,13,14)
facebook <= linkedin # one by one comparison in vector

# The social data has been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)
views
# When does views equal 13?
views == 13

# When is views less than or equal to 14?
views <= 14

######## logical operators
TRUE & TRUE
TRUE & FALSE

x <- 12
x > 5 & x < 15
x > 5 & x < 11

TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

y <- 4
y < 5 | y > 15
y <- 14
y < 5 | y > 15

!TRUE
!FALSE

is.numeric(5)
!is.numeric(5)
is.numeric("hello")
!is.numeric("hello")

####### logical vector
c(TRUE, TRUE, FALSE) & c(TRUE, FALSE, TRUE)
c(TRUE, TRUE, FALSE) | c(TRUE, FALSE, TRUE)

c(TRUE, TRUE, FALSE) && c(TRUE, FALSE, TRUE) # evaluate the first element of each  vector
c(TRUE, TRUE, FALSE) || c(TRUE, FALSE, TRUE) # evaluate the first element of each vector 

last <- tail(linkedin, 1)

# Is last under 5 or above 10?
last < 5 | last > 10

# Is last between 15 (exclusive) and 20 (inclusive)?
last > 15 & last <= 20

# linkedin exceeds 10 but facebook below 10
linkedin > 10 & facebook < 10

# When were one or both visited at least 12 times?
linkedin >= 12 | facebook >= 12

# When is views between 11 (exclusive) and 14 (inclusive)?
views > 11 & views <= 14

###example
# li_df is pre-loaded in your workspace
li_df
# Select the second column, named day2, from li_df: second
second <- li_df[,"day2"]
second
# Build a logical vector, TRUE if value in second is extreme: extremes
extremes <- (second > 25 | second < 5)

# Count the number of TRUEs in extremes
sum(extremes)

# Solve it with a one-liner
sum(second > 25 | second < 5)

###### conditional statemnet
x <- 5 # try -3 and 5
if (x < 0) {
  print("x is a negative number")
} else {
  print("x is either a positive number or zero")
}

# else if statement
x <- 5 # try -3 and 5
if (x < 0) {
  print("x is a negative number")
} else if (x == 0) {
  print("x is zero")
} else {
  print("x is a positive number")
}


## examples
# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Examine the if statement for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
}

# Write the if statement for num_views
if (num_views > 15) {
  print("You're popular!")
}

# Control structure for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
} else {
  print("Unknown medium")
}


# Control structure for num_views
if (num_views > 15) {
  print("You're popular!")
} else {
  print("Try to be more visible!")
}

# Control structure for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
} else if (medium == "Facebook") {
  # Add code to print correct string when condition is TRUE
  print("Showing Facebook information")
} else {
  print("Unknown medium")
}

# Control structure for num_views
if (num_views > 15) {
  print("You're popular!")
} else if (num_views <= 15 & num_views > 10) {
  # Add code to print correct string when condition is TRUE
  print("Your number of views is average")
} else {
  print("Try to be more visible!")
}

