#Plot1.R

require(dplyr)

#Unzip the file containing the data for the National Emissions Inventory (NEI)
unzip ("exdata-data-NEI_data.zip", exdir = "./")

#Read in the file containing a data frame with all of the PM2.5 emissions data for 
#1999, 2002, 2005, and 2008. For each year, the table contains number of tons of 
#PM2.5 emitted from a specific type of source for the entire year.
NEI <- readRDS("summarySCC_PM25.rds")

#Read in the table which provides a mapping from the SCC digit strings in the 
#Emissions table to the actual name of the PM2.5 source.
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

#Subset the NEI data by year and sum the emissions for those years
NEI_subset_year <- NEI %>% filter(year %in% c(1999, 2002, 2005, 2008)) %>%
        group_by(year) %>%
        summarize(total.pri.emmissions=sum(Emissions))

#Create barplot and write to a png file
png(filename = "Plot1.png")
barplot(NEI_subset_year$total.pri.emmissions, names.arg=NEI_subset_year$year, 
        main = "PM2.5 Emission Changes in the US from 1999 to 2008", xlab="Year", 
        ylab = "Emissions", col = c("red"))
dev.off()
