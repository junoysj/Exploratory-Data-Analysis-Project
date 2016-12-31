#4.Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999-2008?
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")
library(plyr)
NEI = rename(NEI, c("year"="Year"))  #capitalize attribute name

SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]
#merge two data sets
merge = merge(x=NEI, y=SCC.coal, by='SCC')
plot_4 = aggregate(Emissions ~ Year, merge, sum)
plot_4$Emissions = round(plot_4$Emissions/1000,2)
library(ggplot2)
ggplot(plot_4,aes(x = factor(Year), y = Emissions)) + 
    geom_bar(stat="identity",fill="grey",width=0.75) + 
    theme_bw() +  guides(fill=FALSE) +
    xlab("Year") + ylab("Emissions (thousands of tons)") + 
    labs(title="US Total PM2.5 Coal Emissions")
ggsave(file="plot_4.png")
