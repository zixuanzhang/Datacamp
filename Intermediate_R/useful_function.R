####### useful functions #######

## mathematical utilities
v1 <- c(1.1, -7.1, 5.4, -2.7)
v2 <- c(-3.6, 4.1, 5.8, -8.0)

# abs()
abs(v1)
abs(v2)

# round()
round(abs(v1))
round(abs(v2))

# sum()
sum(round(abs(v1)))
sum(round(abs(v2)))

# mean()
mean(c(sum(round(abs(v1))), sum(round(abs(v2)))))

## functions for data structures
li <- list(log = TRUE,
           ch = "hello",
           int_vec = sort(rep(seq(8, 2, by = -2), times = 2)))

# seq()
seq(1,10,by = 3) # generate a sequence from 1 to 10 by increment of 3
seq(8,2,by = -2)

# rep()
rep(c(8,6,4,2), times=2) # repeat the sequence by its order two times
rep(c(8,6,4,2), each=2) # repeat each element twice in the sequence

sort(c(8, 6, 4, 2, 8, 6, 4, 2)) # sort the order from least to greatest
sort(c(8, 6, 4, 2, 8, 6, 4, 2), decreasing = TRUE) # reverse the order

# str()
str(li) # look at the structure of data 

# is.()  as.() test
is.list(li)
is.list(c(1,2,3,4))

li2 <- as.list(c(1,2,3,4)) # convert the vector to list
is.list(li2)
unlist(li2) # convert back to vector

# append(), rev()
str(append(li, rev(li))) # extend the list by a reverse of list li

######## regular expressions ########
animals <- c("cat", "moose", "impala", "ant", "kiwi")

# grepl()
?grepl # return logical 
grepl(pattern = "a", x = animals) # look for animals which has "a" in it
grepl(pattern = "^a", x = animals) # look for names starting with "a"
grepl(pattern = "a$", x = animals) # look for names end with "a"

# grep() 
?grep # return indices which matches
grep(pattern = "a", x = animals)
which(grepl(pattern = "a", x = animals)) # same as above

grep(pattern = "^a", x = animals)

# sub(), gsub()
sub(pattern = "a", replacement = "o", x = animals) # only replace the first matching
gsub(pattern = "a", replacement = "o", x = animals) # replace every matching

gsub(pattern = "a|i", replacement = "_", x = animals)

# example
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for .edu addresses more robustly
grepl(pattern = "@.*\\.edu$", emails) # match the .edu part, \\ tell R to use "." as character

# Use grep() to match for .edu addresses more robustly, save result to hits
hits <- grep(pattern = "@.*\\.edu$", emails)
hits
# Subset emails using hits
emails[hits]

# example
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "global@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use sub() to convert the email domains to datacamp.edu
sub("@.*\\.edu$", "@datacamp.edu",emails)

######## times and date #######
today <- Sys.Date()
today
class(today)

now <- Sys.time()
now
class(now)

my_date <- as.Date("1996-1-29") # default format
my_date
class(my_date)

my_date <- as.Date("1971-14-05", format = "%Y-%d-%m")
my_date

my_time <- as.POSIXct("1971-05-14 11:25:15")
my_time

# date arithmetic
my_date
my_date + 1 # days increment

my_date2 <- as.Date("1998-09-29")
my_date2 - my_date # substract

my_time
my_time + 1 # incremnet by second

my_time2 <- as.POSIXct("1974-07-14 21:11:55 CET")
my_time2 - my_time

## how does R deal with dates and time
unclass(my_date) # 498 days from 01-01-1970
unclass(my_time) # seconds from 01-01-1970 00:00:00

# Definition of character strings representing dates
str1 <- "May 23, '96"
str2 <- "2012-03-15"
str3 <- "30/January/2006"

# Convert the strings to dates: date1, date2, date3
date1 <- as.Date(str1, format = "%b %d, '%y")
date2 <- as.Date(str2)
date3 <- as.Date(str3, format = "%d/%B/%Y")


# Convert dates to formatted strings
format(date1, "%A")
format(date2, "%d")
format(date3, "%b %Y")

## convert time
# Definition of character strings representing times
str1 <- "May 23, '96 hours:23 minutes:01 seconds:45"
str2 <- "2012-3-12 14:23:08"

# Convert the strings to POSIXct objects: time1, time2
time1 <- as.POSIXct(str1, format = "%B %d, '%y hours:%H minutes:%M seconds:%S")
time2 <- as.POSIXct(str2)
time1
time2

# Convert times to formatted strings
format(time1, "%M")
format(time2, "%I:%M %p")
