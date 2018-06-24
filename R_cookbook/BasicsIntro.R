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

## create sequences
1:5
seq(1,5, by =2) # a sequence from 1 to 5 with increment 2
seq(0,20,length.out=5) # specify a length of the output (same as increment)
seq(0,2,length.out = 5)
rep(1, times = 5) # create a series of repeated values

## comparing vectors
a <- 3
a == pi # test for equality
a != pi # test for inequality
a > pi
a < pi
a <= pi
a <= pi

# comparision element by element wise
v <- c(3,pi,4)
w <- rep(pi, 3)
v == w # element wise comparison

# see if any of the comparison is true or whether all comparisons were true
any(v == pi) # return true if any element is true
all(v == 0) # return true if all elements are true

## select vector elements
fib <- c(0,1,1,2,3,5,8,13,21,34)
fib[1] # the first index is 1 not 0
fib[1:3]
fib[c(1,2,4,8)]
fib[-1] # ignore the first value and return all the rest
fib[-(1:3)] # ignore the first three values

fib < 10 # return boolean values
fib[fib<10] # use boolean vector to select elements less than 10
fib %% 2 == 0 # even number
fib[fib %% 2 == 0]

v[v > median(v)] # select element greater than median
v[(v<quantile(v,0.05)) | (v>quantile(v,0.95))] #lower and upper 5% 
v[abs(v-mean(v)) > 2*sd(v)] # elements exceed +2/-2 sd from the mean
v[!is.na(v) & !is.null(v)] # neither NA nor null(undefined value)

## define a function

# write a function to calculate coefficient of variation
cv <- function(x) sd(x)/mean(x) # x is parameter(s)
cv(1:10)
lapply(lst,cv) # can use it anywhere in another function

# compute the greatest common divisor of two integers
gcd <- function(a,b) {
  if (b == 0) return(a)
  else return(gcd(b, a %% b))
}

help(Control)

## for loop
for (i in 1:5) print(1:i)

for (n in c(2,5,10,20,50)) {
  x <- rnorm(n)
  cat(n,":",sum(x^2), "\n", sep="")
}

f <- factor(sample(letters[1:5], 10, replace = TRUE))
for (i in unique(f)) print(i)


#######indexing into data structure####
## indexing use vector
v <- c(1,4,4,3,2,2,3)

# Create a sample data frame
data <- read.table(header=T, text='
                   subject sex size
                   1   M    7
                   2   F    6
                   3   F    9
                   4   M   11
                   ')
data[1,3]
data[1,"size"]
data[1:2,]
data[1:2,2]
data[1:2,c("size","sex")]
data[1:2,2:3]

##indexing using boolean vector
v>2
v[v>2]

data$subject<3
data[data$subject<3,]
which(data$subject<3)

##negative indexing means droping terms
v
v[-1] # drop the first term
v[-1:-3] # drop the first three terms
v[-length(v)] # drop the last term


########subset of data structure#######
v <- c(1,4,4,3,2,2,3)

subset(v,v<3)
v[v<3] #same result

t <- c("small", "small", "large", "medium")
subset(t, t!="small") # remove "small"

v[v<3] <- 9
v
subset(v,v<3) <- 9 # cannot assign values to a subset

data
subset(data,subject<3)
subset(data,subject<3, select = -subject)
subset(data,subject<3, select = c(sex,size))
subset(data,subject<3, select = sex:size)

subset(data, subject<3 & sex == "M") # AND
subset(data, subject<3 | sex == "M") # OR

subset(data, log2(size)>3) # based on transformed data

subset(data, subject %in% c(1,3)) # subset if element in another vector

######### make vector filled with values ###########
rep(1,50)
rep(F,20)
rep(1:5,4)
rep(factor(LETTERS[1:3]),5)

####### information about variables#####
x <- 6
n <- 1:4
let <- LETTERS[1:4]
df <- data.frame(n,let)

ls() # list of all current variable
exists("x") # see of "x" exist as a variable
exists("y")
rm(x)
exists("x")

# get information about the structure
str(n)
str(df)
length(n)
dim(df)

########work with NA,Null, NaN########
x <- NULL # null means there is no value
x > 5
y <- NA
y > 5
z <- NaN
z > 5

# to test whether a vairable has these three values
is.null(x)
is.na(y)
is.nan(z)

is.null(y)
is.na(x) # there is no value to be checked

# ignore bad values 
vy <- c(1, 2, 3, NA, 5)
mean(vy) # return NA because mean() is very sensitive 
mean(vy, na.rm = TRUE) # remove 

vz <- c(1, 2, 3, NaN, 5)
sum(vz) # sum cannot tolerate NaN
sum(vz, na.rm = TRUE)

vx <- c(1, 2, 3, NULL, 5)
sum(vx) # null is not a problem because it does not exist
length(vx)

# remove bad values from vectors
vy
vy[!is.na(vy)]
vz
vz[!is.nan(vz)]
