# パッケージ読み込み
library(tidyverse)
library(cowplot)

data=read.csv("./data/barplot_2.csv")
data$treat=fct_inorder(data$treat)

# 最大値を取得．のちに使用
ylim = max(data$mean + data$sd)*1.2

png("./fig/barplot_2.png")

ggplot(data, #使用するデータ
       # グラフのx,yの指定．x軸はpH，y軸はmean, fillで2つ目の要因を指定し塗り分ける (treatで塗り分ける)
       aes(x=pH, y=mean, fill=treat))+
  # geom_barで棒グラフ指定(x軸，y軸を指定するときはstat="identity")．
  # 2要因の場合はposition=position_dodge．widthで系列間の距離を設定
  geom_bar(stat="identity",position = position_dodge(width = 0.9))+
  # geom_errorbarでエラーバー追加．widthで幅設定．sizeで線の太さ設定
  # geom_barと同様にposition=position_dodge. ()の中はgeom_barのwidthの値を指定
  geom_errorbar(aes(ymax = mean + sd, ymin = mean - sd), width=0.2, size=1.5, position = position_dodge(0.9))+
  # y軸を0からにする(スペースをなくす)．軸の上限を設定
  scale_y_continuous(expand = c(0,0), limits = c(0,ylim))+
  # 論文っぽい見た目にする．(cowplotパッケージが別途必要)．フォントサイズと線の太さを設定
  theme_cowplot(font_size = 24, line_size = 1.25)+
  # 見た目を整える(タイトルの位置，縦横比など)
  theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)+
  # 色を指定．RGB or 色名で．
  scale_fill_manual(values = c("blue", "orange"))+
  # タイトル，軸ラベルの内容を設定．上付き文字等も可能
  labs(title="plot_title", x="", y=expression(XX~content~"("~mg~g^{-1}~DW~")"))

dev.off()