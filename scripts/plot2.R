setwd('./scripts/')

library(dplyr)
library(ggplot2)

sourceCC <- readRDS('../data/Source_Classification_Code.rds')
pmdf <- readRDS('../data/summarySCC_PM25.rds')

#Question 2
balt_total <- pmdf %>% filter(fips=='24510') %>% 
    group_by(year) %>% summarize(totalEmissions=sum(Emissions))

with(balt_total, plot(year, totalEmissions, type='b', pch=15, col='red',
                      ylab='Emissions in Baltimore City', xlab='Year'))
title(main='Change in Total emissions in Baltimore City by Year')

#save plot
dev.copy(device = png, filename = 'plot2.png')
dev.off ()

