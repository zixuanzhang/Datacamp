###### clean data practice ######

# information not worth keeping
## create a vector of indices for cols

# Define a vector of column indices: keep
keep <- c(5:(ncol(sales2) - 15)) # exclude first 4 cols and last 15 cols

# Subset sales2 using keep: sales3
sales3 <- sales2[,keep]
head(sales3)

## when you get warning about some values
# Define an issues vector reported in R console
issues <- c(2516, 3863, 4082, 4183) 

# Print values of sales_ord_create_dttm at these indices
# see these values before you separate them
sales3$sales_ord_create_dttm[issues] # see four missing values

# Print a well-behaved value of sales_ord_create_dttm
sales3$sales_ord_create_dttm[2517]

## identify dates
# if you want to do any comparisons or math with the dates, 
# it's MUCH easier to store them as Date objects.

# Load stringr
library(stringr)

# Find columns of sales5 containing "dt": date_cols
date_cols <- str_detect(names(sales5), "dt") # locate the col name

# Load lubridate
library(lubridate)

# Coerce date columns into Date objects
sales5[, date_cols] <- lapply(sales5[, date_cols], ymd)

# get failure to parse warning!! probably because of more missing values

# Find date columns 
date_cols <- str_detect(names(sales5), "dt")

# Create logical vectors indicating missing values
missing <- lapply(sales5[, date_cols], is.na) # apply is.na function to a list

# Create a numerical vector that counts missing values: num_missing
num_missing <- sapply(missing, sum)

# Print num_missing
num_missing

## example 2: mbta data

# Load readxl
library(readxl)

# Import mbta.xlsx and skip first row: mbta
mbta <- read_excel("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/mbta.xlsx", skip = 1)
head(mbta)

# View the structure of mbta
str(mbta)

# View the first 6 rows of mbta
head(mbta)

# View a summary of mbta
summary(mbta)

# Remove rows 1, 7, and 11 of mbta: mbta2
mbta2 <- mbta[c(-1,-7,-11), ]

# Remove the first column of mbta2: mbta3
mbta3 <- mbta2[,-1]

# Load tidyr
library(tidyr)

# Gather columns of mbta3: mbta4 (long format, more compact)
mbta4 <- gather(mbta3, month, thou_riders, -mode)

# View the head of mbta4
head(mbta4)

# Coerce thou_riders to numeric (type conversion)
mbta4$thou_riders <- as.numeric(mbta4$thou_riders)
head(mbta4)

# Spread the contents of mbta4: mbta5
mbta5 <- spread(mbta4, mode, thou_riders)

# View the head of mbta5
head(mbta5)


# Split month column into month and year: mbta6
mbta6 <- separate(mbta5, month, c("year","month"), sep = "-")

# View the head of mbta6
head(mbta6)

# find outliers

# View a summary of mbta6
summary(mbta6)

# Generate a histogram of Boat column
hist(mbta6$Boat)

# Find the row number of the incorrect value: i
i <- which(mbta6$Boat == 40)

# Replace the incorrect value with 4
mbta6$Boat[i] <- 4

# Generate a histogram of Boat column
hist(mbta6$Boat)

library(tidyverse)

# Look at all T ridership over time (don't change): use mode in long format
ggplot(mbta4, aes(x = month, y = thou_riders, col = mode)) + geom_point() + 
  scale_x_discrete(name = "Month", breaks = c(200701, 200801, 200901, 201001, 201101)) +  
  scale_y_continuous(name = "Avg Weekday Ridership (thousands)")


## example 3 : food
# Load data.table
library(data.table)

# Import food.csv: dt_food
dt_food <- fread("food.csv") # faster to read the file

# Convert dt_food to a data frame
df_food <- data.frame(dt_food)

# View summary of food
summary(food)

# View head of food
head(food)

# View structure of food
str(food)

# Define vector of duplicate cols (don't change)
duplicates <- c(4, 6, 11, 13, 15, 17, 18, 20, 22, 
                24, 25, 28, 32, 34, 36, 38, 40, 
                44, 46, 48, 51, 54, 65, 158)

# Remove duplicates from food: food2
food2 <- food[,-duplicates]

# Define useless vector (don't change)
useless <- c(1, 2, 3, 32:41)

# Remove useless columns from food2: food3
food3 <- food2[,-useless]

# Create vector of column indices: nutrition
nutrition <- str_detect(names(food3), "100g")

# View a summary of nutrition columns
summary(food3[,nutrition])

# Find indices of sugar NA values: missing
missing <- is.na(food3$sugars_100g)

# Replace NA values with 0
food3$sugars_100g[missing] <- 0

# Create first histogram
hist(food3$sugars_100g, breaks = 100)

# Create food4 (exclude rows with zero sugars in them)
food4 <- food3[food3$sugars_100g > 0, ]

# Create second histogram
hist(food4$sugars_100g, breaks = 100)

# Find entries containing "plasti": plastic
plastic <- str_detect(food3$packaging,"plasti")

# Print the sum of plastic
sum(plastic)

## example 4: attendence

# Load the gdata package
library(gdata)

# Import the spreadsheet: att
att <- read.xls("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/attendance.xls", sheet = 1)

# Print the column names 
names(att)

# Print the first 6 rows
head(att)

# Print the last 6 rows
tail(att)

# Print the structure
str(att)

# When you're importing a messy spreadsheet into R, 
# it's good practice to compare the original spreadsheet with what you've imported. It turns out that, by default, 
# the read.xls() function skips empty rows such as the 11th and 17th.

# Create remove
remove <- c(3,56:59)

# Create att2
att2 <- att[-remove, ]

# Create remove
remove2 <- c(3, 5, 7, 9, 11, 13, 15, 17)

# Create att3
att3 <- att2[, -remove2]

# Subset just elementary schools: att_elem
att_elem <- att3[, c(1,6,7)]

# Subset just secondary schools: att_sec
att_sec <- att3[, c(1,8,9)]

# Subset all schools: att4
att4 <- att3[, c(1:5)]

# Define cnames vector (don't change)
cnames <- c("state", "avg_attend_pct", "avg_hr_per_day", 
            "avg_day_per_yr", "avg_hr_per_yr")

# Assign column names of att4
colnames(att4) <- cnames

# Remove first two rows of att4: att5
att5 <- att4[-c(1,2),]

# View the names of att5
names(att5)

# Remove all periods in state column
att5$state <- str_replace_all(att5$state, "\\.", "")

# Remove white space around state names
att5$state <- str_trim(att5$state)

# View the head of att5
head(att5)

# Change columns to numeric using dplyr (don't change)
library(dplyr)
example <- mutate_each(att5, funs(as.numeric), -state)

# Define vector containing numerical columns: cols
cols <- c(2:5)

# Use sapply to coerce cols to numeric
att5[, cols] <- sapply(att5[,cols], as.numeric)

