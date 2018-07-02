###### loops #########

### while loop
# must be terminated in some condition
ctr <- 1 # counter
while (ctr <= 7) {
  print(paste("ctr is set to", ctr))
  ctr <- ctr + 1
}
ctr

ctr <- 1
while (ctr <= 7) {
  if (ctr %% 5 == 0) {
    break
  }
  print(paste("ctr is set to", ctr))
  ctr <- ctr + 1
}

## example
# Initialize the speed variable
speed <- 64

# Code the while loop
while (speed > 30 ) {
  print("Slow down!")
  speed <- speed - 7
}

# Print out the speed variable
speed

## add more options
# Initialize the speed variable
speed <- 64

# Extend/adapt the while loop
while (speed > 30) {
  print(paste("Your speed is",speed))
  if (speed > 48 ) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}

####### for loop #########
cities <- c("NY", "Paris", "London","Tokyo")
for (city in cities) {
  print(city)
}

for (city in cities) {
  if (nchar(city) == 6) {
    break
  }
  print(city)
}

for (city in cities) {
  if (nchar(city) == 6) {
    next # next statement skip the print part and go into the next iteration
  }
  print(city)
}

# access to the indexing withing the loop
for (i in 1:length(cities)) {
  print(cities[i])
}

# add more information
for (i in 1:length(cities)) {
  print(paste(cities[i],"is on the position",i,"in the cities vector"))
}

## loop over list
# The nyc list is already specified
nyc <- list(pop = 8405837, 
            boroughs = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"), 
            capital = FALSE)

# Loop version 1
for (infor in nyc) {
  print(infor)
}

# Loop version 2
for (i in 1:length(nyc)) {
  print(nyc[[i]])
}

## nested for loop
# The tic-tac-toe matrix ttt has already been defined for you

# define the double for loop
for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row",i,"and column",j,"the board contains",ttt[i,j]))
  }
}

## mix up
# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Extend the for loop
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }
  
  # Add if statement with break
  if (li > 16) {
    print("This is ridiculous, I'm outta here!")
    break
  }
  
  # Add if statement with next
  if (li < 5) {
    print("This is too embarrassing!")
    next
  } 
  print(li)
}

## example
# Pre-defined variables
rquote <- "r's internals are irrefutably intriguing"
chars <- strsplit(rquote, split = "")[[1]]

# Initialize rcount
rcount <- 0

# Finish the for loop
for (char in chars) {
  if (char == "r") {
    rcount <- rcount + 1
  }
  if (char == "u") {
    break
  }
}

# Print out rcount
rcount