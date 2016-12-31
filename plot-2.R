#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 
#to 2008? Use the base plotting system to make a plot answering this question.
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")
library(plyr)
NEI = rename(NEI, c("year"="Year"))  #capitalize attribute name
baltimore = subset(NEI,fips=='24510')
plot_2 = aggregate(Emissions ~ Year, baltimore, sum)
plot_2$Emissions = round(plot_2$Emissions/1000,2)
barplot(plot_2$Emissions,names.arg= plot_2$Year, main='Baltimore Total emissions from PM2.5',xlab='Years',ylab='Emissions of PM2.5 in kilotons')
dev.copy(png, file = "plot2.png" ,w--idth = 480, height = 480)  ## Copy m)
