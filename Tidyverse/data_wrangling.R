######## data wrangling #####

library(gapminder)
library(dplyr)

gapminder # load dataset, 1704 observations

### filter verb
# filter for one year
gapminder %>% filter(year == 1957)

# Filter for China in 2002
gapminder %>% filter(year == 2002, country == "China")

### arrange verb
# arrange by gdpPercap
gapminder %>% arrange(gdpPercap) # default is sorting from low to high
gapminder %>% arrange(desc(gdpPercap)) # from high to low

# filter then arrange
gapminder %>% 
  filter(year == 2007) %>% 
  arrange(desc(gdpPercap))

### mutate verb
# change variable
gapminder %>% 
  mutate(pop = pop/1000000)

# add new variable
gapminder %>% 
  mutate(gdp = gdpPercap * pop)

# combine verbs
gapminder %>% 
  mutate(gdp = gdpPercap * pop) %>% 
  filter(year == 2007) %>% 
  arrange(desc(gdp))
