tester<- get_forecast_for(complete[1,2], complete[1,3], complete[1,5], units="si")
hourlytest <- (tester$hourly)
hourlytemp <- as.data.frame(hourlytest$apparentTemperature)
colnames(hourlytemp) <- c("Temperature")

TempHourly <- as.data.frame(cbind(hourlytemp, weatherUnixtime))
colnames(TempHourly) <- c("Temperature", "Time")

subset (TempSecond, UnixTime > 1384260795)

##trying to get the Temperature column to 'join' to the complete data frame
allSecondData <- merge(complete, TempFromStart, by = "UnixTime", all.x = TRUE)
TempFromStart.loc[TempFromStart['UnixTime'] == 1384260795]
TempSecond[TempSecond$UnixTime == 1384260795]