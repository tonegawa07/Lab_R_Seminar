source("./init.R")

# mutate
#### Case study 1 - ある列内で文字の置換をしたい

##### 1-1: "minusAl"を"-Al"に，"plusAl"を"+Al"に変換
d=rawdata %>% 
  mutate(treatment=gsub(treatment,pattern="minus",replacement = "-")) %>% 
  mutate(treatment=gsub(treatment,pattern="plus",replacement = "+"))
print(d)

#### Case study 2 - 新規の列を追加したい

##### 2-1: Chl aとChl bを基にChl a/bとChl a+b列を追加する
d=rawdata %>% 
  mutate(Chl_a_b_ratio = Chl_a/Chl_b) %>% 
  mutate(Chl_total = Chl_a+Chl_b)
print(d)
