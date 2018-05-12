# Factors 
## Factor is used to store categorical variables

# Sex vector
sex_vector <- c("Male", "Female", "Female", "Male", "Male")

# Convert sex_vector to a factor
factor_sex_vector <- factor(sex_vector)

# Print out factor_sex_vector
factor_sex_vector

## nominal variable: no implied order
# Animals
animals_vector <- c("Elephant", "Giraffe", "Donkey", "Horse")
factor_animals_vector <- factor(animals_vector)
factor_animals_vector

# Temperature: ordinal categorical variables have natural ordering
temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_temperature_vector <- factor(temperature_vector, order = TRUE, 
                                    levels = c("Low", "Medium", "High"))
factor_temperature_vector

## Factor levels
# Code to build factor_survey_vector
survey_vector <- c("M", "F", "F", "M", "M")
factor_survey_vector <- factor(survey_vector)
factor_survey_vector # in alphabetical order by default

# Specify the levels of factor_survey_vector
levels(factor_survey_vector) <- c('Female','Male') # alphabetical order
factor_survey_vector

## summarizing a factor
# Generate summary for survey_vector
summary(survey_vector)

# Generate summary for factor_survey_vector
summary(factor_survey_vector) # gives more useful information

# compare elements of factor: male and female
# Male
male <- factor_survey_vector[1]

# Female
female <- factor_survey_vector[2]

# Battle of the sexes: Male 'larger' than female?
male > female # will give error warning: not meaningful because they are nominal factor levels

## ordered vectors
# Create speed_vector
speed_vector <- c("medium", "slow", "slow", "medium", "fast")

# Convert speed_vector to ordered factor vector
factor_speed_vector <- factor(speed_vector,ordered = TRUE, levels = c('slow','medium', 'fast'))

# Print factor_speed_vector
factor_speed_vector
summary(factor_speed_vector)

## now we can compare the levels of data
# Factor value for second data analyst
da2 <- factor_speed_vector[2]

# Factor value for fifth data analyst
da5 <- factor_speed_vector[5]

# Is data analyst 2 faster than data analyst 5?
da2 > da5




