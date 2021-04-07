# パッケージ読み込み
library(tidyverse)
library(cowplot)

data=read.csv("./data/histogram_2.csv")
# yearを文字列に変換
data$Year=as.character(data$Year)

png("./fig/histogram_2.png")

ggplot(data, #使用するデータ
       # グラフのxの指定．x軸はAl, fill, colorで塗り分け指定
       aes(x=Al, fill=Year, color=Year))+
  # geom_histogramで箱ひげ図指定.binwidthで階級の幅指定．重ねる場合はposition = "identity"．alphaで透過
  geom_histogram(bins = 15, position = "identity", alpha = 0.5)+
  # y軸を0からにする(スペースをなくす)．軸の上限を設定
  scale_y_continuous(expand = c(0,0))+
  # 論文っぽい見た目にする．(cowplotパッケージが別途必要)．フォントサイズと線の太さを設定
  theme_cowplot(font_size = 24, line_size = 1.25)+
  # 見た目を整える(タイトルの位置，縦横比など)
  theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)+
  # タイトル，軸ラベルの内容を設定．上付き文字等も可能
  labs(title="plot_title", x=expression(Al~content~"("~mg~g^{-1}~DW~")"), y="Number of accessions")

dev.off()