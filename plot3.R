library(sqldf) 

#set background 
par(bg="white")

#read file for specific dates 
data <- read.csv.sql("./household_power_consumption.txt",sql="select * from file where Date like '1/2/2007' or Date like '2/2/2007' ", header=TRUE,sep=";",eol="\n") 

#format as date 
data$Date<- as.Date(data$Date,"%d/%m/%Y")

#concate date and time 
data1 <- within(data,{timestamp=strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")})
data1$timestamp <- as.POSIXct(data1$timestamp,format="%Y-%m-%d %H:%M:%S")

#result after melting submetering and values 
reslt_1 <-  melt(data1, id =c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","timestamp"))

#plot the lines 
plot(reslt_1$timestamp[reslt_1$variable=="Sub_metering_1"],reslt_1$value[reslt_1$variable=="Sub_metering_1"],type="l",col="black",xlab="",ylab="Energy sub metering")
lines(reslt_1$timestamp[reslt_1$variable=="Sub_metering_2"],reslt_1$value[reslt_1$variable=="Sub_metering_2"],type="l",col="red")
lines(reslt_1$timestamp[reslt_1$variable=="Sub_metering_3"],reslt_1$value[reslt_1$variable=="Sub_metering_3"],type="l",col="blue")

# Add legend 
legend('topright', legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
   lty=1, col=c('black', 'red', 'blue') )

dev.copy(png,file="plot3.png",bg = "white",units="px",width=480,height=480)
dev.off()

