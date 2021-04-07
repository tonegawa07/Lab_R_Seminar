# パッケージ読み込み
library(tidyverse)
library(cowplot)

data=read.csv("./data/boxplot_1.csv")
# yearを文字列に変換
data$Year=as.character(data$Year)

png("./fig/boxplot_1.png")

ggplot(data, #使用するデータ
       # グラフのx,yの指定．x軸はYear，y軸はAl, fillで塗り分け指定
       aes(x=Year, y=Al, fill=Year))+
  # geom_boxplotで箱ひげ図指定.sizeで点，線の大きさ指定
  geom_boxplot(size=1)+
  # geom_jitterで点を散らす．widthは散らす幅．sizeは点の大きさ．colorは色．
  geom_jitter(width = 0.3, size=1.5,color="#606060")+
  # 論文っぽい見た目にする．(cowplotパッケージが別途必要)．フォントサイズと線の太さを設定
  theme_cowplot(font_size = 24, line_size = 1.25)+
  # 見た目を整える(タイトルの位置，縦横比など)
  theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)+
  # タイトル，軸ラベルの内容を設定．上付き文字等も可能
  labs(title="plot_title", x="", y=expression(Al~content~"("~mg~g^{-1}~DW~")"))

dev.off()