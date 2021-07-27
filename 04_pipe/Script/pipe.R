## load package
library(tidyverse)

## import rawdata
rawdata <- read.csv("../Data/pipe_demo.csv")

## パイプ演算子 (%>%) がない世界線
### 変数量産編
d1 <- mutate(rawdata, treatment=gsub(treatment,pattern="minus",replacement = "-"))
d2 <- mutate(d1, treatment=gsub(treatment,pattern="plus",replacement = "+"))
d3 <- filter(d2, part=="NL")
d4 <- pivot_longer(d3, Al:Zn)

### 再代入編
d <- mutate(rawdata, treatment=gsub(treatment,pattern="minus",replacement = "-"))
d <- mutate(d, treatment=gsub(treatment,pattern="plus",replacement = "+"))
d <- filter(d, part=="NL")
d <- pivot_longer(d, Al:Zn)

## パイプ演算子 (%>%) がある世界線
d <- rawdata %>% 
  mutate(treatment=gsub(treatment,pattern="minus",replacement = "-")) %>% 
  mutate(treatment=gsub(treatment,pattern="plus",replacement = "+")) %>% 
  filter(part=="NL") %>% 
  pivot_longer(Al:Zn)
