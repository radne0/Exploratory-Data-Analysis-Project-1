# read data
file_name <- 'data/household_power_consumption.txt'
data_class <- c('character','character',rep('numeric',7))
power <- read.table(file_name,header=TRUE,sep=';',na.strings='?',colClasses=data_class)

# subset data for  Feb 1 and Feb 2 only and convert result to a Date
power_feb <- subset(power,Date %in% c("1/2/2007","2/2/2007")) 

# Combine date and time and convert to a POSIXt
dt <- with(power_feb, paste(Date,Time))
dt <- strptime(dt, format = "%d/%m/%Y %H:%M:%S")
power_feb <- cbind(dt,power_feb)

#Get a "list" of the days for axis labels from the subset.
xax <- unique(round(power_feb$dt,"day"))  

# start a 2x2 plot
par(mfrow=c(2,2), mar=c(5,5,3,1))

# Plot Global Active Power vs time and apply axis settings.
with(power_feb,
     plot(Global_active_power ~ dt,
          type='l',
          xaxt='n', 
          xlab="",
          ylab="Global Active Power"))
axis.POSIXct(1,at = xax, format = "%a")

#Plot Voltage vs time
with(power_feb,plot(Voltage~dt,type='l',xlab="day of the week",xaxt="n"))
axis.POSIXct(1,at = xax, format = "%a")

# Plot sub_metering_1 through 3 over time.
with(power_feb,
     plot(Sub_metering_1 ~ dt,
          type="l",
          col ="black",
          xaxt="n",
          xlab="",
          ylab="Energy sub metering"
     )
)

with(power_feb,lines(Sub_metering_2 ~ dt,col ="red"))
with(power_feb,lines(Sub_metering_3 ~ dt,col ="blue"))
axis.POSIXct(1,at = xax, format = "%a")
legend("topright",
       legend = colnames(power_feb[8:10]),
       col=c("black","red","blue"),lty=1, 
       pt.cex=1, cex=0.8, bty="n")      # smaller font/etc  and no border
 

#Plot Global_Reactive_power over time..
with(power_feb,
     plot(Global_reactive_power~dt,
          type='l',
          xaxt="n",
          xlab="day of the week",
          ylab="Global Reactive Power"
          )
     )
axis.POSIXct(1,at = xax, format = "%a")

#Save file and close file device. 
dev.copy(png, 'plot4.png')
dev.off()
