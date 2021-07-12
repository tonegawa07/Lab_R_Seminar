source("./init.R")

# select
#### Case study 1 - n番目の列を抽出

##### 1-1: 6列目のAlだけを抽出
d=rawdata %>% 
  select(6)
print(d)

##### 1-2: 1列目から5列目までを抽出
d=rawdata %>% 
  select(1:5)
print(d)

##### 1-3: 1-3列目と6-最終列を抽出
# 列番号でselect
d=rawdata %>% 
  select(1:3, 6:18)
print(d)

# 最終列をlength()で取得
d=rawdata %>% 
  select(1:3, 6:length(rawdata))
print(d)

# 最終列をncol()で取得
d=rawdata %>% 
  select(1:3, 6:ncol(rawdata))
print(d)

#### Case study 2 - 任意の列名を抽出

##### 2-1: Al列のみを抽出
d=rawdata %>% 
  select(Al)
print(d)

##### 2-2: Al-Zn列を抽出
d=rawdata %>% 
  select(Al:Zn)
print(d)
