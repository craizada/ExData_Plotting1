##Download and unzipping the data
if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
}
unzip("data.zip") # This creates the file "household_power_consumption.txt"
#Read the data in to R
data<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")
#Looking at the attributes of the datset
names(data)
lapply(data, class)
##Many of them are factor vaiables and we will change them to numeric when we are working with them.
##Let's see the first few values of Date and Time
data$Date[1:10]
data$Time[1:10]
#Let's use strptime to change the factor Date and Time values in to yyyy-mm-dd hh:mm:ss. First, let's create a variables by concatenating Date and Time.
data$DateTime<-paste(data$Date, data$Time)
#Let's see the help document of strptime
?strptime
#Then, let's chnage DateTime to yyyy-mm-dd hh:mm:ss
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
#Let's work with the data for dates 2007-02-01 and 2007-02-02
start<-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))

end<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

data2<-data[start:end,]
#Now, we can plot some of the observations outputting to a png file.
png(filename="Plot2.png", width=480, height=480)
plot(data2$DateTime, as.numeric(as.character(data2$Sub_metering_1)),type='l', 
     ylab ="Energy sub metering", xlab="")
lines(data2$DateTime, as.numeric(as.character(data2$Sub_metering_2)),type='l', col='red')
lines(data2$DateTime, data2$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1)
       ,col=c("black","red","blue"))

dev.off()
