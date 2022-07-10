library(data.table)

input <- if (file.exists("flights14.csv")) {
  "flights14.csv"
} else {
  "https://raw.githubusercontent.com/Rdatatable/data.table/master/vignettes/flights14.csv"
}
flights <- fread(input)
flights

# get all flights with "JFK" as the origin airport and month of June:
flights[origin == "JFK" & month == 6L]

# Get the first two rows from flights:
flights[1:2]

# Sort flights first by column origin in ascending order, and then by dest in 
# descending order:
setorder(x = flights, origin, -dest)
flights

# select arr_delay column but return it as a vector:
flights[, arr_delay]

# select arr_delay column but return it as a data.table instead:
flights[, list(arr_delay)]
flights[, .(arr_delay)]

# select all columns from year to dep_delay and return a data.table:
flights[, year:dep_delay]

# select both arr_delay and dep_delay columns:
flights[, .(arr_delay, dep_delay)]

# Select both arr_delay and dep_delay columns and rename them to delay_arr 
# and delay_dep:
flights[, .(delay_arr = arr_delay, delay_dep = dep_delay)]

# How many trips have had total delay < 0?
flights[, sum((dep_delay + arr_delay) < 0)]

# Calculate the average arrival and departure delay for all flights with “JFK” 
# as the origin airport in the month of June.
flights[
  origin == "JFK" & month == 6L, 
  list(
    arr_av = mean(arr_delay), 
    dep_av = mean(dep_delay)
  )
]

# How many trips have been made in 2014 from “JFK” airport in the month of June?
flights[origin == "JFK" & month == 6L & year == 2014L, .N]

# But 2014 is the only year:
flights[, unique(year)]

# so we can just do:
flights[origin == "JFK" & month == 6L, .N]


# Select both arr_delay and dep_delay columns the data.frame way.
flights[, c("arr_delay", "dep_delay")]

# Select columns named in a variable using the .. prefix
select_cols <- c("arr_delay", "dep_delay")
flights[, ..select_cols]

# The `..` is analogous the unix terminal where it refers to one level up.
# Here it tells data.table to look one environment up

# Select columns named in a variable using with = FALSE
flights[, select_cols, with = FALSE]

# `with` is analogous to base R's `with()`

# We can also deselect columns using - or !:
flights[, -c("arr_delay", "dep_delay")]
flights[, !c("arr_delay", "dep_delay")]

# From v1.9.5+, we can also select by specifying start and end column names, 
# e.g., year:day to select the first three columns.
flights[, year:day]
flights[, -(year:day)]
flights[, day:year]

# How can we get the number of trips corresponding to each origin airport?
flights[, .N, by = "origin"]
flights[, .(no_of_trips = .N), by = "origin"]

# How can we calculate the number of trips for each origin airport for carrier 
# code "AA"?
flights[carrier == "AA", .N, by = origin]

# How can we get the total number of trips for each origin, dest pair for 
# carrier code "AA"?
