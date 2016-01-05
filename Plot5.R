#Plot5.R

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

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

NEI_SCC_Vehicles <- filter(NEI_SCC, grepl("On-Road", EI.Sector) & grepl("24510", fips))

ggplot(NEI_SCC_Vehicles, aes(year, Emissions))+
    geom_bar(stat = "identity") +
    scale_x_continuous(breaks=NEI_SCC_Vehicles$year) +
    ggtitle("Motor Vehicle Emissions in Baltimore from 1999 to 2008") +
    xlab("Year") +
    ylab("Motor Vehicle Emissions") +
    theme_classic()

ggsave("Plot5.png", width = 5, height = 5)
