setwd('./scripts/')

library(dplyr)
library(ggplot2)

sourceCC <- readRDS('../data/Source_Classification_Code.rds')
pmdf <- readRDS('../data/summarySCC_PM25.rds')

#Question 5
condition2 <- grepl(pattern='.*[ehicle]{6}[s$]', sourceCC$EI.Sector)
vehicles_comb <- subset(sourceCC, condition2)
both <- intersect(pmdf$SCC, vehicles_comb$SCC)
vehicles_pmdf <- subset(pmdf, SCC %in% both)

#for baltimore
balt_veh <- vehicles_pmdf %>% filter(fips=='24510') %>% 
    group_by(year) %>% summarize(totalEmissions = sum(Emissions))

ggplot(balt_veh, aes(year, totalEmissions)) + geom_point() + geom_line() +
    ylab('Total Emissions in Baltimore City from motor vehicles') +
    xlab('Year') +
    ggtitle('Total Emissions from motor vehicles in Baltimore City')

#save plot
dev.copy(device = png, filename = 'plot5.png')
dev.off ()