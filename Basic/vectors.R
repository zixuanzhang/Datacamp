# Basics

## Calculation
# Exponentiation
2 ^ 5

# Modulo: the remainder of division
28 %% 6

# assign value to variable
x = -4
x <- -4

# check datatype beforehand
class()

# vectors
# create vector with c() combination function, elements separated by comma
num_vector = c(1,2,3) 
char_vector = c("1", "2", "3")
boolean_vector= c(TRUE, FALSE, TRUE) # all capital letter

# give name to each element in the vector
names(char_vector) = c('name1', 'name2','name3')
# or you can make a name vector and assign it to any variable vector

# use square bracket to obtain specific element from vector: first element index is 1
char_vector[1]
char_vector[c(1,3)] # first and third element
char_vector[c(1:3)] # from first to third element

# use element's name to obtain them from vector
char_vector[c('name1', 'name2')]

# selection by comparison
selection_vector = num_vector > 1
selection_vector
selected_element = num_vector[selection_vector] # will only select element assigned TRUE
selected_element
# or
selected_element = num_vector[num_vector > 3]



