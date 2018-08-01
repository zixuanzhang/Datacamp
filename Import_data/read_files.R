####### import data ######

### five types of data ####

### 1. flat files (values seperated by commas)
# Import swimming_pools.csv correctly: pools
pools <- read.csv("swimming_pools.csv", stringsAsFactors = FALSE) # treat values as strings(charaters)

# factor is used for categorical variable
head(pools)

# Check the structure of pools
str(pools)

### 2. text files
# Import hotdogs.txt: hotdogs
hotdogs <- read.delim("hotdogs.txt", header = FALSE) # first line is not header
head(hotdogs)
# Summarize hotdogs
summary(hotdogs) # give a summary of the statistics

# use read.table():a more general way of reading any type of data, takes many arguments

# Path to the hotdogs.txt file: path
path <- file.path("data", "hotdogs.txt")

# Import the hotdogs.txt file: hotdogs
hotdogs <- read.table(path, 
                      sep = "", # seperated by tabs
                      col.names = c("type", "calories", "sodium"))

# Call head() on hotdogs
head(hotdogs)

## for tab-delimited files
# Finish the read.delim() call
hotdogs <- read.delim("hotdogs.txt", header = FALSE, col.names = c("type", "calories", "sodium"))

# Select the hot dog with the least calories: lily
lily <- hotdogs[which.min(hotdogs$calories), ]

# Select the observation with the most sodium: tom
tom <- hotdogs[which.max(hotdogs$sodium), ]

# Print lily and tom
lily
tom

##
# Previous call to import hotdogs.txt
hotdogs <- read.delim("hotdogs.txt", header = FALSE, col.names = c("type", "calories", "sodium"))

# Display structure of hotdogs
str(hotdogs)

# Edit the colClasses argument to import the data correctly: hotdogs2
hotdogs2 <- read.delim("hotdogs.txt", header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor","NULL", "numeric")) 
                       # NULL means that column will be skipped and not loaded into dataframe

# Display structure of hotdogs2
str(hotdogs2)

### read.csv() and read.delim() are wrappers from read.table()
### they are functions of read.table() with different default format
### read.csv(): default (header=TRUE sep = ",")
### read.delim(): default (header=TRUE, sep = "\t") \t means a tab


#### readr ######
library(readr)
read_csv("#name") # the result gives dataframe with tibbles, values are strings
# similar to read.csv() 
# assumes the first row contains col names

read_tsv("#name") # tab-seperated-values; similar to read.delim()

read_delim() # similar as read.table(), the main function

## example
# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")

# Import potatoes.txt: potatoes
potatoes <- read_tsv("potatoes.txt", col_names = properties)

# Call head() on potatoes
head(potatoes)

# Import potatoes.txt using read_delim(): potatoes
### At least specifcy file name and delim
potatoes <- read_delim("potatoes.txt", delim = "\t", col_names = properties)

# Print out potatoes
potatoes

## skip and n_max
## Through skip and n_max you can control which part of your flat file 
#you're actually importing into R. 
# skip specifies the number of lines you're ignoring in the flat file before actually starting to import data
# n_max specifies the number of lines you're actually importing

# Import 5 observations from potatoes.txt: potatoes_fragment
# print line 7,8,9,10,11 
potatoes_fragment <- read_tsv("potatoes.txt", skip = 6, n_max = 5, col_names = properties)

## speficify types of the data to be imported
# c: character
# d: double
# i: integer
# l: logical
# _: skip the column

# Import all data, but force all columns to be character: potatoes_char
potatoes_char <- read_tsv("potatoes.txt", col_types = "cccccccc", col_names = properties)

# example
# Import without col_types
hotdogs <- read_tsv("hotdogs.txt", col_names = c("type", "calories", "sodium"))

# Display the summary of hotdogs
summary(hotdogs)

# The collectors you will need to import the data
fac <- col_factor(levels = c("Beef", "Meat", "Poultry"))
int <- col_integer()

# Edit the col_types argument to import the data correctly: hotdogs_factor
hotdogs_factor <- read_tsv("hotdogs.txt",
                           col_names = c("type", "calories", "sodium"),
                           col_types = list(fac,int,int)) # use list()

# Display the summary of hotdogs_factor
summary(hotdogs_factor)
# first column is regarded as factor with levels, the rest two columns are integers

######## data.table #########
library(data.table) # easier to use, can self correct, create a class of data.table

# Import potatoes.csv with fread(): potatoes
potatoes <- fread("potatoes.csv")

## drop and select
## all the following command do the same thing: import only column 1 and 5 
# fread("path/to/file.txt", drop = 2:4)
# fread("path/to/file.txt", select = c(1, 5))
# fread("path/to/file.txt", drop = c("b", "c", "d")
# fread("path/to/file.txt", select = c("a", "e"))


########## excel file; readxl #########
library(gapminder)

# Load the readxl package
library(readxl)

# Print out the names of both spreadsheets
excel_sheets("urbanpop.xlsx") # see which sheets are contained in the workbook
# Read the sheets, one by one
pop_1 <- read_excel("urbanpop.xlsx", sheet = 1) # by sheet number or by sheet name
pop_2 <- read_excel("urbanpop.xlsx", sheet = 2)
pop_3 <- read_excel("urbanpop.xlsx", sheet = 3)

# Put pop_1, pop_2 and pop_3 in a list: pop_list
pop_list <- list(pop_1, pop_2, pop_3)

# Display the structure of pop_list
str(pop_list)

# a faster way to read all sheets at once
# Read all Excel sheets with lapply(): pop_list
pop_list <- lapply(excel_sheets("urbanpop.xlsx"), read_excel, path = "urbanpop.xlsx")

# Display the structure of pop_list
str(pop_list)

## col_names option when import
# the default setting of col_names is TRUE
# Import the the first Excel sheet of urbanpop_nonames.xlsx (R gives names): pop_a
pop_a <- read_excel("urbanpop_nonames.xlsx", sheet = 1, col_names = FALSE)

# Import the the first Excel sheet of urbanpop_nonames.xlsx (specify col_names): pop_b
cols <- c("country", paste0("year_", 1960:1966))
pop_b <- read_excel("urbanpop_nonames.xlsx", sheet = 1, col_names = cols)

# Print the summary of pop_a
summary(pop_a)

# Print the summary of pop_b
summary(pop_b)

## skip option (same as in the readr)
# Import the second sheet of urbanpop.xlsx, skipping the first 21 rows: urbanpop_sel
urbanpop_sel <- read_excel("urbanpop.xlsx", sheet = 2, skip = 21, col_names = FALSE)

# Print out the first observation from urbanpop_sel
urbanpop_sel[1,]


###### gdata package ##########
# Load the gdata package
library(gdata)

# Import the second sheet of urbanpop.xls: urban_pop
urban_pop <- read.xls("urbanpop.xls", sheet = "1967-1974") # default include col_names

# Print the first 11 observations using head()
head(urban_pop,11)


# Column names for urban_pop
columns <- c("country", paste0("year_", 1967:1974)) # paste0() concatenate together

# Finish the read.xls call
urban_pop <- read.xls("urbanpop.xls", sheet = 2,
                      skip = 50, header = FALSE, stringsAsFactors = FALSE,
                      col.names = columns)

# Print first 10 observation of urban_pop
head(urban_pop, 10)

## example
# Add code to import data from all three sheets in urbanpop.xls
path <- "urbanpop.xls"
urban_sheet1 <- read.xls(path, sheet = 1, stringsAsFactors = FALSE)
urban_sheet2 <- read.xls(path, sheet = 2, stringsAsFactors = FALSE)
urban_sheet3 <- read.xls(path, sheet = 3, stringsAsFactors = FALSE)

# Extend the cbind() call to include urban_sheet3: urban
## remove first column in sheet2 and sheet3 so the names will not duplicate
urban <- cbind(urban_sheet1, urban_sheet2[-1], urban_sheet3[-1]) 

# Remove all rows with NAs from urban: urban_clean
urban_clean <- na.omit(urban)

# Print out a summary of urban_clean
summary(urban_clean)

########### XLConnect package #########
# Load the XLConnect package
library(XLConnect)
require("XLConnect")

# Build connection to urbanpop.xlsx: my_book
my_book <- loadWorkbook("urbanpop.xlsx")

# Print out the class of my_book
class(my_book)

# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx") # import the workbook

# List the sheets in my_book
getSheets(my_book) # list the content

# Import the second sheet in my_book
readWorksheet(my_book, sheet = 2) # read the sheet

# example
# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")

# Import columns 3, 4, and 5 from second sheet in my_book: urbanpop_sel
urbanpop_sel <- readWorksheet(my_book, sheet = 2, startCol = 3, endCol= 5)

# Import first column from second sheet in my_book: countries
countries <- readWorksheet(my_book, sheet = 2, startCol = 1, endCol= 1)

# cbind() urbanpop_sel and countries together: selection
selection <- cbind(countries, urbanpop_sel)
head(selection)


### XLConnect allows editing of excel workbook
### add new worksheet

# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")

# Add a worksheet to my_book, named "data_summary"
createSheet(my_book, name = "data_summary")

# Use getSheets() on my_book
getSheets(my_book)

## example
# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")

# Add a worksheet to my_book, named "data_summary"
createSheet(my_book, "data_summary")

# Create data frame: summ
sheets <- getSheets(my_book)[1:3]
dims <- sapply(sheets, function(x) dim(readWorksheet(my_book, sheet = x)), USE.NAMES = FALSE)
summ <- data.frame(sheets = sheets,
                   nrows = dims[1, ],
                   ncols = dims[2, ])

# Add data in summ to "data_summary" sheet
writeWorksheet(my_book, summ, sheet = "data_summary")

# Save workbook as summary.xlsx
saveWorkbook(my_book, file = "summary.xlsx")

