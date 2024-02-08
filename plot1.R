## read data
file_name <- 'data/household_power_consumption.txt'
data_class <- c('character','character',rep('numeric',7))
power <- read.table(file_name,header=TRUE,sep=';',na.strings='?',colClasses=data_class)

# subset data for  Feb 1 and Feb 2 only.
power_subs <- subset(power,Date %in% c("1/2/2007","2/2/2007")) 
power_subs$Date <- as.Date(power_subs$Date,"%d/%m/%Y")

#plot a histogram                     
with(power, 
     hist(power_subs$Global_active_power,col="red",
          main="Global Active Power",
          xlab="Global Active Power (kilowatts)",
          ylab="Frequency"
          )
     )

dev.copy(png,"plot1.png")
dev.off()