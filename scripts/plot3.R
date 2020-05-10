setwd('./scripts/')

library(dplyr)
library(ggplot2)

sourceCC <- readRDS('../data/Source_Classification_Code.rds')
pmdf <- readRDS('../data/summarySCC_PM25.rds')

#Question 3
balt_df <- pmdf %>% filter(fips=='24510') %>% group_by(type, year) %>%
    summarize(sumEmissions = sum(Emissions))

ggplot(balt_df, aes(year, sumEmissions, col=type)) + geom_point() + 
    geom_line() + scale_y_log10() + ylab('Total Emissions') + xlab('Year') +
    ggtitle('Total Emissions in Baltimore City between 1999 and 2008 by Type')

#save plot
dev.copy(device = png, filename = 'plot3.png')
dev.off ()