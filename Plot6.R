#Plot6.R

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

#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

NEI_SCC_Vehicles_City <- filter(NEI_SCC, grepl("On-Road", EI.Sector) & 
                               grepl("24510|06037", fips)) %>%
                               group_by(fips, year) %>%
                     summarize(Emissions=sum(Emissions))

CityLabels <- list("24510" = "Baltimore", "06037" = "Los Angeles")
city_labeller <- function(variable, value){
    return( CityLabels[value] )
}

ggplot(NEI_SCC_Vehicles_City, aes(year, Emissions))+
    geom_bar(stat = "identity") +
    scale_x_continuous(breaks=NEI_SCC_Vehicles_City$year) +
    facet_grid(fips ~ ., labeller = city_labeller) +
    ggtitle("Motor Vehicle Emissions by City from 1999 to 2008") +
    xlab("Year") +
    ylab("Motor Vehicle Emissions") +
    theme_classic()

ggsave("Plot6.png", width = 5, height = 5)

