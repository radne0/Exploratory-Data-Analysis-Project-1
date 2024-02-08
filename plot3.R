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
with(power_feb,lines(Sub_metering_3 ~ dt,col ="blue",))

#Fix x-axis labels.
xax <- unique(round(power_feb$dt,"day"))
axis.POSIXct(1,at = xax, format = "%a")


#Add a legend.
legend("topright",
       legend = colnames(power_feb[8:10]),
       col=c("black","red","blue"),lty=1)


#Save to png and close file device.
dev.copy(png,'plot3.png')
dev.off()

