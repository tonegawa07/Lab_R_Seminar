source("./init.R")

# slice
#### Case study 1 - n番目の行を抽出

##### 1-1: 1行目だけを抽出
d=rawdata %>% 
  slice(1)
print(d)

##### 1-2: 1-5行目を抽出
d=rawdata %>% 
  slice(1:5)
print(d)

##### 1-3: 1行目と最終行を抽出
d=rawdata %>% 
  slice(1,nrow(rawdata))
print(d)

#### Case study 2 - ある条件に基づき抽出 (一致，大小，etc...)

##### 2-1: NLのみを抽出
d=rawdata %>% 
  filter(part=="NL")
print(d)

##### 2-2: Alが1以上の列のみ抽出
d=rawdata %>% 
  filter(Al>=1)
print(d)

##### 2-3: 複数条件を満たす列のみ抽出
d=rawdata %>% 
  filter(part=="NL" | part=="ML")
print(d)