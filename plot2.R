library(sqldf) 


par(bg="white")
data <- read.csv.sql("./household_power_consumption.txt",sql="select * from file where Date like '1/2/2007' or Date like '2/2/2007' ", header=TRUE,sep=";",eol="\n") 
data$Date<- as.Date(data$Date,"%d/%m/%Y")
data1 <- within(data,{timestamp=strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")})
data1$timestamp <- as.POSIXct(data1$timestamp,format="%Y-%m-%d %H:%M:%S")

with(data1,plot(timestamp,Global_active_power,typ="l",xlab="",ylab="Global Active Power (kilowatts)"))

dev.copy(png,file="plot2.png",bg = "white",units="px",width=480,height=480)
dev.off()

