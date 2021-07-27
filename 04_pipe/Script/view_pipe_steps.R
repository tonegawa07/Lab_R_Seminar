## install ViewPipeSteps
devtools::install_github("daranzolin/ViewPipeSteps")

## load package
library(tidyverse)
library(ViewPipeSteps)

## import rawdata
rawdata <- read.csv("../Data/pipe_demo.csv")

## パイプ演算子 (%>%) ごとにViewを実行してくれる
d <- rawdata %>% 
  mutate(treatment=gsub(treatment,pattern="minus",replacement = "-")) %>% 
  mutate(treatment=gsub(treatment,pattern="plus",replacement = "+")) %>% 
  filter(part=="NL") %>% 
  pivot_longer(Al:Zn)