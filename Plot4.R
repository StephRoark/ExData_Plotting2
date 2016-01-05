#Plot4.R

require(dplyr)
require(ggplot2)

#Unzip the file containing the data for the National Emissions Inventory (NEI)
unzip ("exdata-data-NEI_data.zip", exdir = "./")

#Read in the file containing a data frame with all of the PM2.5 emissions data for 
#1999, 2002, 2005, and 2008. For each year, the table contains number of tons of 
#PM2.5 emitted from a specific type of source for the entire year.
NEI <- readRDS("summarySCC_PM25.rds")

#Read in the table which provides a mapping from the SCC digit strings in the 
#Emissions table to the actual name of the PM2.5 source.
SCC <- readRDS("Source_Classification_Code.rds")

#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008?

NEI_SCC <- inner_join(NEI, SCC, by= "SCC")
names(NEI_SCC)

unique(NEI_SCC$EI.Sector)
NEI_SCC_Coal <- filter(NEI_SCC, grepl("Fuel Comb", EI.Sector) & grepl("Coal", EI.Sector))

ggplot(NEI_SCC_Coal, aes(year, Emissions))+
       geom_bar(stat = "identity") +
       scale_x_continuous(breaks=NEI_subset_Baltimore_type$year) +
       ggtitle("Coal Emissions in the US from 1999 to 2008") +
           xlab("Year") +
           ylab("Coal Emissions") +
           theme_classic()

ggsave("Plot4.png", width = 5, height = 5)
