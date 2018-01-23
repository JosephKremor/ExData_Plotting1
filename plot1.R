library(data.table)


# Load the Data # 
Data = as.data.table(read.csv2('household_power_consumption.txt'))

# Clean the Dates# 
Data = Data[,lapply(.SD,as.character),.SDcols = colnames(Data)]
Data = Data[,datetime := paste(Date,' ',Time)]
Data = Data[,c('Date','Time'):=NULL]
Data = Data[,datetime:=as.POSIXct(datetime,format="%d/%m/%Y %H:%M:%S")]

# Subset the dates# 
Data = Data[datetime <'2007-02-03 00:00:00' & datetime >'2007-01-31 23:59:59']

# Set columns to numeric# 
Data = Data[,Global_active_power:=as.numeric(Global_active_power)]
Data = Data[,Global_reactive_power:=as.numeric(Global_reactive_power)]
Data = Data[,Voltage:=as.numeric(Voltage)]
Data = Data[,Global_intensity:=as.numeric(Global_intensity)]
Data = Data[,Sub_metering_1:=as.numeric(Sub_metering_1)]
Data = Data[,Sub_metering_2:=as.numeric(Sub_metering_2)]
Data = Data[,Sub_metering_3:=as.numeric(Sub_metering_3)]

# plotting# 
# plot 1# 
png('plot1.png',height = 480,width = 480,units = 'px')
hist(Data$Global_active_power,col = 'red',main = 'Global Active Power',xlab = 'Global Active Power (kilowatts)')
dev.off()
