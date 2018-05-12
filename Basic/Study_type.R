# Study Types

## Load data (call the dataset)
library(gapminder)
data(gapminder)

# Glimpse data
glimpse(gapminder)
head(gapminder)
colnames(gapminder)

##
library(tidyverse)
library(dplyr)
data(UCBAdmissions)
glimpse(UCBAdmissions)
View(UCBAdmissions)

View(mtcars)
tally(mtcars)

mtcars %>% tally()
mtcars %>% count(cyl)  # count the number of each value of cyl
mtcars %>% add_count(cyl)
# count the number of each species and homeworld combined
head(starwars)
species <- starwars %>% count(species,homeworld,sort=TRUE) 
species
species %>% count(species,sort=TRUE)# sort will list in descending order

# show only species that have a single member
starwars %>% 
  add_count(species) %>%
  filter(n==1)


