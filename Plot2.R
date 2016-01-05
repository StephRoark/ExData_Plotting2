#Plot2.R

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

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
#plot answering this question.

#Subset the NEI data for emmisions for (fips == "24510") from 1999 to 2008
NEI_subset_Baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year) %>%
    summarise(total.pri.emmissions=sum(Emissions))

#Create a plot showing PM2.5 emissions in Baltimore from 1999 to 2008 and write to png
png(filename = "Plot2.png")
barplot(NEI_subset_Baltimore$total.pri.emmissions, names.arg=NEI_subset_Baltimore$year, 
        main = "PM2.5 Emission Changes in Baltimore, MD from 1999 to 2008", xlab="Year", 
        ylab = "Emissions", col = "red")
dev.off()