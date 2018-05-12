# Matrices
matrix(1:9, byrow = TRUE, nrow = 3) # (element to fill in, filled by rows TRUE or FALSE, number of rows)

# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Create box_office
box_office <- c(new_hope,empire_strikes,return_jedi)

# Construct star_wars_matrix
star_wars_matrix <- matrix(box_office, byrow = TRUE, nrow=3)
star_wars_matrix

# Vectors region and titles, used for naming
region <- c("US", "non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")

# Name the columns with region
colnames(star_wars_matrix) = region

# Name the rows with titles
rownames(star_wars_matrix) = titles

# Print out star_wars_matrix
star_wars_matrix

# Calculate worldwide box office figures (sum each row)
worldwide_vector <- rowSums(star_wars_matrix)

# Bind the new variable worldwide_vector as a column to star_wars_matrix (merge matrix in columns)
all_wars_matrix <- cbind(star_wars_matrix,worldwide_vector)

# bind matrix in row (merge matrix in row)
all_wars_matrix <- rbind(star_wars_matrix,star_wars_matrix2)

# Total revenue for US and non-US (Column sums)
total_revenue_vector <- colSums(all_wars_matrix)

##
# all_wars_matrix is available in your workspace
all_wars_matrix

# Select the non-US revenue for all movies
non_us_all <- all_wars_matrix[,2]
non_us_all
# Average non-US revenue
mean(non_us_all)

# Select the non-US revenue for first two movies
non_us_some <- all_wars_matrix[1:2, 2]
non_us_some
# Average non-US revenue for first two movies
mean(non_us_some)

# Estimate the visitors
visitors <- all_wars_matrix/5 # matrice can do armitetics +/-/* or /

##
# all_wars_matrix and ticket_prices_matrix are available in your workspace
all_wars_matrix
ticket_prices_matrix # ticket price is not constant

# Estimated number of visitors
visitors <- all_wars_matrix/ticket_prices_matrix

# US visitors
us_visitors <- visitors[,1]








