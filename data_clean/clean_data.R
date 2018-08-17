######## cleaning data #########

# explore raw data 
# tidying data
# prepare data for analysis

######### explore raw data ##########
## three steps :
# understand the structure of the data
# look at your data
# visualize your data

library(readr)
sleep <- read_csv("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/msleep_ggplot2.csv")

class(sleep) # check the class
dim(sleep) # check the dimensions: row by col
names(sleep) # check the column names of the data

# or use dplyr way of checking the structure
# Load dplyr
library(dplyr)

# Check the structure of bmi, the dplyr way
glimpse(sleep) # give previews of data, columns with labels, more infor

# View a summary of bmi
summary(sleep)

### plot the data
## view with head and tail

# View the first 6 rows
head(sleep)

# View the first 15 rows
head(sleep, 15)

# View the last 6 rows
tail(sleep)

# View the last 10 rows
tail(sleep, 10)

## histogram and scatterplot
# histogram plot for a single variable
hist(sleep$sleep_total)

# scatterplot plot for two variables to see their correlation
plot(sleep$brainwt, sleep$bodywt)

####### principles of tidy data #######
# observations as rows 
# variables as columns
# one type of observational unit per table

### wide or long format
# wide: column values in the variable names (more cols than rows)
# long: column values stay within the col (more rows than cols)

## Gather cols into key-value pairs: convert long to wide

# Apply gather() to bmi and save the result as bmi_long
bmi_long <- gather(bmi, 
                   year, # new variable called year
                   bmi_val, # the corresponding values to each year
                   -Country) # gather all cols except Country


# View the first 20 rows of the result
head(bmi_long, 20)

## spread key-value pairs into columns: convert wide to long
# being used when col names are in the col
# make data more compact and easy to read

# Apply spread() to bmi_long
bmi_wide <- spread(bmi_long, 
                   year, # col to spread into variable names
                   bmi_val) # values

# View the head of bmi_wide
head(bmi_wide)

### seperate() and unite()
# seperate() will seperate one col into multiple columns as you name it
# often used to break date time

separate(treatments, year_mo, c("year", "month")) # by default, it will attempt to separate on any character that is not a letter or number.
seperate(treatments, 
         year_mo, # col to seperate
         c("year", "month"), # new col name in characters
         sep = "-") # seperated by dash

# example
# Apply separate() to bmi_cc
bmi_cc_clean <- separate(bmi_cc, col = Country_ISO, into = c("Country", "ISO"), sep = "/")

# Print the head of the result
head(bmi_cc_clean)

# Apply unite() to bmi_cc_clean
bmi_cc <- unite(bmi_cc_clean, 
                Country_ISO, # new col name (not in character)
                Country, # col to unite
                ISO, # col to unite
                sep = "-") # seperate by dash (default is _)

# View the head of the result
head(bmi_cc)

###### common messy tables ########
## col headers are values not variable names
# View the head of census
head(census)

# Gather the month columns
census2 <- gather(census, month, amount, -YEAR) 

# Arrange rows by YEAR using dplyr's arrange
census2 <- arrange(census2, YEAR) # arrange in the order of year

# Spread the type column
census_long2 <- spread(census_long,
                       type, # the col to spread
                       amount) # value column

# View first 20 rows of census_long2
head(census_long2, 20)

## multiple values are stored in one column
# use separate() and its opporsite unite()

#### type conversions/ coercions
# characters: ""
# numeric: includes decimals, NaN, Inf
# integer: include 4L, 1123L
# factor: factor("Hello"), factor(8), for categorical variables
# logical: TRUE, FALSE, NA(for missing values)

as.character(2016) # coerce numeric to character
as.numeric(TRUE) # numeric representation of TRUE in R
as.integer(99) # do not print L as suffice
as.factor("something")
as.logical(0)

# package of lubridate, deal with date
library(lubridate)

ymd("2015-08-25") # year month day
ymd("2015 August 25") # same result as last one

mdy("August 25, 2015")
hms("13:33:09") # hour min sec

ymd_hms("2015/08/25 13.33.09")

## example: coerce type of entire column
# Preview students with str()
str(students)

# Coerce Grades to character
students$Grades <- as.character(students$Grades)

# Coerce Medu to factor
students$Medu <- factor(students$Medu)

# Coerce Fedu to factor
students$Fedu <- factor(students$Fedu)

# example: lubridate functions
# Parse as date
dmy("17 Sep 2015")

# Parse as date and time (with no seconds!)
mdy_hm("July 15, 2012 12:56")

# Coerce dob to a date (with no time)
students2$dob <- ymd(students2$dob)

# Coerce nurse_visit to a date and time
students2$nurse_visit <- ymd_hms(students2$nurse_visit)

# Look at students2 once more with str()
str(students2)

###### string manipulation
library(stringr)

# trim leading and trailing white space
str_trim("  this is a test  ")

# add spaces back
str_pad("24493", 
        width = 7, # seven digits total
        side = "left", # if not, pad the left space with 
        pad = "0" # zeros until it's 7 digits
        )

# create character vector
friends <- c("Sarah", "Tom", "Alice")

# search for strings in vector; detect if where the Alice is in the vector
str_detect(friends, "Alice") # return logical vector

# replace string in the vector
str_replace(friends, "Alice", "David") # replace Alice with David

# make all characters in lower case
tolower("I AM TALKING LOUDLY!!")

# make upper case
toupper("I am whispering...")

## example
# Trim all leading and trailing whitespace
str_trim(c("   Filip ", "Nick  ", " Jonathan"))


# Pad these strings with leading zeros
str_pad(c("23485W", "8823453Q", "994Z"), width = 9, side = "left", pad = 0)

# example
# In the sex column, replace "F" with "Female" ...
students3$sex <- str_replace(students3$sex, "F", "Female")

# ... and "M" with "Male"
students3$sex <- str_replace(students3$sex, "M", "Male")

### missing and special values
df <- data.frame(A = c(1, NA, 8, NA),
                 B = c(3, NA, 88, 23),
                 C = c(2, 45, 3, 1)) # 4 rows, 3 cols

# check for NAs
is.na(df)

# Are there any NAs?
any(is.na(df))

# count number of NAs
sum(is.na(df))

# use summary() to find NAs
summary(df)

# Find rows with no missing values
complete.cases(df) # a logical vector representing rows

# Subset data, keeping only complete cases
df[complete.cases(df),]

# Another way to remove rows with NAs
na.omit(df) # remove rows

## example: social_df
# Call is.na() on the full social_df to spot all NAs
is.na(social_df)

# Use the any() function to ask whether there are any NAs in the data
any(is.na(social_df))

# View a summary() of the dataset
summary(social_df)

# Call table() on the status column
table(social_df$status) # see the status cols, other format of missing values

# Replace all empty strings in status with NA
social_df$status[social_df$status == ""] <- NA

# Use complete.cases() to see which rows have no missing values
complete.cases(social_df)

# Use na.omit() to remove all rows with any missing values
na.omit(social_df)

####### ouliers and obvious errors
set.seed(10)
x <- c(rnorm(30, mean = 15, sd = 5), -5, 28, 35) # random numbers with three outliers
boxplot(x, horizontal = T)

# another small dataset
df2 <- data.frame(A = rnorm(100, 50, 10),
                  B = c(rnorm(99, 50, 10), 500),
                  C = c(rnorm(99, 50, 10), -1))

## detect outliers in the plot
# histogram
hist(df2$B, breaks = 20) # breaks is the bin size

# boxplot
boxplot(df2)

## example
# Look at a summary() of students3
summary(students3)

# View a histogram of the age variable
hist(students3$age)

# View a histogram of the absences variable
hist(students3$absences)

# View a histogram of absences, but force zeros to be bucketed to the right of zero
hist(students3$absences, right = FALSE) # left close, right open interval??

##### real problem work through (general steps)
## weather data

# Verify that weather is a data.frame
class(weather)

# Check the dimensions
dim(weather)

# View the column names
names(weather)

# View the structure of the data
str(weather)

# Load dplyr package
library(dplyr)

# Look at the structure using dplyr's glimpse()
glimpse(weather)

# View a summary of the data
summary(weather)

# View first 6 rows
head(weather)

# View first 15 rows
head(weather, 15)

# View the last 6 rows
tail(weather)

# View the last 10 rows
tail(weather, 10)

## col names are values
# Load the tidyr package
library(tidyr)

# Gather the columns: convert to long format
weather2 <- gather(weather, day, value, X1:X31, na.rm = TRUE)

# View the head
head(weather2)

## col names are in the value of a col (spread)
# First remove column of row names
weather2 <- weather2[, -1]

# Spread the data
weather3 <- spread(weather2, measure, value)

# View the head
head(weather3)

## prepare for analysis
# Load the stringr and lubridate packages
library(stringr)
library(lubridate)

# date format
# Remove X's from day column
weather3$day <- str_replace(weather3$day, "X", "")

# Unite the year, month, and day columns
weather4 <- unite(weather3, date, year, month, day, sep = "-")

# Convert date column to proper date format using lubridates's ymd()
weather4$date <- ymd(weather4$date)

# Rearrange columns using dplyr's select()
weather5 <- select(weather4, date, Events, CloudCover:WindDirDegrees)

# View the head of weather5
head(weather5)

# column types

# View the structure of weather5
str(weather5)

# Examine the first 20 rows of weather5. Are most of the characters numeric?
head(weather5, 20)

# See what happens if we try to convert PrecipitationIn to numeric
as.numeric(weather5$PrecipitationIn) # give warnings, R introduce NA to the "T"

# to avoid this introduction of NA
# Replace "T" with "0" (T = trace)
weather5$PrecipitationIn <- str_replace(weather5$PrecipitationIn, "T", "0")

# Convert characters to numerics: apply as.numeric() to multiple cols
weather6 <- mutate_at(weather5, 
                      vars(CloudCover:WindDirDegrees), # which cols to change
                      funs(as.numeric)) # functions to apply

# Look at result
str(weather6)

## find missing values

# Count missing values
sum(is.na(weather6))

# Find missing values
summary(weather6)

# Find indices of NAs in Max.Gust.SpeedMPH
ind <- which(is.na(weather6$Max.Gust.SpeedMPH)) # get row numbers

# Look at the full rows for records missing Max.Gust.SpeedMPH
weather6[ind, ]

# correct error (outlier)

# Review distributions for all variables
summary(weather6)

# Find row with Max.Humidity of 1000
ind <- which(weather6$Max.Humidity == 1000)

# Look at the data for that day
weather6[ind, ]

# Change 1000 to 100: data entry error
weather6$Max.Humidity[ind] <- 100

## check other extreme values
# Review summary of full data once more
summary(weather6)

# Look at histogram for MeanDew.PointF
hist(weather6$MeanDew.PointF)

# Look at histogram for Min.TemperatureF
hist(weather6$Min.TemperatureF)

# Compare to histogram for Mean.TemperatureF
hist(weather6$Mean.TemperatureF)

## final wrap up
# Clean up column names
names(weather6) <- new_colnames # col names better use "_" instead of "."

# Replace empty cells in events column
weather6$events[weather6$events == ""] <- "None"

# Print the first 6 rows of weather6
head(weather6)



