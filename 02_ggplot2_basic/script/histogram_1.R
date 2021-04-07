# パッケージ読み込み
library(tidyverse)
library(cowplot)

data=read.csv("./data/histogram_1.csv")

png("./fig/histogram_1.png")

ggplot(data, #使用するデータ
       # グラフのxの指定．x軸はAl
       aes(x=Al))+
  # geom_histogramで箱ひげ図指定.binsでbinの数指定．colorで色指定．
  geom_histogram(bins = 15, fill="darkorange", color="black")+
  # y軸を0からにする(スペースをなくす)．軸の上限を設定
  scale_y_continuous(expand = c(0,0))+
  # 論文っぽい見た目にする．(cowplotパッケージが別途必要)．フォントサイズと線の太さを設定
  theme_cowplot(font_size = 24, line_size = 1.25)+
  # 見た目を整える(タイトルの位置，縦横比など)
  theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)+
  # タイトル，軸ラベルの内容を設定．上付き文字等も可能
  labs(title="plot_title", x=expression(Al~content~"("~mg~g^{-1}~DW~")"), y="Number of accessions")

dev.off()