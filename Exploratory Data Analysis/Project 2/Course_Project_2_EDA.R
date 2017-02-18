# cleaning environment
rm(list=ls())
# setting wd
setwd("C:/Users/Marcelo/Desktop/Coursera/data")

# Loading libraries
library(data.table)
library(dplyr)
library(ggplot2)

# Reading files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# NEI file
# fips: A five-digit number (represented as a string) indicating the U.S. county
# SCC: The name of the source as indicated by a digit string (see source code classification table)
# Pollutant: A string indicating the pollutant
# Emissions: Amount of PM2.5 emitted, in tons
# type: The type of source (point, non-point, on-road, or non-road)
# year: The year of emissions recorded

dim(NEI)
str(NEI)
head(NEI)
summary(NEI)

dim(SCC)
str(SCC)
head(SCC)
summary(SCC)

# Assignment
# The overall goal of this assignment is to explore the National
# Emissions Inventory database and see what it say about fine
# particulate matter pollution in the United states over the
# 10-year period 1999-2008. You may use any R package you
# want to support your analysis.

# 1. Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system,
# make a plot showing the total PM2.5 emission from all 
# sources for each of the years 1999, 2002, 2005, and 2008.

# extracting the sum of Emissions from all sources per year

pm25_byyear <- with(NEI, tapply(Emissions, year, sum))
str(pm25_byyear)
summary(pm25_byyear)

# plotting using bar plot
png('Plot1.png')
barplot(pm25_byyear/1000, xlab = "Year", ylab = "total PM 2.5 emissions / ktons",
        main = " Emissions from all sources by year in kilotons")

dev.off()

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
# system to make a plot answering this question.

# extracting the Total Emissions for Baltimore City, Maryland
pm25_Maryland <- subset(NEI, fips == "24510")
pm25_Maryland_by_year <- with(pm25_Maryland, (tapply(Emissions, year, sum)))
str(pm25_Maryland_by_year)
summary(pm25_Maryland_by_year)

# plotting using bar plot
png('Plot2.png')
barplot(pm25_Maryland_by_year, xlab = "Year", ylab = "Total PM 2.5 emissions in Maryland",
        main = "Total Emissions for Baltimore City by year",
        ylim = c(0,4000), col = "red")

dev.off()

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question. 

# extracting the Total Emissions for Baltimore City, Maryland
pm25_Maryland <- subset(NEI, fips == "24510")

# aggregating by year and type
pm25_Maryland_type_year <- aggregate(data = pm25_Maryland, Emissions ~ year + type, sum)

str(pm25_Maryland_type_year)
summary(pm25_Maryland_type_year)

# Line plot 3a
png("plot3a.png", width=640, height=480)
ggplot(pm25_Maryland_type_year, aes(year, y = Emissions, color = type))+
       geom_line() +
        xlab("Year") +
        ylab(" Total Emissions") +
        ggtitle("Pm 2.5 emissions in Baltimore City by sources")
dev.off()

# Bar plot 3b
png("plot3b.png", width=640, height=480)
ggplot(pm25_Maryland_type_year, aes(x = factor(year), y = Emissions,
                                    fill = type, label = round(Emissions,2)))+
        geom_bar(stat = "identity")+
        facet_grid(. ~ type) +
        xlab("Year")+
        ylab("Total PM 2.5 Emissions")+
        ggtitle("Pm 2.5 emissions in Baltimore City by sources")+
        geom_label(aes(fill = type), colour = "white", fontface = "bold")
dev.off()

# 4. Across the United States, how have emissions from coal combustion-related
# sources changed from 1999-2008? 

# merging the datasets
full_data <- merge(NEI, SCC, by = "SCC")

coal_data <- grepl("Fuel Comb.*Coal", full_data$EI.Sector)

coal_emissions <- full_data[coal_data,]

# Aggregating by year
coal_emissions_by_year <- aggregate(data = coal_emissions, Emissions ~ year, sum)

str(coal_emissions_by_year)

# Plot bar data using ggplot Emissions x year
png("plot4.png", width=640, height=480)
ggplot(coal_emissions_by_year, aes(x = factor(year), y = Emissions/1000,
                                   fill = year, label = round(Emissions,2)))+
        geom_bar(stat = "identity")+
        xlab("Year")+
        ylab("Total Coal Emissions")+
        ggtitle(" Emissions from Coal Sources in the US")+
        geom_label(aes(fill = year), colour = "white", fontface = "bold")
        
dev.off()

# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# extracting vehicle sources for Baltimore

vehicle_Baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")

# Aggregating by year
vehicle_Baltimore_by_year <- aggregate(data = vehicle_Baltimore, Emissions ~ year, sum)

# Plot bar data using ggplot vehicle sources x year
png("Plot5.png", width=640, height=480)
ggplot(vehicle_Baltimore_by_year, aes(x = factor(year), y = Emissions,
                                   fill = year, label = round(Emissions,2)))+
        geom_bar(stat = "identity")+
        xlab("Year")+
        ylab("Total Emissions in Baltimore")+
        ggtitle("Total vehicle sources Emissions in Baltimore")+
        geom_label(aes(fill = year), colour = "white", fontface = "bold")

dev.off()

# 6.Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

vehicle_Los_Angeles <- subset(NEI, fips == "06037" & type == "ON-ROAD")
vehicle_Los_Angeles_by_year <- aggregate(data = vehicle_Los_Angeles, Emissions ~ year, sum)

vehicle_Baltimore_by_year$County <- "Baltimore City"
vehicle_Los_Angeles_by_year$County <- "Los Angeles"

both_cities_data <- rbind(vehicle_Baltimore_by_year,vehicle_Los_Angeles_by_year)

# Plot bar data using ggplot vehicle sources in Baltimore and LA x year
png("Plot6.png", width=640, height=480)
ggplot(both_cities_data, aes(x = factor(year), y = Emissions,
                                      fill = County, label = round(Emissions,2)))+
        geom_bar(stat = "identity")+
        facet_grid(County ~., scales = "free") +
        xlab("Year")+
        ylab("Total Emissions")+
        ggtitle("Total vehicle Emissions in Baltimore and Los Angeles")+
        geom_label(aes(fill = County), colour = "white", fontface = "bold")
dev.off()
