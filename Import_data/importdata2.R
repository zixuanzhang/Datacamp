####### import data 2 ########

# establish connection to database
# con is DBI connection object
# dbConnect() creates a connection between your R session and a SQL database
library(DBI)
con <- dbConnect(RMySQL::MySQL(), # the driver to be used
                 dbname = "tweater", # database name
                 host = "courses.csrrinzqubik.us- 
                            east-1.rds.amazonaws.com", # in which the database is hosted
                 port = 3306, # which port you want to connect
                 user = "student", # credentials to autheticate yourself
                 password = "datacamp")

# now you are connect to MySQL database

# Build a vector of table names: tables
tables <- dbListTables(con) # see what is contained in the database

# Display structure of tables
str(tables) # "users", "comments", "tweats"

# Import the users table from tweater: users
users <- dbReadTable(con, "users")

# Print users
users

## import all data tables at once

# Get table names
table_names <- dbListTables(con)

# Import all tables
tables <- lapply(table_names, dbReadTable, conn = con) # connection object is con

# Print out tables
tables

## to import part of the tables
# method I (within R session)
employees <- dbReadTable(con, "employees")
subset(employees,  
       subset = started_at > "2012-09-01", select = name) # select the employees starts after this date

# method II (in the SQL, more efficient to import data of interest)
dbGetQuery(con, "SELECT name FROM emloyees WHERE started_at > \"2012-09-01\"")

# SELECT (which column) FROM (which table in the con) WHERE (the condition)

# example
dbGetQuery(con, "SELECT * FROM products WHERE contract = 1") # * means to keep all columns; single equal sign

# Import tweat_id column of comments where user_id is 1: elisabeth
elisabeth <- dbGetQuery(con, "SELECT tweat_id FROM comments WHERE user_id = 1")

# Import post column of tweats where date is higher than '2015-09-21': latest
latest <- dbGetQuery(con, "SELECT post FROM tweats WHERE date > \"2015-09-21\"")

# Create data frame specific
specific <- dbGetQuery(con, "SELECT message FROM comments WHERE tweat_id = 77 AND user_id > 4")

# Create data frame short; select id and name column (seprated by comma)
short <- dbGetQuery(con, "SELECT id,name FROM users WHERE CHAR_LENGTH(name) < 5")

## use inner join
dbGetQuery(con, "SELECT name, post
           FROM users INNER JOIN tweats on users.id = user_id
           WHERE date > \"2015-09-19\"") # join two tables together by users id and then select

## DBI internals

# Send - Fetch - Clear

res <- dbSendQuery(con, "SELECT * FROM products
                                   WHERE contract = 1") # data not imported yet
dbFetch(res)
dbClearResult(res) # clear data

# db fetch one by one to check data 
res <- dbSendQuery(con, "SELECT * FROM products
                                   WHERE contract = 1")

while(!dbHasCompleted(res)) {
  chunk <- dbFetch(res, n = 1)
  print(chunck)
} # print each row one by one

dbClearResult(res) 

dbDisconnect(con)

## example
# Use dbFetch() twice
dbFetch(res, n = 2) # in a chunk of 2 rows 
dbFetch(res) # all remaining queries

# Clear res
dbClearResult(res)

# example
# Create the data frame  long_tweats
long_tweats <- dbGetQuery(con, "SELECT post,date FROM tweats WHERE CHAR_LENGTH(post) > 40") # character length

# Print long_tweats
print(long_tweats)

# Disconnect from the database
dbDisconnect(con)

######## HTTP #########
## utils functions
read.csv("http://s3.amazonaws.com/assets.datacamp.com/course/importing_data_into_r/states.csv")

read.csv("https://s3.amazonaws.com/assets.datacamp.com/course/importing_data_into_r/states.csv") # https

# R recognize this is an URL so it does GET request and read the csv file as usual

## readr package
# Load the readr package
library(readr)

# Import the csv file: pools
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"

pools <- read_csv(url_csv)

# Import the txt file: potatoes
url_delim <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/potatoes.txt"

potatoes <- read_tsv(url_delim)

head(pools)
head(potatoes)

## HTTPS is safer than HTTP to use
# https URL to the swimming_pools csv file.
url_csv <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"

# Import the file using read.csv(): pools1
pools1 <- read.csv(url_csv)

# Load the readr package
library(readr)

# Import the file using read_csv(): pools2
pools2 <- read_csv(url_csv)

# Print the structure of pools1 and pools2, work equally well
str(pools1)
str(pools2) 

#### read excel ######
# readxl cannot read URL directly into R session
library(readxl)
url <- "http://s3.amazonaws.com/assets.datacamp.com/course/importing_data_into_r/cities.xlsx"
dest_path <- file.path("/Users/zixuanzhang/Desktop/DataCamp_Note", "cities.xlsx") # destination path

download.file(url, dest_path)
read_excel(dest_path)

##### use gdata and readxl #########
# Specification of url: url_xls
library(gdata)
url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"

# Import the .xls file with gdata: excel_gdata
excel_gdata <- read.xls(url_xls)

# Download file behind URL, name it local_latitude.xls
download.file(url_xls, destfile = "local_latitude.xls")

# Import the local .xls file with readxl: excel_readxl
excel_readxl <- read_excel("local_latitude.xls")

######## load RData from http #########
# https URL to the wine RData file.
url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"

# Download the wine file to your working directory
download.file(url_rdata, "wine_local.RData")

# Load the wine data into your workspace using load()
load("wine_local.RData") # wine data

# Print out the summary of the wine data
summary(wine)

# or you can use load(url()) such that the raw data will not be stored locally

########## HTTR package ###########
# Load the httr package
library(httr)

# Get the url, save response to resp
url <- "http://www.example.com/"
resp <- GET(url)

# Print resp
resp

# Get the raw content of resp: raw_content
raw_content <- content(resp, as = "raw")

# Print the head of raw_content
head(raw_content)


########### API and JSON ############

#In the simplest setting, fromJSON() can convert character strings 
# that represent JSON data into a nicely structured R list.

# Load the jsonlite package
library(jsonlite)

# wine_json is a JSON
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'

# Convert wine_json into a list: wine
wine <- fromJSON(wine_json)

# Print structure of wine
str(wine)

## import JSON data directly from the web
# Definition of quandl_url
quandl_url <- "https://www.quandl.com/api/v3/datasets/WIKI/FB/data.json?auth_token=i83asDsiWUUyfoypkgMz"

# Import Quandl data: quandl_data
quandl_data <- fromJSON(quandl_url)

# Print structure of quandl_data
str(quandl_data) # a matrix


# Definition of the URLs; OMDb API
url_sw4 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0076759&r=json"
url_sw3 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0121766&r=json"

# Import two URLs with fromJSON(): sw4 and sw3
sw4 <- fromJSON(url_sw4)
sw3 <- fromJSON(url_sw3)

# Print out the Title element of both lists
sw4$Title
sw3$Title

# Is the release year of sw4 later than sw3?
sw3$Year < sw4$Year

###### more about JSON and Jsonlite
## JSON object and arrays (two structures)

## convert R to JSON 
# convert to an integer vector
json1 <- '[1, 2, 3, 4, 5, 6]'
fromJSON(json1)

# convert to a list
json2 <- '{"a": [1, 2, 3] , "b": [4, 5, 6]}'
fromJSON(json2)

# JSON matrix
json1 <- '[[1, 2], [3, 4]]'
fromJSON(json1)

# JSON array
json2 <- '[{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b" : 6}]'
fromJSON(json2) # well structured

## convert JSON to R
# URL pointing to the .csv file
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"

# Import the .csv file located at url_csv
water <- read.csv(url_csv, stringsAsFactors = F)

# Convert the data file according to the requirements
water_json <- toJSON(water)

# Print out water_json
water_json # hard to read

### prettify() and minify()
# Convert mtcars to a pretty JSON: pretty_json
pretty_json <- toJSON(mtcars, pretty = T) # or prettify(toJSON(mtcars))

# Print pretty_json
pretty_json

# Minify pretty_json: mini_json
mini_json <- minify(pretty_json)

# Print mini_json
mini_json

########## import data from statistical software haven #########
### haven package can import data in the format of 
## SAS, STATA, and SPSS

#### haven package : use underscore
# Load the haven package
library(haven)

# Import sales.sas7bdat: sales
sales <- read_sas("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/sales.sas7bdat")

# Display the structure of sales
str(sales)

# Import the data from the URL: sugar
sugar <- read_dta("http://assets.datacamp.com/production/course_1478/datasets/trade.dta")

# Structure of sugar
str(sugar) # Date is labelled 

# Convert values in Date column to dates
sugar$Date <- as.Date(as_factor(sugar$Date))

# Structure of sugar again
str(sugar)
head(sugar)

plot(sugar$Import, sugar$Weight_I) # positively related

## SPSS example

# Import person.sav: traits
traits <- read_sav("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/personality.sav")

# Summarize traits
summary(traits)

# Print out a subset
subset(traits, PERS01 > 1 & PERS02 > 2)

## example
# Import SPSS data from the URL: work
work <- read_sav("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/employee.sav")

# Display summary of work$GENDER
summary(work$GENDER)

# Convert work$GENDER to a factor
work$GENDER <- as_factor(work$GENDER)

# Display summary of work$GENDER again
summary(work$GENDER)

### foreign package: use dot
# Load the foreign package
library(foreign)

## read STATA file
# Import florida.dta and name the resulting data frame florida
florida <- read.dta("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/florida.dta")

# Check tail() of florida
tail(florida)

# example
# Specify the file path using file.path(): path
path <- file.path("worldbank/edequality.dta")

# Create and print structure of edu_equal_1
edu_equal_1 <- read.dta(path)
str(edu_equal_1)

# Create and print structure of edu_equal_2
edu_equal_2 <- read.dta(path, convert.factors = F)
str(edu_equal_2)

# Create and print structure of edu_equal_3
edu_equal_3 <- read.dta(path, convert.underscore = T)
str(edu_equal_3)

## SPSS data
library(foreign)
# Import international.sav as a data frame: demo
demo <- read.spss("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/international.sav", to.data.frame = T)

# Create boxplot of gdp variable of demo
boxplot(demo$gdp)

# calculate pearson's correlation between two variables
cor(demo$gdp, demo$f_illit)

## to.data.frame and use.value.labels
# Import international.sav as demo_1
demo_1 <- read.spss("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/international.sav", to.data.frame = T)

# Print out the head of demo_1
head(demo_1)

# Import international.sav as demo_2, do not convert labelled to factors in R
demo_2 <- read.spss("/Users/zixuanzhang/Desktop/DataCamp_Note/Data/international.sav",to.data.frame = T, use.value.labels = F)

# Print out the head of demo_2
head(demo_2)

