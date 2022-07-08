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
