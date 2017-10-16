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

# Plot 2
windows()
with(md,plot(t,Global_active_power,type="l",xaxt="n",
             xlab="",ylab = "Global Active Power (kilowatts)"))
axis.POSIXct(1, x=md$t,at=seq(md$t[1],last(md$t)+days(1),by="day"), format="%a")


# Save figure
dev.copy(png,file="./plot2.png",width = 480, height = 480, units="px") # saves it
dev.off() # close the device connection

