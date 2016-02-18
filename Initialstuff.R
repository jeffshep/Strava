#loads the required package for making the API call
library(Rforecastio)
now <- get_forecast_for(50.727238, -3.474641, 1455725458)
#insert API key for Dark Sky

time <- as.numeric(Sys.time())
