#### basics

# help 
args(mean) # quick reminder of the arguments to a function "mean"
?mean # open R documentation for the function
args(sd)
example(mean) # run the example
??pattern # search the documentation
help.search("adf.test")
 
vignette() # additional document of the packages, eg. tutorial, reference card
vignette("dplyr")

########print something##########
print(matrix(c(1,2,3,4),2,2)) # format the printing
print(list("a","b","c"))

## print multiple items
cat("The zero occurs at",2*pi,"radian","\n") # automatically put space btw each item
fib <- c(0,1,2,3,4)
cat("the vector is:",fib, "...\n") #\n is to terminate this ine
# but cat cannot print out data structure

## set variables

## listing variables
x <- 10
y <- 50
z <- c("three","blind","mice")
ls() # display the names of objects in the workspace
ls.str() # display more information about the objects in workspace

## delete variables
rm(x)
x

## create vector
v1 <- c(1,2,3)
v2 <- c(4,5,6)
c(v1,v2) # combine vectors into a single one

# R will convert the number to string when combine these two matrices
v1 <- c(1,2,3)
v3 <- c("A","B","C")
c(v1,v3) 

# check mode of the vector
mode(3.1415)
mode("foo")
mode(c(3,1415,"foo")) # these two modes are not compatible so R changed one of them


## Basic Statistics
x <- c(0,1,1,2,3,5,8,13,21,34)
y <- log(x+1)

mean(x)
median(x)
sd(x)
var(x)
cor(x,y)
cov(x,y)

# all these functions are intolerant of NA
# we can override this cautious behavior
x <- c(0,1,2,3,4,NA)
mean(x, na.rm = TRUE) # ignore NA values
sd(x,na.rm = TRUE)

# create sequences
1:5
seq(1,5, by =2) # a sequence from 1 to 5 with increment 2
seq(0,20,length.out=5) # specify a length of the output (same as increment)
seq(0,2,length.out = 5)
rep(1, times = 5) # create a series of repeated values

# comparing vectors
