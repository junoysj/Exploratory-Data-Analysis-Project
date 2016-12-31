#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")
library(plyr)
NEI = rename(NEI, c("year"="Year"))  #capitalize attribute name
baltimore = subset(NEI,fips=='24510')
#subset the motor vehicles, which I assume is anything like Motor Vehicle in SCC.Level.Two
SCC.motor_vehicles = SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),]
merge_data = merge(x=baltimore, y=SCC.motor_vehicles, by='SCC')
plot_5 = aggregate(Emissions ~ Year, merge_data, sum)

library(ggplot2)
ggplot(plot_5,aes(x = factor(Year), y = Emissions)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="Year", y=expression('Emissions (tons)')) + 
    labs(title='Motor Vehicle PM2.5 Emissions in Baltimore')
ggsave(file="plot_5.png")
