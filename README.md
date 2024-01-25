# Quandl

The Quandl R package is an API wrapper around the [NASDAQ Data Link Quandl API](https://data.nasdaq.com/publishers/QDL).

The R package is available on [CRAN](https://cran.r-project.org/package=Quandl) and [GitHub](https://github.com/quandl/quandl-r).

Find the API Documentation online at [https://docs.data.nasdaq.com/](https://docs.data.nasdaq.com/).

The current [Rate Limits](https://docs.data.nasdaq.com/docs/rate-limits) specify a limit of no more than 20 calls per 10 minutes and 50 calls a day for anonymous users.

Users who do not subscribe to any premium data but append their API key to their API call have a limit of 300 calls per 10 seconds, 2,000 calls per 10 minutes, and 50,000 calls per day. 

Authenticated users have a concurrency limit of one, that is, they can make one call at a time and have an additional call in the queue.

Find your personal API on your account page: [https://data.nasdaq.com/account/api](https://data.nasdaq.com/account/api).

Search for the freely available data sets at [https://data.nasdaq.com/search?filters=%5B%22Free%22%5D](https://data.nasdaq.com/search?filters=%5B%22Free%22%5D).

All available tools to connect to the API are listed under [https://data.nasdaq.com/tools/full-list](https://data.nasdaq.com/tools/full-list).

Note that the Quandl R package differentiates between arguments that are specific to the R function and Nasdaq Data Link API query parameters that enter the R function as additional arguments. Click [here](https://docs.data.nasdaq.com/docs/time-series) for a full list of query parameter options.


## Citation

Raymond McTaggart, Gergely Daroczi,
Clement Leung (2021). _Quandl: API Wrapper
for Quandl.com_. R package version 2.11.0,
<https://CRAN.R-project.org/package=Quandl>.