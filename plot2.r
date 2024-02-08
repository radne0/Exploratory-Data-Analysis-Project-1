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

# Plot Global_active_power vs dt
with(power_feb,
     plot(Global_active_power ~ dt,
          type='l',
          xaxt="n",
          xlab="",
          ylab="Global Active Power (kilowatts)"
          )
     )
   
#Fix x-axis labels.
xax <- unique(round(power_feb$dt,"day"))
axis.POSIXct(1,at = xax, format = "%a")

#Save as png and close file device
dev.copy(png,"plot2.png")
dev.off()


