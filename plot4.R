library(sqldf) 


#background as white 
par(bg="white")

#2x2 grid for 4 plots 
par(mfrow=c(2,2))

#read file
data <- read.csv.sql("./household_power_consumption.txt",sql="select * from file where Date like '1/2/2007' or Date like '2/2/2007' ", header=TRUE,sep=";",eol="\n") 

#date and time conversion 
data$Date<- as.Date(data$Date,"%d/%m/%Y")
data1 <- within(data,{timestamp=strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")})
data1$timestamp <- as.POSIXct(data1$timestamp,format="%Y-%m-%d %H:%M:%S")

#final data set after melting for submetering 
reslt_1 <-  melt(data1, id =c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","timestamp"))

#plot1
with(data1,plot(timestamp,Global_active_power,typ="l",xlab="",ylab="Global Active Power (kilowatts)"))

#plot2
with(data1,plot(timestamp,Voltage,typ="l",xlab="datetime",ylab="Voltage"))


#plot3
plot(reslt_1$timestamp[reslt_1$variable=="Sub_metering_1"],reslt_1$value[reslt_1$variable=="Sub_metering_1"],type="l",col="black",xlab="",ylab="Energy sub metering")
lines(reslt_1$timestamp[reslt_1$variable=="Sub_metering_2"],reslt_1$value[reslt_1$variable=="Sub_metering_2"],type="l",col="red")
lines(reslt_1$timestamp[reslt_1$variable=="Sub_metering_3"],reslt_1$value[reslt_1$variable=="Sub_metering_3"],type="l",col="blue")

# Add plot3 legend 
legend('topright', legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
   lty=1, col=c('black', 'red', 'blue') )

#plot4 
with(data1,plot(timestamp,Global_reactive_power,typ="l",xlab="datetime",ylab="Global Reactive Power"))

#final plots 
dev.copy(png,file="plot4.png",bg = "white",units="px",width=480,height=480)
dev.off()

