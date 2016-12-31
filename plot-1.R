#1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")
library(plyr)
NEI = rename(NEI, c("year"="Year"))  #capitalize attribute name
plot_1 = aggregate(Emissions ~ Year, NEI, sum)
plot_1$Emissions = round(plot_1$Emissions/1000,2)
#plot method 1(barplot)
barplot(plot_1$Emissions,names.arg= plot_1$Year, main='US Total emissions from PM2.5',xlab='Years',ylab='Emissions of PM2.5 in kilotons')
#plot method 2
#plot(plot_1$Year,plot_1$Emissions, main="Total US PM2.5 Emissions", "b", xlab="Year", ylab="Emissions (thousands of tons)",xaxt="n")
#axis(side=1, at=c("1999", "2002", "2005", "2008"))

dev.copy(png, file = "plot-1.png" ,width = 480, height = 480)  ## Copy my plot to a plot1.PNG file
dev.off()

