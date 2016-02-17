#brings in test Route file from strava folder
testRfile <- read.table(
        "testfile.txt",
        sep="\t", header=TRUE,
        colClasses=c("NULL", NA, NA, NA, NA, "NULL", "NULL"))

#converts the time in the above file to unix time so it can be passed into the API call
unixtime <- as.numeric(as.POSIXct(testRfile$time))

#loads the required package for making the API call
library(Rforecastio)

#makes API call and creates a df from the results
tester<- get_forecast_for(50.37938, -4.135775, 1384260795, units="si")
hourlytest <- (tester$hourly)
print(hourlytest)

#converts the time in the weather file to unix time 
unixtimetester <-as.numeric(as.POSIXct(hourlytest$time))

#need to interpolate the apparentTemperature column minutely - trial
#takes the difference between 2 temperatures and creates a sequence of numbers from one
#to the other with that interval, thus producing minutely data. BOOM!
aT <- (hourlytest$apparentTemperature)
f <- ((aT[12]-aT[11])/59)
output <- seq(from = aT[11], to = aT[12], by = f)
output

#now do that for each hour of the day in a loop style - this creates a new column each time i think

        for (i in 1:23){
                g <- ((aT[i+1]-aT[i])/59)
                output <- seq(from = aT[i], to = aT[i+1], by = g)
        }
}
output


#time from the strava file is unixtime

#then just take the values that match the unix time in the strava file

