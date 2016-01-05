#Plot3.R

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

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999–2008 
#for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

NEI_subset_Baltimore_type <- NEI %>% filter(fips == "24510") %>% group_by(type, year) %>%
    summarise(total.pri.emmissions=sum(Emissions))

#Create a plot showing decreasing or increasing emmisions by type and by year for Balitmore, MD

ggplot(NEI_subset_Baltimore_type, aes(year, total.pri.emmissions)) +
    geom_bar(stat = "identity") +
    scale_x_continuous(breaks=NEI_subset_Baltimore_type$year) +
    facet_grid(type ~ .) +
    ggtitle("PM2.5 Source Emissions for Baltimore 1999 to 2008") +
    xlab("Year") +
    ylab("Total Annual Emissions") +
    theme_classic()

ggsave("Plot3.png", width = 5, height = 5)
