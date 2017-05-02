library(sqldf) 

data <- read.csv.sql("./household_power_consumption.txt",sql="select  * from file where Date like '1/2/2007' or Date like '2/2/2007' ", header=TRUE,sep=";",eol="\n") 
par(bg="white")
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.copy(png,file="plot1.png",bg = "white",units="px",width=480,height=480)
dev.off()

