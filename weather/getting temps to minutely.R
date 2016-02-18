#brings in test Route file from strava folder
testRfile <- read.table(
        "testfile.txt",
        sep="\t", header=TRUE,
        colClasses=c("NULL", NA, NA, NA, NA, "NULL", "NULL"))

#converts the time in the above file to unix time so it can be passed into the API call
stravaUnixtimeInitial <- as.numeric(as.POSIXct(testRfile$time))
complete <- as.data.frame(cbind(testRfile, stravaUnixtimeInitial))
colnames (complete) <- c("time", "latitude", "longitude", "altitude", "UnixTime")


#loads the required package for making the API call
library(Rforecastio)

#makes API call and creates a df from the results
#takes latitude from testRfile and also longitude
#Unix time that relates to stravaUxixtime
#Put this in a loop that getting forecast data every minute from the start time
tester<- get_forecast_for(complete[1,2], complete[1,3], complete[1,5], units="si")
hourlytest <- (tester$hourly)

#converts the time in the weather file to unix time
#breaks down the hourly time into minutely time for the defined time period
#output saved in weatherTimeSecond
weatherUnixtime <- as.data.frame(as.numeric(as.POSIXct(hourlytest$time)))
h <- ((weatherUnixtime[14,]-weatherUnixtime[13,])/3599)
weatherTimeSecond <- as.data.frame(seq(from = weatherUnixtime[13,], to = weatherUnixtime[14,], by = h ))

#need to interpolate the apparentTemperature column minutely - trial
#takes the difference between 2 temperatures and creates a sequence of numbers from one
#to the other with that interval, thus producing minutely data. BOOM!
aT <- (hourlytest$apparentTemperature)
f <- ((aT[14]-aT[13])/3599)
output <- seq(from = aT[13], to = aT[14], by = f)
TempSecond <- as.data.frame(cbind(as.data.frame(output), weatherTimeSecond))
colnames(TempSecond) <- c("Temperature", "UnixTime")

#get this into 'complete'
allSecondData <- merge(complete, TempSecond, by = "UnixTime", all.x = TRUE)

#now do that for each hour of the day in a loop style - this creates a new column each time i think


#time from the strava file is unixtime

#then just take the values that match the unix time in the strava file

