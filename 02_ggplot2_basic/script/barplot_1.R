# パッケージ読み込み
library(tidyverse)
library(cowplot)

data=read.csv("./data/barplot_1.csv")
data$treat=fct_inorder(data$treat)

# 最大値を取得．のちに使用
ylim = max(data$mean + data$sd)*1.2

png("./fig/barplot_1.png")

ggplot(data, #使用するデータ
       # グラフのx,yの指定．x軸はtreat，y軸はmean
       aes(x=treat, y=mean))+
  # geom_barで棒グラフ指定(x軸，y軸を指定するときはstat="identity")．widthで幅設定
  geom_bar(stat="identity", width = 0.6)+
  # geom_errorbarでエラーバー追加．widthで幅設定．sizeで線の太さ設定
  geom_errorbar(aes(ymax = mean + sd, ymin = mean - sd), width=0.2, size=1.5)+
  # y軸を0からにする(スペースをなくす)．軸の上限を設定
  scale_y_continuous(expand = c(0,0), limits = c(0,ylim))+
  # 論文っぽい見た目にする．(cowplotパッケージが別途必要)．フォントサイズと線の太さを設定
  theme_cowplot(font_size = 24, line_size = 1.25)+
  # 見た目を整える(タイトルの位置，縦横比など)
  theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)+
  # タイトル，軸ラベルの内容を設定．上付き文字等も可能
  labs(title="plot_title", x="", y=expression(XX~content~"("~mg~g^{-1}~DW~")"))

dev.off()

### 1行ずつ

g=ggplot(data, aes(x=treat, y=mean))+
  geom_bar(stat="identity", width = 0.6)
print(g)
g=g+geom_errorbar(aes(ymax = mean + sd, ymin = mean - sd), width=0.2, size=1.5)
print(g)
g=g+scale_y_continuous(expand = c(0,0), limits = c(0,ylim))
print(g)
g=g+theme_cowplot(font_size = 24, line_size = 1.25)
print(g)
g=g+theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)
print(g)
g=g+labs(title="plot_title", x="", y=expression(XX~content~"("~mg~g^{-1}~DW~")"))
print(g)
