library(tidyverse)


# Creating date and time -------------------------------------------------

ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017") # the order of the letters in the function name describe the order of the components in the date string

# type and class of a date
my_date <- dmy("31-Jan-2017")
typeof(my_date)
class(my_date)
unclass(dmy("31-Jan-1900"))
# Under the hood, *dates* are doubles. Days since 1970-01-01.

# Datetimes
ymd_hms("2017-01-31 20:11:59")
mdy_hm("1/31/2017 08:01")

# lubridate functions will do their best to infer the date format for you
ymd_hms("2017_Jan_31_20^11^59") # Jan to Janu breaks this

# Datetimes under the thood are doubles, the number of *seconds* since /1/79
my_datetime <- mdy_hm("1/31/2017 08:01")
class(my_datetime)
unclass(my_datetime)

# because dates and times are just numbers, it's easy to add to them
my_datetime
my_datetime + 1
my_datetime + 60 * 60 * 24

# This can get funky, so instead use e.g., days()
my_datetime + days(3)

# Getting components -----------------------------------------------------

# Functions like year(), mponth(), hour(), minute() all extract components

year(my_datetime)
month(my_datetime)

# Setting label = TRUE givwes us factors in the appropriate order
month(my_datetime, label = TRUE) # This is a Factor, it has order and not done alphabetically but by ORDER Therefore 1 = Jan

# This gave us all the levels /possibilities. This means that this is a factor. Factors have levels.
wday(my_datetime)
wday(my_datetime, label = TRUE)


# Datetime in data frames ------------------------------------------------

library(nycflights13)
glimpse(flights)

flights |>
  mutate(
    # make_datetime() assembles
    departure = make_datetime(year, month, day, hour, minute),
    # Extract the day of week component from departure
    dep_wday = wday(departure, label = TRUE)
  ) |>
  select(departure, dep_wday) # Integers
