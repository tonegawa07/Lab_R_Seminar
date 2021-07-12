# ggplot2基本



## R文法の基本

代入は，"<-" または "=" 

コメントアウトは "#"

```R
# コメントアウト(実行されない．メモやコードの意味を書き残せる)
```

コードの可読性はとても重要なのでどんどんコメントを残そう！

日本語でOK．分かりやすさが最優先なので，無理に英語にするより日本語の方がベター (と福田は思います．)



出力は"print()"

```R
print(出力する内容)
```





## パッケージ

便利な関数を集めたもの．パッケージを読み込むことでデフォルトで入っている以外の関数が使用可能になる．

「tidyverse」… ggplot2やdplyrなどの非常に使用頻度の高いパッケージが含まれる．

まずローカル環境にインストール

```R
install.packages("パッケージ名")

install.packages("tidyverse")
```

インストール済のパッケージは，libraryで読み込む

```R
library(tidyverse)
```



## 使用頻度の高い4種の可視化方法

- 棒グラフ
- 散布図
- 箱ひげ図
- ヒストグラム



## ggplot2の基本形

基本形は以下のコード

```R
ggplot(data,
      aes(x,y))
```

dataは使用するデータ，aesの中で変数を指定する．

この基本形に"+"でレイヤーや要素を追加することで多種多様なグラフを描画する．

例えば棒グラフは"geom_bar"でレイヤーを追加できるので，以下のようになる．

```R
ggplot(data,
      aes(x,y))+
	geom_bar(stat="identity", width=0.6)
```



### 棒グラフ (geom_bar) (1系列)

まずは1系列の棒グラフから．

以下の様なデータフレームがあるとします．



| treat   | mean | sd   |
| ------- | ---- | ---- |
| Control | 3.05 | 0.45 |
| -N      | 2.02 | 0.33 |
| -P      | 1.98 | 0.29 |
| -K      | 2.77 | 0.56 |

このデータフレームを変数"data"に代入したものとします．

※ ただし，このままではx軸の順番が変わってしまうので，forcatsパッケージを使って出てきた順にlevelsを設定する処理を行っておきます．

```R
# パッケージ読み込み
library(tidyverse)

data$treat=fct_inorder(data$treat)
```



```R
# パッケージ読み込み
library(tidyverse)
library(cowplot)

# 最大値を取得．のちに使用
ylim = max(data$mean + data$sd)*1.2

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

```



![image-20210315204802280](C:\Users\yusuk\AppData\Roaming\Typora\typora-user-images\image-20210315204802280.png)



### 棒グラフ (geom_bar)  (2系列)

2系列ある場合，geom_bar内でpositionを指定する必要がある．

positionの設定によって，横並び，積み上げなどを指定できる．

では，以下の様なデータフレームがあるとします．



| treat | pH   | mean | sd   |
| ----- | ---- | ---- | ---- |
| -Al   | 3.0  | 1.24 | 0.34 |
| -Al   | 4.0  | 3.01 | 0.64 |
| -Al   | 5.0  | 2.65 | 0.55 |
| -Al   | 6.0  | 2.08 | 0.43 |
| +Al   | 3.0  | 2.55 | 0.45 |
| +Al   | 4.0  | 4.67 | 0.44 |
| +Al   | 5.0  | 3.75 | 0.21 |
| +Al   | 6.0  | 3.03 | 0.29 |



Alの有無とpHという2要因のある試験の結果です．

このデータフレームを変数"data"に代入したものとします．



```R
# パッケージ読み込み
library(tidyverse)
library(cowplot)

data$treat=fct_inorder(data$treat)

# 最大値を取得．のちに使用
ylim = max(data$mean + data$sd)*1.2

ggplot(data, #使用するデータ
       # グラフのx,yの指定．x軸はpH，y軸はmean.
       # fillで2つ目の要因を指定し塗り分ける (treatで塗り分ける)
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
```

![image-20210329004641781](C:\Users\yusuk\AppData\Roaming\Typora\typora-user-images\image-20210329004641781.png)





### 散布図 (geom_point) (1系列)

ここでは散布図について．

以下の様なデータフレームがあるとします．

| No.  | Al          | Ca          | Mg          |
| ---- | ----------- | ----------- | ----------- |
| 1    | 0.23253113  | 2.011761548 | 1.507212202 |
| 2    | 0.353463994 | 1.990260146 | 1.635696505 |
| 3    | 0.255762184 | 2.027036728 | 1.519919317 |
| 4    | 0.355209849 | 2.248337283 | 1.499788626 |
| 5    | 0.321535449 | 2.364581173 | 1.539037703 |
| :    | :           | :           | :           |
| 60   | 0.18427482  | 2.202354433 | 1.731837366 |

Al, Ca, Mgの60行あるデータです．

このデータフレームを変数"data"に代入したものとします．

```R
# パッケージ読み込み
library(tidyverse)
library(cowplot)

ggplot(data, #使用するデータ
       # グラフのx,yの指定．x軸はAl，y軸はCa,
       aes(x=Al, y=Ca))+
  # geom_pointで散布図指定.sizeで点の大きさ．colorで点の色指定
  geom_point(size=3,color="darkorange1")+
  # stat_smoothで回帰直線表示．colorで線の色．sizeで線の太さ設定
  stat_smooth(method="lm",se = T, colour = "black", size = 1.5)+
  # 論文っぽい見た目にする．(cowplotパッケージが別途必要)．フォントサイズと線の太さを設定
  theme_cowplot(font_size = 24, line_size = 1.25)+
  # 見た目を整える(タイトルの位置，縦横比など)
  theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)+
  # タイトル，軸ラベルの内容を設定．上付き文字等も可能
  labs(title="plot_title")

```

![image-20210317212050249](C:\Users\yusuk\AppData\Roaming\Typora\typora-user-images\image-20210317212050249.png)

### 散布図 (geom_point) (2系列)

以下の様なデータフレームがあるとします．

| No.  | Cultivar | Al         | Ca          | Mg          |
| ---- | -------- | ---------- | ----------- | ----------- |
| 1    | Yabukita | 0.23253113 | 2.011761548 | 1.507212202 |
| :    | :        | :          | :           | :           |
| 30   | Yabukita | 0.33402421 | 2.852291211 | 2.260668877 |
| 31   | Benifuki | 0.3517856  | 2.768826549 | 2.231410582 |
| :    | :        | :          | :           | :           |
| 60   | Benifuki | 0.18427482 | 2.202354433 | 1.731837366 |

YabukitaとBenifukiで色分けをします．

このデータフレームを変数"data"に代入したものとします．

```R
# パッケージ読み込み
library(tidyverse)
library(cowplot)

data$Cultivar=fct_inorder(data$Cultivar)

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
```

![image-20210329013410316](C:\Users\yusuk\AppData\Roaming\Typora\typora-user-images\image-20210329013410316.png)



### 箱ひげ図 (geom_boxplot) (1系列)

ここでは，箱ひげ図について．

以下の様なデータフレームがあるとします．

| No.  | Year | Al         | Ca          | Mg          |
| ---- | ---- | ---------- | ----------- | ----------- |
| 1    | 2020 | 0.23253113 | 2.011761548 | 1.507212202 |
| :    | :    | :          | :           | :           |
| 30   | 2020 | 0.33402421 | 2.852291211 | 2.260668877 |
| 1    | 2021 | 0.3517856  | 2.768826549 | 2.231410582 |
| :    | :    | :          | :           | :           |
| 30   | 2021 | 0.18427482 | 2.202354433 | 1.731837366 |

2020と2021の2年分のデータです．

このデータフレームを変数"data"に代入したものとします．

```R
# パッケージ読み込み
library(tidyverse)
library(cowplot)

# Yearを文字列に変換
data$Year=as.character(data$Year)

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
```



![image-20210329022609985](C:\Users\yusuk\AppData\Roaming\Typora\typora-user-images\image-20210329022609985.png)

### 箱ひげ図 (geom_boxplot) (2系列)

以下の様なデータフレームがあるとします．

| No.  | Year | treat   | Al          | Ca          | Mg          |
| ---- | ---- | ------- | ----------- | ----------- | ----------- |
| 1    | 2020 | Control | 0.23253113  | 2.011761548 | 1.507212202 |
| :    | :    | :       | :           | :           | :           |
| 15   | 2020 | Control | 0.254716672 | 1.578117096 | 2.050971354 |
| 1    | 2020 | Shade   | 0.319197352 | 2.511785476 | 2.090803569 |
| :    | :    | :       | :           | :           | :           |
| 15   | 2020 | Shade   | 0.33402421  | 2.852291211 | 2.260668877 |
| 1    | 2021 | Control | 0.3517856   | 2.768826549 | 2.231410582 |
| :    | :    | :       | :           | :           | :           |
| 15   | 2021 | Control | 0.242891074 | 2.743593288 | 1.417132638 |
| 1    | 2021 | Shade   | 0.251563215 | 1.657164262 | 1.578416889 |
| :    | :    | :       | :           | :           | :           |
| 15   | 2021 | Shade   | 0.18427482  | 2.202354433 | 1.731837366 |

2020と2021の2年分のControl区とShade区のデータです．

このデータフレームを変数"data"に代入したものとします．



```R
# パッケージ読み込み
library(tidyverse)
library(cowplot)

# Yearを文字列に変換
data$Year=as.character(data$Year)

ggplot(data, #使用するデータ
       # グラフのx,yの指定．x軸はYear，y軸はAl, fillで塗り分け指定
       aes(x=Year, y=Al, fill=treat))+
  # geom_boxplotで箱ひげ図指定.sizeで点，線の大きさ指定. treatで塗り分け指定
  geom_boxplot(size=1)+
  # geom_pointで点を散らす．
  #geom_point(aes(x=Year, y=Al, color=treat), size=1.5, position=position_jitterdodge())+
  # 論文っぽい見た目にする．(cowplotパッケージが別途必要)．フォントサイズと線の太さを設定
  theme_cowplot(font_size = 24, line_size = 1.25)+
  # 見た目を整える(タイトルの位置，縦横比など)
  theme(plot.title = element_text(hjust = 0, size = 28),aspect.ratio = 1)+
  # タイトル，軸ラベルの内容を設定．上付き文字等も可能. 凡例を"Treatment"に変更
  labs(title="plot_title", x="", y=expression(Al~content~"("~mg~g^{-1}~DW~")"), fill="Treatment")
```

![image-20210329193137512](C:\Users\yusuk\AppData\Roaming\Typora\typora-user-images\image-20210329193137512.png)

### ヒストグラム (geom_histogram) (1系列)

以下の様なデータフレームがあるとします．

| No.  | Al          | Ca          | Mg          |
| ---- | ----------- | ----------- | ----------- |
| 1    | 0.23253113  | 2.011761548 | 1.507212202 |
| 2    | 0.353463994 | 1.990260146 | 1.635696505 |
| 3    | 0.255762184 | 2.027036728 | 1.519919317 |
| 4    | 0.355209849 | 2.248337283 | 1.499788626 |
| 5    | 0.321535449 | 2.364581173 | 1.539037703 |
| :    | :           | :           | :           |
| 60   | 0.18427482  | 2.202354433 | 1.731837366 |

Al, Ca, Mgの60行あるデータです．

このデータフレームを変数"data"に代入したものとします．

```R
# パッケージ読み込み
library(tidyverse)
library(cowplot)


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

```

![image-20210329203538282](C:\Users\yusuk\AppData\Roaming\Typora\typora-user-images\image-20210329203538282.png)

### ヒストグラム (geom_histogram) (2系列)

以下の様なデータフレームがあるとします．

| No.  | Year | Al          | Ca          | Mg          |
| ---- | ---- | ----------- | ----------- | ----------- |
| 1    | 2020 | 0.23253113  | 2.011761548 | 1.507212202 |
| :    | :    | :           | :           | :           |
| 60   | 2020 | 0.18427482  | 2.202354433 | 1.731837366 |
| 1    | 2021 | 0.279037356 | 2.414113858 | 1.808654642 |
| :    | :    | :           | :           | :           |
| 60   | 2021 | 0.221129784 | 2.64282532  | 2.078204839 |

2020と2021の2年分のデータです．

このデータフレームを変数"data"に代入したものとします．

```R
# パッケージ読み込み
library(tidyverse)
library(cowplot)

# yearを文字列に変換
data$Year=as.character(data$Year)

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
```



![image-20210329203557362](C:\Users\yusuk\AppData\Roaming\Typora\typora-user-images\image-20210329203557362.png)

参考



https://qiita.com/tomiyou/items/4e1532b48a6fa58e92df



### 図の保存方法

pdf, pngなどで保存できる関数がある．

例えばpng形式で保存する場合png関数を使う．

png("ファイル名")

```R
# figフォルダにbarplot_1.pngとして保存
# png関数で描画デバイスを開く
png("fig/barplot_1.png")

# グラフ描画
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

# 描画デバイスを閉じる
dev.off()
```

上記のように，流れとしては

1. png関数などで描画デバイスを開く

2. ggplotなどでグラフ描画

3. dev.off()で描画デバイスを閉じる

この一連で，グラフの描画と保存ができる．

参考



https://stats.biopapyrus.jp/r/graph/imagedevice.html

https://stats.biopapyrus.jp/r/ggplot/

