#6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in
#Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")
library(plyr)
NEI = rename(NEI, c("year"="Year"))  #capitalize attribute name
#subset the motor vehicles, which I assume is anything like Motor Vehicle in SCC.Level.Two
SCC.motor_vehicles = SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),]
#Baltimore City
baltimore = subset(NEI,fips=='24510')
merge_baltimore = merge(x=baltimore, y=SCC.motor_vehicles, by='SCC')
baltimore_sum = aggregate(Emissions ~ Year, merge_baltimore, sum)
baltimore_sum$City = "Baltimore City"

#Los Angeles County
la = subset(NEI,fips=='06037')
merge_la = merge(x=la, y=SCC.motor_vehicles, by='SCC')
la_sum = aggregate(Emissions ~ Year, merge_la, sum)
la_sum$City = "Los Angeles County"

combine = rbind(baltimore_sum, la_sum)

library(ggplot2)
ggplot(combine, aes(x=factor(Year), y=Emissions, fill=City)) +
    geom_bar(aes(fill=Year),stat="identity") +
    facet_grid(scales="free", space="free", .~City) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="Year", y="Emissions (tons)") + 
    labs(title=expression("Motor Vehicle PM2.5 Emissions in Baltimore & LA"))
ggsave(file="plot_6.png")
