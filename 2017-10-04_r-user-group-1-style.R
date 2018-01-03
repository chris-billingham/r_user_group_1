# N Brown R User Group 1 
# 2017-10-04
# Chris Billingham

# load magrittr to start piping
library(magrittr)

# do it the old way
log(sin(cos(1)))

# lets use a pipe
1 %>% 
  cos() %>% 
  sin() %>% 
  log()

# string manipulation the old way
substr(toupper(paste0("hello ","world")),2,4)

# strings with pipes
"hello " %>% 
  paste0("world") %>% 
  toupper() %>% 
  substr(2,4)

# let's do some dplyr
library(dplyr)

# load in the sales.rda file, make sure it's in your working directory.
load(file = "sales.rda")

# let's examine it
str(sales)

# time to combine pipes with dplyr verbs
# first let's investigate group by, summarise
# sum
sales %>% 
  group_by(date_of_accepted_demand) %>% 
  summarise(demand =  sum(demand))

sales %>% 
  group_by(date_of_accepted_demand, trading_title_code) %>% 
  summarise(items =  sum(items))

# count
sales %>% 
  group_by(trading_title_code) %>% 
  summarise(count = n())

# ok let's use mutate
sales %>% 
  mutate(thousands = demand/1000)

# lets try out select, filter and combinations
sales %>% 
  select(trading_title_code, demand)

sales %>% 
  filter(trading_title_code == "JDW")

sales %>% 
  select(date_of_accepted_demand, trading_title_code, demand) %>% 
  filter(trading_title_code == "JDW") %>% 
  group_by(date_of_accepted_demand) %>% 
  summarise(demand = sum(demand))

sales %>% 
  select(date_of_accepted_demand, trading_title_code, demand, items) %>% 
  filter(trading_title_code == "JDW") %>% 
  group_by(date_of_accepted_demand) %>% 
  summarise(demand = sum(demand), items = sum(items))

# ok let's try the join functionality in dplyr
# first let's load in another table to join on
load(file = "uk_bh.rda")
head(uk_bh)

# left join our old friend
sales %>% 
  left_join(uk_bh, by=c("date_of_accepted_demand"= "date"))

# let's combine join and manipulation verbs
sales %>% 
  left_join(uk_bh, by=c("date_of_accepted_demand"= "date")) %>% 
  filter(type == "bh")

sales %>% 
  left_join(uk_bh, by=c("date_of_accepted_demand"= "date")) %>% 
  filter(type == "bh") %>% 
  group_by(merch_fmb_desc) %>% 
  summarise(demand = sum(demand))

# now let's investigate the new joins
sales %>% 
  semi_join(uk_bh, by=c("date_of_accepted_demand" = "date"))

sales %>% 
  anti_join(uk_bh, by=c("date_of_accepted_demand" = "date"))

