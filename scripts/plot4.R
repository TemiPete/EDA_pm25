setwd('./scripts/')

library(dplyr)
library(ggplot2)

sourceCC <- readRDS('../data/Source_Classification_Code.rds')
pmdf <- readRDS('../data/summarySCC_PM25.rds')

#Question 4
condition <- grepl(pattern='[^-][Cc][oa]{2}[l$]', sourceCC$EI.Sector)
coal_comb <- subset(sourceCC, condition)
both <- intersect(pmdf$SCC, coal_comb$SCC)
coal_pmdf <- subset(pmdf, SCC %in% both)

coal_changes <- coal_pmdf %>% 
    group_by(year) %>% summarize(total=sum(Emissions))

ggplot(coal_changes, aes(year, total)) + 
    geom_line() + geom_point() + ylab('Total Emissions from Coal Combustion') + 
    xlab('Year') + 
    ggtitle('Total Emissions from Coal Combustion by Year Across the United States')

#save plot
dev.copy(device = png, filename = 'plot4.png', width=500)
dev.off ()