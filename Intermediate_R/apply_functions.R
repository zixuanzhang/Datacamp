######## lapply #######

## lapply function (always returns a list)
# apply to a list or a vector
# you can use unlist() to convert a list back to a vector

# The vector pioneers has already been created for you
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")

# Split names from birth year
split_math <- strsplit(pioneers, split = ":")

# Convert to lowercase strings: split_low
split_low <- lapply(split_math, tolower)
split_low
# Take a look at the structure of split_low
str(split_low)

# Write function select_first()
select_first <- function(x) {
  x[1]
}

# Apply select_first() over split_low: names
names <- lapply(split_low, select_first)

# Write function select_second()
select_second <- function(x) {
  x[2]
}

# Apply select_second() over split_low: years
years <- lapply(split_low, select_second)

names
years

## anonymous function
# Named function
triple <- function(x) { 3 * x }

# Anonymous function with same implementation
function(x) { 3 * x }

# Use anonymous function inside lapply()
lapply(list(1,2,3), function(x) { 3 * x })

# example: rewrite previous example
# Definition of split_low
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

# Transform: use anonymous function inside lapply
names <- lapply(split_low, function(x) {x[1]})

# Transform: use anonymous function inside lapply
years <- lapply(split_low, function(x) {x[2]})

names
years

## take multuple arguments
# Definition of split_low
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

# Generic select function
select_el <- function(x, index) {
  x[index]
}

# Use lapply() twice on split_low: names and years
names <- lapply(split_low, select_el, index=1)
years <- lapply(split_low, select_el, index=2)

names
years

########### sapply ###########
## short/simplied apply
cities <- c("New York", "Paris", "London", "Tokyo",
            "Rio de Janeiro", "Cape Town")
unlist(lapply(cities, nchar))
sapply(cities,nchar)

first_and_last <- function(name) {
  name <- gsub(" ", "", name) # remove space in city name
  letters <- strsplit(name, split = "")[[1]] # split each letter in a city name
  c(first = min(letters), last = max(letters))
}
sapply(cities, first_and_last)

# unique letters
unique_letters <- function(name) {
  name <- gsub(" ", "", name)
  letters <- strsplit(name, split = "")[[1]]
  unique(letters)
}
unique_letters("London")

lapply(cities,unique_letters)
sapply(cities,unique_letters) # compare these two results
# lapply returns a list, while sapply returns a vector

## example
# sapply can simplify
sapply(list(runif (10), runif (10)), 
       function(x) c(min = min(x), mean = mean(x), max = max(x)))

######### vapply ########

?vapply # similar to sapply but prespecify type of return value, which is safer to use
args(vapply)

# compare sapply vs vapply
sapply(cities, nchar)
vapply(cities, nchar, numeric(1))

sapply(cities, first_and_last)
vapply(cities, first_and_last, character(2))

# try this, vapply errors
vapply(cities, first_and_last, character(1)) # wrong charater number
vapply(cities, first_and_last, numeric(2)) # wrong type

vapply(cities, unique_letters, character(4)) # different length, cannot simplify

# example
vapply(temp, function(x, y) { mean(x) > y }, y = 5, logical(1))




