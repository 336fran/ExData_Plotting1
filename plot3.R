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


# Plot 3
windows()
with(md, plot(t, Sub_metering_1, main = "",  type = "n",ylab = "Energy sub metering",xlab=""))
with(md, lines(t, Sub_metering_1, col = "black"))
with(md, lines(t, Sub_metering_2, col = "red"))
with(md, lines(t, Sub_metering_3, col = "blue"))
legend("topright", lty = 1,col = c("black","blue", "red"), legend = c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "))


# Save figure
dev.copy(png,file="./plot3.png",width = 480, height = 480, units="px") # saves it
dev.off() # close the device connection


