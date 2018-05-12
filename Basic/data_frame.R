# data frame

## data frame contains data of different types
## variables of a data as columns, observations as rows
library(tidyverse)
View(mtcars)

# preview observations of a data frame;
head(mtcars) # display first observations
tail(mtcars) #display last observations
str(mtcars) # shows the structure of dataset, # of variables, and total observations

## build data frame of eight planets in soloar system
# Definition of vectors
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant")
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883)
rotation <- c(58.64, -243.02, 1, 1.03, 0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)

# Create a data frame from the vectors
planets <- data.frame(name,type,diameter,rotation,rings) # build dataset col by col)
str(planets)
head(planets)

# Print out diameter of Mercury (row 1, column 3)
planets[1,3]
planets %>% filter(name == "Mercury")
planets %>% filter(rings == "FALSE")

# Print out data for Mars (entire fourth row)
planets[4,]
planets %>% filter(name == "Mars")

## a more handy way to approach elements in dataframe: use their variable names instead of index
# Select first 5 values of diameter column
planets[1:5,'diameter']
planets$diameter[1:5]

# or use $ as a short cut to select an entire column
planets$rings

# Select planets with diameter < 1
subset(planets,diameter<1) # subset(dataframe, condition) will pull out all columns of observations
planets %>% filter(diameter < 1)

# Sorting: put numberical entries in order
a = c(100,10,1000)
order(a) # give the indices of ordering for each element
a[order(a)]

# Use order() to create positions
positions <-  order(planets$diameter)
positions

# Use positions to sort planets_df from smallest diameter to largest ones
planets[positions,]
arrange(planets, rings, rotation)# arrange rows by variables

## Lists
# Vector with numerics from 1 up to 10
my_vector <- 1:10 

# Matrix with numerics from 1 up to 9
# by default, entries are listed by columns from top to bottom
my_matrix <- matrix(1:9, ncol = 3, byrow=TRUE)
my_matrix

# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]

# Construct list with these different dataframes:
my_list <- list(my_vector,my_matrix,my_df)
# assign names to each component in the list
names(my_list) = c('vec','mat','df') 
my_list

# can do this by one step:
# make a list and name each component: mov, act, rev are pre-loaded components, before each of them are their names
# each component in the list has its own name: name = df)
shining_list <- list(vectorframe = my_vector, matrixframe = my_matrix, mtcarsframe = my_df)
shining_list

# Print out the vector representing the actors
shining_list[[1]]
shining_list$vectorframe

# Print the second element of the vector representing the actors
shining_list$matrixframe[2]

# We forgot something; add the year to shining_list
shining_list_full <- c(shining_list,year = 1980) # extend the existing list

# Have a look at shining_list_full
str(shining_list_full)




