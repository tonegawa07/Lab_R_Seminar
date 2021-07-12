source("./init.R")

# arrange
#### Case study 1 - ある列の値を基に並び替えたい

##### 1-1: Alの昇順にソート
d=rawdata %>% 
  arrange(Al)
print(d)

##### 1-2: Alの降順にソート
d=rawdata %>% 
  arrange(desc(Al))
print(d)