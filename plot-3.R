#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")
library(plyr)
NEI = rename(NEI, c("year"="Year"))  #capitalize attribute name
baltimore = subset(NEI,fips=='24510')
library(sqldf)
plot_3 = sqldf('select type, Year, sum(Emissions)as Total_Emissions from baltimore group by type,Year')
library(ggplot2)
ggplot(data=plot_3, aes(x=Year, y=Total_Emissions, group=type, color=type)) + geom_line() + geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (tons)") + ggtitle("Baltimore Total emissions from PM2.5 by Type and Year")
dev.copy(png, file = "plot-3.png" ,width = 480, height = 480)  ## Copy my plot to a plot1.PNG file
dev.off()
