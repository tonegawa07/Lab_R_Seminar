source("./init.R")

# pivot_longer

#### Case study 1 - tidyな (longな) データにする
# 列名で指定
d=rawdata %>% 
  pivot_longer(Chl_a:Zn, names_to="phenotype", values_to="content")
print(d)

# 列番号で指定
d=rawdata %>% 
  pivot_longer(4:18, names_to="phenotype", values_to="content")
print(d)

# pivot_wider

#### Case study 1 - wideなデータにする
# 一度longデータを作る
d_long=rawdata %>% 
  pivot_longer(Chl_a:Zn, names_to="phenotype", values_to="content")
print(d_long)

# wideにする
d_wide=d_long %>% 
  pivot_wider(names_from=phenotype, values_from=content)
print(d_wide)