# Quandl ----


## Installation ----

# The `Quandl` R package is available on:
# - CRAN: https://cran.r-project.org/package=Quandl
# - GitHub: https://github.com/quandl/quandl-r

# Call
# install.packages("Quandl")
library(Quandl)


## Authentication -----

# The `Quandl` R package is free.
# If you would like to make more than 50 calls a day,
# however, you need to create a free account and set
# your API key.

# Create or sign in to your account here:
# https://data.nasdaq.com/account/api

# Then call top open your `.Renviron` file 
# usethis::edit_r_environ()
# and store your API key as "QUANDL_API_KEY"
# Restart your R session and see if R recognizes your key
Sys.getenv("QUANDL_API_KEY")

# Set your API key in the console with
# Quandl.api_key(api_key = Sys.getenv("QUANDL_API_KEY"))


## Formats and types ----

### Return types -----

# The supported return types for the `Quandl::Quandl()` function are
# - raw (returns a data frame)
# - `stats::ts()`
# - `zoo::zoo()`
# - `xts::xts()`
# - `timeSeries::timeSereis()`

# To request a specific type, assign the `type` argument.
nse_oil_xts <- Quandl(code = "NSE/OIL", type = "xts", collapse = "quarterly", limit = 3)
print(nse_oil_xts)
time(nse_oil_xts)
class(time(nse_oil_xts))
# "yearqtr"


nse_oil_zoo <- Quandl(code = "NSE/OIL", collapse = "quarterly", type = "zoo", limit = 3)
print(nse_oil_zoo)
time(nse_oil_zoo)
class(time(nse_oil_zoo))
# "yearqtr"

nse_oil_ts <- Quandl(code = "NSE/OIL", type = "ts", collapse = "quarterly", limit = 3)
print(nse_oil_ts)
time(nse_oil_ts)
class(time(nse_oil_ts))
# "ts"

# Note the `ts` class does not support daily frequency.
# Use the `zoo` or `xts` class in that case.


# Be aware tha the time series objects `zoo` and `xts` return a special
# "yearqtr" class for the `time()` method.


## Time series ----

### Make a time series call -----

# Access US GDP, which has the code "FRED/GDP",
# since it comes from the FRED API.
fred_gdp <- Quandl(code = "FRED/GDP", type = "raw")
head(fred_gdp)
class(fred_gdp)

fred_gdp_ts <- Quandl(code = "FRED/GDP", type = "ts")
fred_gdp_xts <- Quandl(code = "FRED/GDP", type = "xts")
fred_gdp_zoo <- Quandl(code = "FRED/GDP", type = "zoo")


### Make a filtered time-series call ----

fred_gdp_filtered <- Quandl(code = "FRED/GDP", start_date = "2001-12-31", end_date = "2005-12-31")

head(fred_gdp_filtered)

# You can also request a specific column,
# like the first column from the FRED GDP dataset:
fred_gdp_column <- Quandl(code = c("FRED/GDP.1"))
head(fred_gdp_column)


### Make a multiple time series call ----

# Delimit the codes with a comma (`,`) and concatenate them
# into a character vector with `c()` like
# merged_data <- Quandl(code = c("EXMPL/DATA1.1", "EXMPL/DATA2.2"))


### Download an entire time series data set ----

# This feature is not available for all data products. 

# Download the data set "ZEA"
# Quandl.database.bulk_download_to_file(database_code = "ZEA", filename = "./ZEA.zip")


## CRAN examples ----

# Some examples are listed on the CRAN README file
# https://cran.r-project.org/web/packages/NasdaqDataLink/readme/README.html


### Graphing data ----

# Create a graph of Google's performance month over month
wiki_goog_ts <- Quandl(code = "WIKI/GOOG", type = "ts", collapse = "monthly")

colnames(wiki_goog_ts)[11]
# "Adj. Close"

# Plot the adjusted closing price, the 11-th variable
# Use the function `stats::stl()` to seasonally
# decompose the time series with LOESS.

# The argument `s.window` is either the character string
# "periodic" or the loess window for seasonal extraction,
# which should be odd and at least 7.
# `stats::stl()` returns a multiple time series object
# of class `stl` with the components "seasonal", "trend",
# and "remainder"

google_stl <- stl(wiki_goog_ts[, "Adj. Close"], s.window = "periodic")
head(google_stl)
class(google_stl)
# "stl"

class(google_stl$time.series)
# "mts" "ts" "matrix" "array"


# A `pot()` method exists for the `stl` class
plot(google_stl, main = "Seasonal adjustment of Google Stock Price with STL")
png(filename = "figures/01_google-stl.png", height = 800, width = 800)
dev.off()


# The supported return times are objects of the R classes:
# - `base::data.frame()`
# - `stats::ts()`
# - `zoo::zoo()` 
# - `xts::xts()`

# Note that `stats::ts()` does not support a frequency of 365,
# so you have to use `zoo` or `xts` objects for daily data.

# Note that `zoo` and `xts` have their own date formats
# that are returned by the method for `stats::time()`
# for these classes.
nse_oil_zoo <- Quandl(code = "NSE/OIL", type = "zoo", collapse = "weekly", limit = 3)
head(nse_oil_zoo)
time(nse_oil_zoo)
class(time(nse_oil_zoo))
# `frequency = "monthly/quarterly"` will return the date
# classes "yearmon/yearqtr".
# Weekly and daily dates will be of class "Date"
# and annual frequency will be of class "numeric".

# You can force the time series index to be displayed
# as a "Date" no matter the frequency with the
# parameter `force_irregular = TRUE`
nse_oil_zoo <- Quandl(code = "NSE/OIL", type = "zoo", collapse = "quarterly", limit = 3, force_irregular = TRUE)
head(nse_oil_zoo)
# The dates are in ISO format YYYY-MM-DD

# You can merge data sets like by adding their codes 
# in a character vector, like the stock prices for
# Apple and Meta
merged_data <- Quandl(code = c('WIKI/AAPL', 'WIKI/META'), type = "ts", collapse = "monthly")

head(merged_data)
class(merged_data)
# "mts" "ts" "matrix" "array"


# Search for Oil on the National Stock Exchange of India (NSE):
Quandl.search(query = "Oil", database_code = "NSE", per_page = 3)

# END