
setwd('./scripts/')

library(dplyr)
library(ggplot2)

sourceCC <- readRDS('../data/Source_Classification_Code.rds')
pmdf <- readRDS('../data/summarySCC_PM25.rds')

#Question 1
total_pm <- pmdf %>% group_by(year) %>% 
    summarize(totalEmissions=sum(Emissions))

with(total_pm, plot(year, totalEmissions, type='b', 
                    pch=19, col='red', ylab='Total Emissions', xlab='Year'))
title(main='Total emissions by year')

#save plot
dev.copy(device = png, filename = 'plot1.png')
dev.off ()