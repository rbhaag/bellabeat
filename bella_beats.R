install.packages("tidyverse")
install.packages("lubridate")
library("tidyverse")
library("lubridate")

#Install packages used for cleaning
install.packages("here")
install.packages("skimr")
install.packages("janitor")

#Load the packages with library
library("here")
library("skimr")
library("janitor")

#Load CSV files that have been uploaded
daily_activity <- read.csv("dailyActivity_merged.csv")
daily_calories <- read.csv("dailyCalories_merged.csv")
daily_intensities <- read.csv("dailyIntensities_merged.csv")
daily_steps <- read.csv("dailySteps_merged.csv")
sleep_day <- read.csv("sleepDay_merged.csv")
weight_log <- read.csv("weightLogInfo_merged.csv")

#Used glimpse to get a quick look at the data frame 
glimpse(daily_activity) 
glimpse(daily_calories)
glimpse(daily_intensities)
glimpse(daily_steps)
glimpse(sleep_day)
glimpse(weight_log)

#Used head to get preview of column names and first few rows of data
head(daily_activity)
head(daily_calories)
head(daily_intensities)
head(daily_steps)
head(sleep_day)
head(weight_log)

#Look at column names for summary statistics and merging purposes
colnames(daily_activity)
colnames(daily_calories)
colnames(daily_intensities)
colnames(daily_steps)
colnames(sleep_day)
colnames(weight_log)

#Use pipe to get summary
daily_activity %>%
  select(TotalSteps, TotalDistance, SedentaryMinutes, Calories) %>%
  summary()

daily_calories %>% 
  select(Calories) %>% 
  summary()

daily_intensities %>% 
  select(SedentaryMinutes, LightlyActiveMinutes, FairlyActiveMinutes, VeryActiveMinutes) %>% 
  summary()

daily_steps %>% 
  select(StepTotal) %>% 
  summary()

sleep_day %>% 
  select(TotalMinutesAsleep, TotalTimeInBed) %>% 
  summary()

weight_log %>% 
  select(WeightPounds)
  summary()
  
#Used skim_without_charts to get comprehensive look at data frames 
skim_without_charts(daily_activity)
skim_without_charts(daily_calories)
skim_without_charts(daily_intensities)
skim_without_charts(daily_steps)
skim_without_charts(sleep_day)
skim_without_charts(weight_log)

#How many unique participants based on ID
n_distinct(daily_activity$Id)
n_distinct(daily_calories$Id)
n_distinct(daily_intensities$Id)
n_distinct(daily_steps$Id)
n_distinct(sleep_day$Id)
n_distinct(weight_log$Id)

#How many observations
nrow(daily_activity)
nrow(daily_calories)
nrow(daily_intensities)
nrow(daily_steps)
nrow(sleep_day)
nrow(weight_log)

#Separate date and time columns in sleep_day and weight_log data frames 
sleep_day_sep <- separate(sleep_day,SleepDay,into=c('date','time'), sep=' ')
weight_log_sep <- separate(weight_log,Date,into=c('date','time'), sep=' ')

#Rename so every table has date instead of ActivityDay
colnames(daily_activity)[2] <- "date"

#Merge data
sleep_activity <- merge(daily_activity, sleep_day_sep, by=c("Id", "date"))
weight_activity <- merge(daily_activity, weight_log_sep, by=c("Id", "date"))

#Install and load package for visualizations 
install.packages("ggplot2")
library("ggplot2")

ggplot(data=daily_activity, aes(x=VeryActiveMinutes, y=Calories)) + geom_point()
ggplot(data=daily_activity, aes(x=FairlyActiveMinutes, y=Calories)) + geom_point()
ggplot(data=daily_activity, aes(x=LightlyActiveMinutes, y=Calories)) + geom_point()
ggplot(data=daily_activity, aes(x=SedentaryMinutes, y=Calories)) + geom_point()
ggplot(data=daily_activity, aes(x=VeryActiveMinutes, y=TotalSteps)) + geom_point() + geom_smooth()

ggplot(data = sleep_activity, aes(x = TotalMinutesAsleep, y = VeryActiveMinutes)) +
  geom_point() + geom_smooth() + xlim(0,800) +
  ylim(0,1000) + labs(title = "Total Minutes Asleep vs VeryActiveMinutes")

ggplot(data = sleep_activity) + (mapping=aes(x = TotalMinutesAsleep, y = LightlyActiveMinutes)) +
  geom_point() + geom_smooth() + xlim(0,800) +
  ylim(0,1000) + labs(title = "Total Minutes Asleep vs Lightly Active Minutes")

ggplot(data = sleep_activity, aes(x = TotalMinutesAsleep, y = SedentaryMinutes)) +
  geom_point() + geom_smooth() + labs(title = "Total Minutes Asleep vs Sedentary Minutes")







