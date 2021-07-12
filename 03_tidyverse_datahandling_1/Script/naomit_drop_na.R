source("./init.R")

#### Case study 1 - 1つでもNAのある行は削除する
d=na.omit(rawdata)
print(d)

#### Case study 2 - ある列にNAがある場合削除する
d=rawdata %>% drop_na(Al)
print(d)