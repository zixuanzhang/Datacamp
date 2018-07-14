######## visualizing with ggplot ########

library(tidyverse)
library(gapminder)
gapminder_2007 <- gapminder %>% 
  filter(year == 2007)
gapminder_2007

#Aesthetic mappings describe how variables 
# in the data are mapped to visual properties (aesthetics) of geoms

# compare two variables x vs. y on the scatterplot 
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) + geom_point()

gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a scatter plot with pop on the x-axis and lifeExp on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = lifeExp,)) + geom_point() 
# hard to distinguish because pop spans over several orders of magnitudes

# how to solve this problem: put x-axis on log scales
ggplot(gapminder_1952, aes(x = pop, y = lifeExp,)) + geom_point() + scale_x_log10()

# Scatter plot comparing pop and gdpPercap, with both axes on a log scale
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) + geom_point() + scale_x_log10() + scale_y_log10()

### add color to the scatter plot in aes()
# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952, aes(pop, lifeExp, color = continent)) + geom_point() + scale_x_log10()

# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()

### faceting: divide graph into subplots based on one of its variable

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) + geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent)

# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
ggplot(gapminder, aes(gdpPercap, lifeExp, color = continent, size = pop)) + 
  geom_point() + 
  scale_x_log10() + 
  facet_wrap(~year)

#### summarize verb
gapminder %>% filter(country == "United States", year == 2007)

gapminder %>% summarize(meanLifeExp = mean(lifeExp)) # give a number in a tibble
mean(gapminder$lifeExp) # a vector

gapminder %>% 
  filter(year == 2007) %>% 
  summarize(mean(lifeExp))

# summarize into multiple columns
gapminder %>% 
  filter(year == 2007) %>% 
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

# functions you can use for summarizing
# mean(), sum(), median(), min(), max()

#### group_by verb
# summarize by year
gapminder %>% 
  group_by(year) %>% # divide into groups, then apply functions within each group
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

# summarize by group in a particular year
gapminder %>%
  filter(year == 2007) %>% 
  group_by(continent) %>% # group by continent
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

# summarize by continent AND year
gapminder %>% 
  group_by(year,continent) %>% 
  summarize(totalPop = sum(as.numeric(pop)),
            meanLifeExp = mean(lifeExp))

#### visualize summarized data
by_year <- gapminder %>% 
  group_by(year) %>% 
  summarize(totalPop = sum(as.numeric(pop)),
            meanLifeExp = mean(lifeExp))
by_year

# visualze population over time
ggplot(by_year, aes(year, totalPop)) + geom_point()

# start y-axis at zero
ggplot(by_year, aes(year, totalPop)) + geom_point() + expend_limits(y = 0)

# summarize by year and continent
by_year_continent <- gapminder %>% 
  group_by(year, continent) %>% 
  summarize(totalPop = sum(as.numeric(pop)),
            meanLifeExp = mean(lifeExp)) 
by_year_continent

# visualize population by year and continent
ggplot(by_year_continent, aes(year, totalPop, color=continent)) +
  geom_point() +
  expand_limits(y = 0)

#### Line plots
# good for visualizing trends

# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>% group_by(year) %>% 
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(year, medianGdpPercap)) + geom_line() + expand_limits(y=0)

# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>% group_by(continent,year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, aes(year, medianGdpPercap, color = continent)) + geom_line() + expand_limits(y=0)


### bar plot
by_continent <- gapminder %>% 
  filter(year == 2007) %>% 
  group_by(continent) %>% 
  summarize(meanLifeExp = mean(lifeExp))

ggplot(by_continent, aes(continent, meanLifeExp)) + geom_col()

# Summarize the median gdpPercap by year and continent in 1952
by_continent <- gapminder %>% filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(continent, medianGdpPercap)) + geom_col()

# Filter for observations in the Oceania continent in 1952
oceania_1952 <- gapminder %>% filter(year == 1952, continent == "Oceania")

# Create a bar plot of gdpPercap by country
ggplot(oceania_1952, aes(country, gdpPercap)) + geom_col()


#### histograms
# one variable at a time, show distribution
# only one aesthetic for x-axis

ggplot(gapminder_2007, aes(lifeExp)) + geom_histogram()

# customized bin width
ggplot(gapminder_2007, aes(lifeExp)) + geom_histogram(binwidth = 5) # each bin represent 5 years

gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop)
ggplot(gapminder_1952, aes(pop)) + geom_histogram()

# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(pop)) + geom_histogram() + scale_x_log10()

#### box plot
ggplot(gapminder_2007, aes(x = continent, y = lifeExp)) + geom_boxplot()

# Create a boxplot comparing gdpPercap among continents, add title
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) + geom_boxplot() + scale_y_log10() + ggtitle("Comparing GDP per capita across continents")


