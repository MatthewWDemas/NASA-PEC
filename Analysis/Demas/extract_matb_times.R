install.packages("dplyr")
install.packages("tidyr")
library('dplyr')
library('tidyr')

MATB_Sc1 <- read.csv("~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/TreeSheets/MATB_Sc1.csv", header=FALSE, stringsAsFactors=FALSE)
matb_s2 <- read.csv("~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/TreeSheets/MATB_CONFIG_TEST.csv", header=FALSE, stringsAsFactors=FALSE)

tbl_df(matb_s2)
tbl_df(MATB_Sc1)

# tmp <- matb_s2 %>% select(V3, V4) %>% filter(V4 != 'sched' & V4 != '' & V4 != 'control') %>% distinct()
tmp <- MATB_Sc1 %>% select(V3, V4) %>% filter(V4 != 'sched' & V4 != '' & V4 != 'control') %>% distinct()
# tmp7 <- matb_s2 %>% select(V3, V4, V5, V6) %>% filter(V4 != 'sched' & V4 != '' & V4 != 'control') %>% distinct()
tmp7 <- MATB_Sc1 %>% select(V3, V4, V5, V6) %>% filter(V4 != 'sched' & V4 != '' & V4 != 'control') %>% distinct()

tmp2 <- tmp %>% separate(V3, c('h', 'm', 's'),sep=':') 
tmp2$h <- as.numeric(tmp2$h)
tmp2$m <- as.numeric(tmp2$m)
tmp2$s <- as.numeric(tmp2$s)

tmp3 <- tmp2 %>% mutate(StartTime = h*60*60 + m*60 + s)
tmp4 <- tmp3 %>% filter(V4 == 'comm activity="START"') %>% mutate(EndTime = StartTime + 20)
tmp4$V4 <- gsub(tmp4$V4, pattern = 'comm activity="START"', replacement = 'comm_own')

tmp5 <- tmp3 %>% filter(V4 == 'comm') %>% mutate(EndTime = StartTime)
tmp5$V4 <- gsub(tmp5$V4, pattern = 'comm', replacement = 'comm_other')



tmp7 <- tmp7 %>% separate(V3, c('h', 'm', 's'),sep=':') 

tmp7$h <- as.numeric(tmp7$h)
tmp7$m <- as.numeric(tmp7$m)
tmp7$s <- as.numeric(tmp7$s)
tmp8 <- tmp7 %>% mutate(StartTime = h*60*60 + m*60 + s)
tmp6 <- tmp8 %>% filter(V4 == 'resman')

getwd()
setwd('~/Box Sync/Nasa Flight Data/GitHub_General/SharedDataExport/') #matb_scenario2_comm.csv')

# write.csv(tmp4 %>% select(StartTime, EndTime, V4), 'matb_sc2_comm_own.csv')
# write.csv(tmp5 %>% select(StartTime, EndTime, V4), 'matb_sc2_comm_other.csv')
# write.csv(tmp6 %>% select(StartTime, V4, V5, V6), 'matb_sc2_resman.csv')
write.csv(tmp4 %>% select(StartTime, EndTime, V4), 'matb_sc1_comm_own.csv')
write.csv(tmp5 %>% select(StartTime, EndTime, V4), 'matb_sc1_comm_other.csv')
write.csv(tmp6 %>% select(StartTime, V4, V5, V6), 'matb_sc1_resman.csv')
