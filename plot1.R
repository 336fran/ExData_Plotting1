library(data.table)
library(lubridate)


# read file as a data.table using "fread". from 2007-02-01 and 2007-02-02
fname<-"./data/household_power_consumption.txt"
md<-fread(fname, header = FALSE, na.strings="?", check.names=TRUE,
          skip="1/2/2007", nrows=24*60*2 )
dnames<-fread(fname, header = TRUE, na.strings="?", check.names=TRUE,
              nrows=1 )
names(md)<-names(dnames)


# Time. current format: dd/mm/yyyy hh:mm:ss
md[,t:=dmy_hms(paste(Date,Time))]
Sys.setlocale(category = "LC_ALL", locale = "english")


# Plot 1
windows()
with(md,hist(Global_active_power, col = "red",
             main = "Global Active Power",xlab = "Global Active Power (kilowatts)"))


# Save figure
dev.copy(png,file="./plot1.png",width = 480, height = 480, units="px") # saves it
dev.off() # close the device connection

