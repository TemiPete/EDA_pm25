setwd('./scripts/')

library(dplyr)
library(ggplot2)

sourceCC <- readRDS('../data/Source_Classification_Code.rds')
pmdf <- readRDS('../data/summarySCC_PM25.rds')

#Question 6
condition2 <- grepl(pattern='.*[ehicle]{6}[s$]', sourceCC$EI.Sector)
vehicles_comb <- subset(sourceCC, condition2)
both <- intersect(pmdf$SCC, vehicles_comb$SCC)
vehicles_pmdf <- subset(pmdf, SCC %in% both)

#for baltimore
balt_veh <- vehicles_pmdf %>% filter(fips=='24510') %>% 
    group_by(year) %>% summarize(totalEmissions = sum(Emissions))

#for LA or cali (same, I guess)
cali_veh <- vehicles_pmdf %>% filter(fips=='06037') %>%
    group_by(year) %>% summarize(totalEmissions=sum(Emissions))

LA_regions <- as.data.frame(rep('Los Angeles County', nrow(cali_veh)))
cali_veh <- cbind(cali_veh, LA_regions)
names(cali_veh)[3] <- 'region'

balt_regions <- as.data.frame(rep('Baltimore City', nrow(balt_veh)))
balt_veh <- cbind(balt_veh, balt_regions)
names(balt_veh)[3] <- 'region'

veh_balt_cali <- rbind(cali_veh, balt_veh)

ggplot(veh_balt_cali, aes(factor(year), totalEmissions, fill=region)) + 
    geom_bar(stat='identity', position = 'dodge') + 
    xlab('Year') + ylab('Total Emissions') +
    ggtitle('Total Emissions in Los Angeles City vs Baltimore City Between 1999 and 2008')

#save plot
dev.copy(device = png, filename = 'plot6.png', width=600)
dev.off ()