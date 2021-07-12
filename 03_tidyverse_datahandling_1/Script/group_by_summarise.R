source("./init.R")

# group_by & summarise 
#### Case study 1 - 処理区，部位ごとの平均値と標準偏差を算出

##### 1-1: 平均値と標準偏差の列を新たに作成
d_mean_sd=rawdata %>% 
  pivot_longer(Chl_a:Zn, names_to="phenotype", values_to="content") %>% 
  group_by(treatment, part, phenotype) %>% 
  summarise(mean=mean(content), sd=sd(content))
print(d_mean_sd)

##### 1-2: wideな平均値テーブルを作成
d_mean_wide=rawdata %>% 
  pivot_longer(Chl_a:Zn, names_to="phenotype", values_to="content") %>% 
  group_by(treatment, part, phenotype) %>% 
  summarise(mean=mean(content)) %>% 
  pivot_wider(names_from=phenotype, values_from=mean)
print(d_mean_wide)

##### ungroup
d_mean_sd=d_mean_sd %>% ungroup()

d_mean_wide=d_mean_wide %>% ungroup()
