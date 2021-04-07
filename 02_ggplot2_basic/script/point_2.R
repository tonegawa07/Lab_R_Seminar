# パッケージ読み込み
library(tidyverse)
library(cowplot)

data=read.csv("./data/point_2.csv")
data$Cultivar=fct_inorder(data$Cultivar)

png("./fig/point_2.png")

ggplot(data, #使用するデータ
       # グラフのx,yの指定．x軸はAl，y軸はCa, colorで塗り分け指定
       aes(x=Al, y=Ca, color=Cultivar))+
  # geom_pointで散布図指定.sizeで点の大きさ指定
  geom_point(size=3)+
  # stat_smoothで回帰直線表示．colorで線の色．sizeで線の太さ設定
  stat_smooth(method="lm",se = T, size = 1.5)+
  # 論文っぽい見た目にする．(cowplotパッケージが別途必要)．フォントサイズと線の太さを設定
  theme_cowplot(font_size = 24, line_size = 1.25)+
  # 見た目を整える(タイトルの位置，縦横比など)
  theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)+
  # タイトル，軸ラベルの内容を設定．上付き文字等も可能
  labs(title="plot_title")

dev.off()