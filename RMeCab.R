## 2016 09 15     # this file is encoded by Shift Jis (CP932)
######################################################
#　　　石田　基広　著
#     『Rによるテキストマイニング入門』
#     森北出版,ISBN 978-4-627-84841-2,2008年12月

# http://sites.google.com/site/rmecab/
# http://rmecab.jp/index.php?RMeCab
#
# 本データには，図書に記載のないコードも含まれています．
#
   # 2009 年 11 月 24 日開催 統計数理解析研究所公開講座 
   #「Rによるテキストマイニング入門」 データは
   # ism20091124  at  http://groups.google.co.jp/group/ishidamotohiro
   # です，あわせてご覧ください，
#
# お問い合わせはこちらにメールをください
# ishida.motohiro at gmail.com
#
# 実装関数の解説ページ
#  『Rによるテキストマイニング入門』に記載の無い関数を含めて解説しています
# http://rmecab.jp/wiki/index.php?RMeCabFunctions


######### シャープ(#)記号から右の記述はコメントです。
######### シャープ(#)記号から右は実行しても無視されます。


##### 作業フォルダを変更する必要があれば
# getwd() ## 現在のフォルダを確認する
##### 作業フォルダを変更する必要があれば
# setwd("C:/data") # Windows

setwd("/Users/ishidamotohiro/data") # Mac OS X
setwd("C:/Users/ishida/data")# Windows

## グラフで日本語を扱う
## R をインストール後、以下をRのコンソールで一度だけ実行してください
## ホームフォルダに .Rprofileという設定ファイルが生成されます。
## Rは起動時にこの設定を読み込みます


#####   MeCab のインストール
# https://sites.google.com/site/rmecab/home/install
## を参照してください


# RMeCabのインストール

install.packages("RMeCab", repos = "http://rmecab.jp/R")

library(RMeCab)

citation("RMeCab")

####################################################
#                                                  #
#                                                  #
#        第１章　テキストマイニングとは何か        #
#                                                  #
#                                                  #
####################################################

library(MASS)
# 対応分析
x <- matrix(c(4,2,  6, 2,
              2,8,  1, 4,
              2,9,  2, 4,
              3,3,  6, 3,
              1,7,  2, 2), ncol = 4, byrow = T)

colnames(x) <- c("主婦(買う)","主婦(買わない)","独身者(買う)","独身者(買わない)")
rownames(x) <- c("機能","スペース", "場所", "便利", "割高")



x.corr <- corresp(x, n=2)
biplot(x.corr)


## ## ついでにクラスター分析（後述）
## x.dist <- dist(t(x), "canberra")
## x.clus <- hclust(x.dist, "ward")
## plot(x.clus)



####################################################
#                                                  #
#                                                  #
#           第３章　R に慣れる                     #
#                                                  #
#                                                  #
####################################################



# 作業フォルダの変更
setwd("C:/data") # Windows

# 式の例1+2   # たし算を表わす簡単な式

1 + 2 # 適宜スペースをはさんで構わない
3 - 2
10 / 2 # 割り算はスラッシュで表現する
5 * 2  # 掛け算はアスタリスクで


 1 + 2 +
 3 + 4 + 5 +
 6 + 7 + 8 + 9 +
 10             # 合計は 55 のはず

# 代入を行う

x <- 10
x / 2 #

エックス <- 5
エックス / 2

3x <- 3

x <- c(10, 20)
x / 2


# 関数

x <- c(1, 2, 3, 4, 5)
length(x) # x の要素数は
max(x)    # x の最大値は
min(x)    # x の最小値は


getwd()
 # setwd("C:/data")

# データの型
y <- c(1, 3.14, "A")
y      #



# 要因
y <- factor(c("A","B","C"))
y         # 文字として表示されるが
str(y)    # 
mode(y)   # 実体は数値である

y <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
y                  # 代入結果を確認
y <- 1:10          # コロンを使うと連続した整数を作成できる．c() は不要
y[1]               # ベクトルの一部の要素を抽出できる． [] を「添字」と呼ぶ
y[1:3]             # 添字そのものをベクトルで指定しても構わない
y[c(1, 3, 5, 7)]


# ベクトル単位の演算を確認する
x <- 1:5      # 1 から 5 までの整数
x + 1         # ベクトルに 1 を足すのは
# 
x <-  x + 1   # 計算結果で上書きする
x


# 文字ベクトルの作成
z <- c("A","B","C")
z[1]



## 行列
# 簡単な行列
mat <- matrix(c(1,2,3,4), nrow = 2)
mat
# 横方向に埋める指定をする
mat <- matrix(c(1,2,3,4), nrow = 2, byrow = TRUE)
mat


(mat <- matrix(data = c(38, 14, 11, 51), ncol = 2)) 
(mat <- matrix(c(38, 14, 11, 51), nc = 2))    # 上と同じ
# 行列には行名，列名を指定できる．
rownames(mat) <- c("light", "dark")
colnames(mat) <- c("blue",  "brown")
mat
colSums(mat); rowSums(mat)      # 列あるいは行ごとの合計
colMeans(mat); rowMeans(mat)    # 列あるいは行ごとの平均
apply(mat, 1, sum)              # rowSums(mat) に同じ
apply(mat, 2, sum)              # colSums(mat) に同じ



## データフレーム
y <- data.frame(                # 適当に改行を行う．一行で入力しても構わない
        english = c(45, 55, 65, 75, 85,   95), 
        math =    c(50, 60, 70, 80, 90, 100))     # 閉じ括弧の数に注意

y                              # オブジェクト y の中身を確認する
# データフレームへのアクセス

y[1, ]       # 1 行目を抽出
y[1:3, ]     # 1 - 3行を抽出
y[c(1,3), ]  # 1, 3 行を抽
y[2,1]       # 2行目の 1 列目を抽出
y[2,"english"]       # 列番号ではなく，列名を引用符で囲って指定

rownames(y) <-  c("Michiko","Taro","Masako","Jiro","Aiko","Kenta")
y[2,]
y["Jiro",]      # 次郎の点を表示する
y[-c(1,5), ]

mean(y)

mean(y[,2])       # 行はすべて，列は 2 列目だけを指定 
mean(y[, "math"]) # 列名は引用符を加えて指定する

mean(y$math)      # この場合，列名に引用符は不要

attach(y)
mean(math)

# データフレームのデータの変更，追加

y$phys <- c(47, 57, 67, 77, 87, 97)

y[1,]
y[1,1] <- 100      # 1 行目 1 列目のデータを変更
y[1,]

# 行名と列名を指定しての変更
y[rownames(y) == "Michiko", colnames(y) == "english"] <- 45




## リスト
x <- 1:10                       # ベクトル
y <- matrix(1:9, ncol = 3)      # 行列
                                # そしてデータフレーム
z <- data.frame(name = c("A","B","C"), data = c(1,2,3))
                                # これらを一つにまとめてしまう
xyz <- list(x, y, z)
xyz                             # オブジェクトの中身を確認する
                       # リスト作成時に各要素に名前を付けることもできる
xyz <- list(x = x, y = y, z = z)# 同じリストを変数名付きで作成
xyz                             # オブジェクトの中身を確認する
# リストの要素にアクセスする
xyz[[1]]       # 名前付きならば xyz$x でも良い
xyz[[2]]       # 名前付きならば xyz$y でも良い
xyz[[3]]       # 名前付きならば xyz$z でも良い
# リストの要素の，そのまた要素にアクセスする
xyz[[3]][1]    # データフレームの一列目
xyz[[c(3,1)]]  #  上と同じ出力
xyz[[3]][[1]]  #  上と同じ出力
xyz[["z"]][[1]]#  上と同じ出力
xyz$z[[1]]     #  上と同じ出力


## GUI 画面でデータを入力する
x <- data.frame()
fix(x)


y <- data.frame(category = c("A","B","C"), data = c(1,2,3))
y

 getwd()

write.csv(y, file = "data.csv", row.names = FALSE)

new.y <- read.csv(file = "data.csv")
new.y


## グラフィックス
# 棒グラフ．barplot のヘルプを参照のこと
VADeaths                               # VADeaths は R に組み込みのデータ
?VADeaths

barplot(VADeaths)                      # これだけで単純な棒グラフが作成される
?barplot                               # barplot() 関数のヘルプ 
# 必要があれば，色を指定できる
barplot(VADeaths,                      # 色は数値でも，英語名でも指定可能
         col = c("lightblue", "mistyrose", "lightcyan",
                  "lavender", "cornsilk") )
?colors                                # colors についてヘルプを見る

barplot(VADeaths, beside = TRUE)       # 横に並べ直す
barplot(VADeaths, beside = TRUE, legend =  rownames(VADeaths))  # 凡例を付加する

# 続けてメインタイトルを付加する
title(main = "Death Rates in Virginia", 
        font.main = 4,                 # 字体の指定
        cex = 1.2)                     # タイトルの文字サイズを変える

#
?title                                 # title のヘルプを見る




matplot(VADeaths, type = "l")                #  type = "l" は線 (line)
legend.xy <- locator(1)                       # マウスを使って座標を得る
 # 
 #  この間にグラフィックス上の任意の場所をクリックする
 #
legend(legend.xy$x, legend.xy$y,            # 取得した座標を使って凡例を追加
       legend =  colnames(VADeaths),        # データの列名
       col = 1:4, lty = 1:4)                # 色と線種を番号で指定


matplot(VADeaths, type = "l",col = c(1,2,4,5) , lty = c(1,2,4,5))                #  type = "l" は線 (line)
# legend.xy <- locator(1)                       # マウスを使って座標を得る
 # 
 #  この間にグラフィックス上の任意の場所をクリックする
 #
legend(legend.xy$x, legend.xy$y,            # 取得した座標を使って凡例を追加
       legend =  colnames(VADeaths),        # データの列名
       col = c(1,2,4,5) , lty = c(1,2,4,5)) # 色と線種を番号で指定





plot(1:10, col = 1)
plot(1:10, col = 2., type = "l", lty = 2)


y <- rnorm(1000, mean = 50, sd = 10)
hist(y)

# 試しに平均と標準偏差を求めてみる
mean(y)        # 乱数なので正確に 50 になるわけではない
sd(y)



cars     # cars は 速度と停止までの時間を表す
plot(cars)     # もっとも単純な方法
title(main = "cars data")


# 散布図．以下の操作は plot 関数のヘルプに基づく
head(cars)     # cars は R に組み込まれている関数で，速度と停止までの時間を表す
plot(cars)     # もっとも単純な方法
title(main = "cars data")                     # 図を作成後，タイトルを加える



## プログラミング技法
# 条件分岐
x <- 1
if (x == 1) { 
print("x は 1 ")
} else {
print("x は 1 ではない")
}

x <- 1
if(x < 0){
  "x は 0より小さい"
} else if(x == 0){
  "x は 0 です"  
} else{
   "x は 0 より大きい"
}




# 繰り返し（ループ）
# for 構文の例
x <- c("A","B","C") #
for(i in 1:length(x)){
	     print(x[i])
	 }


## 関数を自作する
myfunc <- function(a,b){
  a+b
}

myfunc(2,3)

myfunc("AB", "CD")

myfunc <- function(a,b){
  paste(a, b, sep= "")
}
myfunc("AB", "CD")




## R での文字列処理

texts <- "Text Mining by R"
nchar(texts)

texts.jp <- "R によるテキストマイニング"
nchar(texts.jp)

substring(texts,1,3)

strsplit(texts, " ")
unlist( strsplit(texts, " "))

texts <- "Text   Mining 	by R"
unlist( strsplit(texts, " "))

unlist( strsplit(texts, " +"))



texts <- "Text   Mining by R"



texts <- "R is a free software environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows and MacOS."

unlist( strsplit(texts, "[[:space:]]+|[[:punct:]]+"))



# ルイス・キャロルのテキストを読み込む

text.raw <- readLines("alice.txt")
text.vec <-  unlist(strsplit(text.raw, split = "[[:blank:]]|[[:punct:]]"))


# 分割結果が空の場合 ("") となる結果を除いて，ベクトルを再構成

text.vec <- text.vec[text.vec != ""]

# 解析結果の長さ，つまり総単語数を求める

length(text.vec)

# the の頻度を数える

sum(text.vec == "the")

# 重複を除いた総単語数，つまり語彙数を求める

length(unique(text.vec))







####################################################
#                                                  #
#                                                  #
#        第５章　RMeCabによるテキスト解析          #
#                                                  #
#                                                  #
####################################################


 
## テキスト59ページのユーザー辞書の作成方法は Windows を対象とした説明です．
## Mac および Linux では http://mecab.sourceforge.net/dic.html の説明に従ってください．一部を以下の引用いたします．

##     * 適当なディレクトリに移動 (例: /home/foo/bar)
##     * foo.csv という辞書ファイルを作成（例はテキスト58ページのishida.csv）
##     * 辞書のコンパイル

## 
## E:\tmp>"c:\Program Files (x86)\MeCab\bin\mecab-dict-index.exe" -d "C:\Program Files (x86)\MeCab\dic\ipadic" -u ishida.dic -f SJIS -t SJIS ishida.csv
## reading ishida.csv ... 1
## emitting double-array: 100% |###########################################|

## done!

## E:\tmp>

##           o -d DIR: システム辞書があるディレクトリ
##           o -u FILE: FILE というユーザファイルを作成
##           o -f charset: CSVの文字コード
##           o -t charset: バイナリ辞書の文字コード 
##     * ishida.dic ができていることを確認
##     * C:\Program Files (x86)\MeCab\dic\ipadic
##       userdic =  C:\Users\ishida\ishida.dic 




library(RMeCab)



## RMeCabC 関数
res <- RMeCabC("すもももももももものうち")
res

res <- RMeCabC("石田基広")
res


## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
 res <- RMeCabC("石田基広", dic = "C:/Users/ishida/ishida.dic")
## res




res <- RMeCabC("すもももももももものうち")
res
res <- RMeCabC("Aを1個食べたいな")
res

res <- RMeCabC("ご飯を食べた", 1)
unlist(res)

res <- RMeCabC("ご飯を食べた", 0)
unlist(res)



res <- RMeCabC("すもももももももものうち")
  # Encoding( names(res[[1]]) )

res2 <- unlist(res)
res2


res2[names(res2) == "名詞"]


res3 <- names(res2) == "名詞"

   which(res3)
   any(res3)




##############################################################################
## RMeCabText 関数 # ファイルから読み込む
# setwd("C:/data") # Windows
# setwd("/Users/ishidamotohiro/data") # Mac OS X

res <- RMeCabText("yukiguni.txt")
res

## [[1]]
##  [1] "国境"       "名詞"       "一般"       "*"          "*"         
##  [6] "*"          "*"          "国境"       "コッキョウ" "コッキョー"

## [[2]]
##  [1] "の"     "助詞"   "格助詞" "一般"   "*"      "*"      "*"      "の"    
##  [9] "ノ"     "ノ"    

## [[3]]
##  [1] "長い"             "形容詞"           "自立"             "*"               
##  [5] "*"                "形容詞・アウオ段" "基本形"           "長い"            
##  [9] "ナガイ"           "ナガイ"          
## ... 以下略






## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
res <- RMeCabText("yukiguni.txt", dic = "C:/Users/ishida/ishida.dic")
res



## ベクトルをファイルに偽装する方法

td <- tempfile("tmp")
 write( "私は真面目な学生です。",  file = td)
# library(RMeCab)
test <- RMeCabText(td)
test

dummy <- c ("私は真面目な学生です。", "彼女は数学専攻の学生です。", "すももももももものうち")
dummyList <- list (length (dummy))
td <- tempfile("tmp")

for (i in   seq(dummy) ){                
  write( dummy [i] ,  file = td)# paste(td, "D1", sep="/") )
  dummyList [[i]] <- RMeCabText(td)
}

dummyList 
unlink (td)

##############################################################################
## RMeCabFreq 関数 ## 頻度表の作成

res <- RMeCabFreq("yukiguni.txt")
res

##        Term  Info1    Info2 Freq
## 1      ある 助動詞        *    1
## 2        た 助動詞        *    3
## 3        だ 助動詞        *    1
## 4        と   助詞 接続助詞    1
## 5        が   助詞   格助詞    2
## 6        に   助詞   格助詞    1
## 7        の   助詞   格助詞    1
## 8        を   助詞   格助詞    1
## 9        の   助詞   連体化    1
## 10     なる   動詞     自立    1
## 11   抜ける   動詞     自立    1
## 12   止まる   動詞     自立    1
## 13 トンネル   名詞     一般    1
## 14     信号   名詞     一般    1
## 15     国境   名詞     一般    1
## 16       底   名詞     一般    1
## 17     汽車   名詞     一般    1
## 18     雪国   名詞     一般    1
## 19       夜   名詞 副詞可能    1
## 20       所   名詞     接尾    1
## 21     白い 形容詞     自立    1
## 22     長い 形容詞     自立    1
## 23       。   記号     句点    3

# 品詞(Info1)情報でデータをまとめる
res2 <- aggregate(res$Freq, res[1:2], sum)

pt1 <- proc.time()
res <- RMeCabFreq("kumo.txt")
pt2 <- proc.time()
pt2 - pt1

res # 結果を確認



## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux


# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
#res <- RMeCabFreq("yukiguni.txt", dic = "C:/Users/ishida/ishida.dic")
# res



RMeCabC("何とも云えない")

## [[1]]
##     副詞 
## "何とも" 

## [[2]]
##   動詞 
## "云え" 

## [[3]]
## 形容詞 
## "ない" 







##############################################################################
## RMeCabDF 関数 ###　データファイルの解析

dat <- read.csv("photo.csv")

colnames(dat)
res <- RMeCabDF(dat, 3) #res <- RMeCabDF(dat, "Reply") # に同じ
length(res)

res

## [[1]]
##   名詞   動詞   助詞   動詞   助詞 
## "写真" "とっ"   "て" "くれ"   "よ" 

## [[2]]
##       名詞       動詞       助詞       動詞 
##     "写真"     "とっ"       "て" "ください" 

## [[3]]
##   名詞   動詞   助詞   助詞 
## "写真" "とっ"   "て"   "ね" 

## [[4]]
##       名詞       動詞       助詞       動詞 
##     "写真"     "とっ"       "て" "ください" 

## [[5]]
##   名詞   動詞   助詞 助動詞 
## "写真" "とっ"   "て" "っす" 

## 活用形は原型にする

res <- RMeCabDF(dat, 3, 1) #res <- RMeCabDF(dat, "Reply", 1) #  に同じ
length(res)

res

## [[1]]
##     名詞     動詞     助詞     動詞     助詞 
##   "写真"   "とる"     "て" "くれる"     "よ" 

## [[2]]
##       名詞       動詞       助詞       動詞 
##     "写真"     "とる"       "て" "くださる" 

## [[3]]
##   名詞   動詞   助詞   助詞 
## "写真" "とる"   "て"   "ね" 

## [[4]]
##       名詞       動詞       助詞       動詞 
##     "写真"     "とる"       "て" "くださる" 

## [[5]]
##   名詞   動詞   助詞 助動詞 
## "写真" "とる"   "て" "っす" 



## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
# res <- RMeCabDF(dat, 3, 1, dic = "C:/Users/ishida/ishida.dic" ) #res <- RMeCabDF(dat, "Reply", 1) #  に同じ
# length(res)
# res







##############################################################################
## docMatrix 関数 ### ターム・文章行列作成
  library(RMeCab)
# <2009 May 23> 付属の doc フォルダ内の三つのファイルの内容を変更しました </2009 May 23>
# setwd("C:/data") # Windows
# setwd("/Users/ishidamotohiro/data") # Mac OS X

res <- docMatrix("doc") ## デフォルトの出力は"名詞","形容詞"，pos = c("名詞","形容詞") を指定したと同じ

res

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        6        8        9
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   難しい                  0        0        1
 
res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"))
res

## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        6        8        9
##   は                      1        1        1
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   の                      0        1        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   で                      0        0        1
##   を                      0        0        1
##   難しい                  0        0        1

res <- res[ row.names(res) !=  "[[LESS-THAN-1]]" , ]
res <- res[ row.names(res) !=  "[[TOTAL-TOKENS]]" , ]
res

##         docs
## terms    doc1.txt doc2.txt doc3.txt
##   は            1        1        1
##   学生          1        1        0
##   私            1        0        0
##   真面目        1        0        0
##   の            0        1        0
##   科            0        1        0
##   数学          0        1        1
##   彼女          0        1        1
##   良い          0        1        0
##   で            0        0        1
##   を            0        0        1
##   難しい        0        0        1

res <- res[ rowSums(res) >= 2, ] # 全テキストでの累計が2以上のタームのみ
res

##       docs
## terms  doc1.txt doc2.txt doc3.txt
##   は          1        1        1
##   学生        1        1        0
##   数学        0        1        1
##   彼女        0        1        1



res <- docMatrix("doc", pos = c("名詞","形容詞"), minFreq = 2)
res ## 単独で頻度2以上のタームはないので合計表のみ出力される

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-2]]         3        5        3
##   [[TOTAL-TOKENS]]        6        8        9


## 別のファイル集合

res <- docMatrix("morikita")#  pos = c("名詞","形容詞")
res

## 情報行を削除する
res <- res[row.names(res) != "[[LESS-THAN-1]]" , ]
res <- res[row.names(res) != "[[TOTAL-TOKENS]]" , ]

## 文書全体を通しての頻度が ２ 以上のターム抽出
res <- res[rowSums(res) >= 2, ]
res

#        docs
#terms    morikita1.txt morikita2.txt morikita3.txt
#  家                 1             1             0
#  学                 1             0             2
#  系                 1             0             1
#  研究               1             1             1
#  者                 1             5             2
#  出版               2             0             1
#  小社               1             0             1
#  専門               2             0             1
#  方々               1             1             0
#  理工               1             0             2
#  技術               0             1             1
#  著者               0             2             0
#  編集               0             2             0
#  皆さん             0             0             2
#  書籍               0             0             2

res <- docMatrix("morikita", pos = c("名詞"), minFreq = 2 )
res

#                  docs
#terms              morikita1.txt morikita2.txt morikita3.txt
#  [[LESS-THAN-2]]             18            18            21
#  [[TOTAL-TOKENS]]            42            60            77
#  出版                         2             0             0
#  専門                         2             0             0
#  者                           0             5             2
#  著者                         0             2             0
#  編集                         0             2             0
#  皆さん                       0             0             2
#  学                           0             0             2
#  書籍                         0             0             2
#  理工                         0             0             2

## 記号を含める

 ##### <2009 04 21 RMeCab_0.81 にて改訂>
  # sym 引数は廃止し kigo 引数としました
 ##### </ 以上 2009 04 21 RMeCab_0.81 にて改訂>

res <- docMatrix("doc",kigo = 1) # TOTAL に記号の数を含めている
res

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        7        9       10 # ここが違う
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   難しい                  0        0        1


## 記号を含めない

res <- docMatrix("doc", kigo = 0)
res

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        6        8        9 #  ここが違う
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   難しい                  0        0        1



res <- docMatrix("doc", pos = c("名詞","形容詞","記号")) # 「ターム」として記号を含める
res  # kigo = 1 は自動的にセットされる

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        7        9       10
##   。                      1        1        1
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   難しい                  0        0        1


## 重みを加える

res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"), weight = "tf*idf")
res

##         docs
## terms    doc1.txt doc2.txt doc3.txt
##   は     1.000000 1.000000 1.000000
##   学生   1.584963 1.584963 0.000000
##   私     2.584963 0.000000 0.000000
##   真面目 2.584963 0.000000 0.000000
##   の     0.000000 2.584963 0.000000
##   科     0.000000 2.584963 0.000000
##   数学   0.000000 1.584963 1.584963
##   彼女   0.000000 1.584963 1.584963
##   良い   0.000000 2.584963 0.000000
##   で     0.000000 0.000000 2.584963
##   を     0.000000 0.000000 2.584963
##   難しい 0.000000 0.000000 2.584963


## 重みを加えて標準化

res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"), weight = "tf*idf*norm")
res

##         docs
## terms     doc1.txt  doc2.txt  doc3.txt
##   は     0.2434238 0.1870469 0.1958515
##   学生   0.3858176 0.2964624 0.0000000
##   私     0.6292414 0.0000000 0.0000000
##   真面目 0.6292414 0.0000000 0.0000000
##   の     0.0000000 0.4835093 0.0000000
##   科     0.0000000 0.4835093 0.0000000
##   数学   0.0000000 0.2964624 0.3104173
##   彼女   0.0000000 0.2964624 0.3104173
##   良い   0.0000000 0.4835093 0.0000000
##   で     0.0000000 0.0000000 0.5062688
##   を     0.0000000 0.0000000 0.5062688
##   難しい 0.0000000 0.0000000 0.5062688

colSums(res^2)  #各列とも二乗の合計は１

##  データに NA が含まれる場合や，minFreq 引数に 2 以上を指定した場合は出力には NA が含まれるので注意



## co 引数はタームの共起行列を作成する．下記の例を参照．2009 年 ３月実装
## テキストに記載はありません．
## ############### 共起行列を返す
### 共起行列の作成は，非常にメモリを喰います．
### 例えば本書付属の wrinters フォルダから行列を作成する際，
### 同時に co 引数で共起行列への変換を指定すると
### １GB 程度のメモリのマシンではフリーズすることもあります．

## テキストの分量が大きく，行列が大きくなる場合は
## Matrix パッケージを利用した sparse 行列への変換をおすすめします
## 以下に例があります


## 行名のタームと列名のタームが共起した回数
## 対称行列


res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"), co = 1)
nrow(res); ncol(res)
res

##         terms
## terms    は 学生 私 真面目 の 科 数学 彼女 良い で を 難しい
##   は      3    2  1      1  1  1    2    2    1  1  1      1
##   学生    2    2  1      1  1  1    1    1    1  0  0      0
##   私      1    1  1      1  0  0    0    0    0  0  0      0
##   真面目  1    1  1      1  0  0    0    0    0  0  0      0
##   の      1    1  0      0  1  1    1    1    1  0  0      0
##   科      1    1  0      0  1  1    1    1    1  0  0      0
##   数学    2    1  0      0  1  1    2    2    1  1  1      1
##   彼女    2    1  0      0  1  1    2    2    1  1  1      1
##   良い    1    1  0      0  1  1    1    1    1  0  0      0
##   で      1    0  0      0  0  0    1    1    0  1  1      1
##   を      1    0  0      0  0  0    1    1    0  1  1      1
##   難しい  1    0  0      0  0  0    1    1    0  1  1      1
## 上記のコードと同じことをより効率的，高速に行うには

 library(Matrix)# Matrix パッケージを利用した sparse 行列への変換

 res0 <- docMatrix("doc", pos = c("名詞","形容詞","助詞"))
 res0 <- res0[ row.names(res0) !=  "[[LESS-THAN-1]]" , ]
 res0 <- res0[ row.names(res0) !=  "[[TOTAL-TOKENS]]" , ]
 res0 <- Matrix((res0 > 0) * 1) # 
    # res1 <- crossprod( ( t(res0) > 0) *1  )
 res1 <- tcrossprod( res0 )
 nrow(res1); ncol(res1)

all(res == res1)  #  一致を確認



### 行名のタームと列名のタームが共起したか (1) 否 (0) か
## 対称行列

res <- docMatrix("morikita", pos = c("名詞","形容詞","助詞"), co = 2)
# head(res0)

res # コンソールが埋まってしまうので注意！


## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
# res <- docMatrix("doc", dic = "C:/Users/ishida/ishida.dic") ## 
# trace(docMatrix, edit =T)

  ##  ##### <2009 04 21 RMeCab_0.81 にて改訂> 廃止しました
  ## # 行名のタームに対して，列名のタームが出現した回数
  ## ## 対称行列とは限らない
  ## ## 計算量が多くなるので注意してください
  ## res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"), co = 3)
  ## res
  ##  </ 以上 2009 04 21 RMeCab_0.81 にて改訂>




###############################################################
## docMatrix2()関数 # docMatrix()関数の拡張版
## 第 1 引数で指定されたファイル (フォルダが指定された場合は，その中の全ファイル)
## を読み込んで，ターム・文書行列を作成する．
## なお[[LESS-THAN-1]] と [[TOTAL-TOKENS]] の情報行は追加されない 
## 
##   指定可能な引数は
##      directory, pos, minFreq, weight, kigo, co, dic   である．
## directory 引数はファイル名ないしフォルダ名であり
##              (どちらが指定されたかは自動判定される)
## pos 引数は pos = c(``名詞'', ``形容詞'') のように指定する
## minFreq 引数には頻度の閾値を指定するが，docMatrix() 関数の場合とは異なり，
##     全テキストを通じての総頻度を判定対象とする．
##            例えば minFreq=2 と指定した場合，どれか一つの文書で頻度が二つ以上
##            のタームは，これ以外の各文書に一度しか出現していなくとも，
##            出力のターム・文書行列に含まれる． 
##            docMatrix() 関数では，文書のごとの最低頻度であった．
##            したがって，doc1という文書で二度以上出現しているタームが，
##            他の文書で一度しか出現していない場合，このタームは出力の
##            ターム．文書行列に含まれるが，doc1以外の文書の頻度は一律 0 にされる
## kigo 引数は，抽出タームに句読点なので記号を含めるかを指定する．
##            デフォルトでは kigo = 0 とセットされており，
##            記号はカウントされないが，
##            kigo = 1 とすると，記号を含めてカウントした結果が出力される
##            pos 引数に"記号"が含まれている場合自動的に kigo=1 となる．
## co 引数はタームの共起行列を作成する．下記の例を参照．
## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
## [[LESS-THAN-1]]" と [[TOTAL-TOKENS]] の二つの行を含まない

   ## <2009 04 21 RMeCab_0.81 にて改訂>
    #    sym 引数は廃止しました 
   ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>
  
  library(RMeCab)

res <- docMatrix2("doc")

     # res <- docMatrix2("doc", pos = c("名詞","形容詞"), minFreq = 1, kigo = 0, weight = "no") に同じ

res

##        doc1.txt doc2.txt doc3.txt
## 学生          1        1        0
## 彼女          0        1        1
## 数学          0        1        1
## 真面目        1        0        0
## 私            1        0        0
## 科            0        1        0
## 良い          0        1        0
## 難しい        0        0        1


res <- docMatrix2("doc",pos = c("名詞","形容詞","記号") )
res

##        doc1.txt doc2.txt doc3.txt
## 。            1        1        1
## 学生          1        1        0
## 彼女          0        1        1
## 数学          0        1        1
## 真面目        1        0        0
## 私            1        0        0
## 科            0        1        0
## 良い          0        1        0
## 難しい        0        0        1

res <- docMatrix2("kumo.txt", minFreq = 5) 
res

##        kumo.txt
## ない         12
## の           18
## よう         13
## 一            8
## 上            9
## 下            5
## 中            8
## 事           15
## 何            6
## 地獄         13
## 底            8
## 極楽         10
## 様            7
## 糸           14
## 罪人          6
## 自分          6
## 蜘蛛         14
## 血の池        7
## 釈迦          7
## 針            5
## 陀多         17


gc();gc() # メモリを掃除


# 以下時間がかかる処理です
pt1 <- proc.time()
res <- docMatrix2("writers",pos = c("名詞","形容詞","助詞") )
pt2 <- proc.time()

pt2 - pt1


head(res)  # 全体を表示させると画面が埋まってしまいます


## co 引数はタームの共起行列を作成する．下記の例を参照．2009 年 ３月実装
## テキストに記載はありません．
## ############### 共起行列を返す
### 共起行列の作成は，非常にメモリを喰います．
### 例えば本書付属の wrinters フォルダから行列を作成する際，
### 同時に co 引数で共起行列への変換を指定すると
### １GB 程度のメモリのマシンではフリーズすることもあります．

## テキストの分量が大きく，行列が大きくなる場合は
## Matrix パッケージを利用した sparse 行列への変換をおすすめします
## 以下に例があります．

## 行名のタームと列名のタームが共起した回数
## 対称行列

 res <- docMatrix2("morikita", pos = c("名詞","形容詞","助詞"), co = 1)
 nrow(res); ncol(res)
colSums(res); rowSums(res)

 ## 上記のコードと同じことをより効率的，高速に行うには

 library(Matrix)# Matrix パッケージを利用した sparse 行列への変換

 res0 <- docMatrix2("morikita", pos = c("名詞","形容詞","助詞"))
 res0 <- Matrix( (res0 > 0) * 1) #
str(res0)
   #  res1 <- crossprod( (t(res0) > 0) *1  )
 res1 <- tcrossprod( res0 )
 # head(res0)  # コンソールが埋まってしまうので注意！
   nrow(res1); ncol(res1)
   colSums(res1); rowSums(res1)

 all(res == res1)  #  一致を確認


### 行名のタームと列名のタームが共起したか否か
## 対称行列

res <- docMatrix2("morikita", pos = c("名詞","形容詞","助詞"), co = 2)
res



## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
res <- docMatrix2("morikita", pos = c("名詞","形容詞","助詞"), co = 2, dic = "C:/Users/ishida/ishida.dic" )
res



   ## ## <2009 04 21 RMeCab_0.81 にて改訂> 廃止しました
   ## # 行名のタームに対して，列名のタームが出現した回数
   ## ## 対称行列とは限らない
   ## res <- docMatrix2("writers", pos = c("名詞","形容詞","助詞"), co = 3)
   ## res
   ## ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>




##########################################################
## Ngram 関数 ### N-gram の作成


res <- Ngram("yukiguni.txt")
res

#    Ngram Freq
#1  [。-信]    1
#2  [。-夜]    1
#3  [あ-っ]    1
#4  [い-ト]    1
#5  [が-止]    1
#  ... 以下略

res <- Ngram("merosu.txt")
head (res)
# この結果から，読点との組み合わせを取る
# res [grep ("、", res $ Ngram), ]
res2 <- res [grep ("-、]", res $ Ngram), ]
res2

###### res [grep (res $ Ngram %in% c("、]")),] 

res <- Ngram("yukiguni.txt", type = 1) 
res                                    

##             Ngram Freq
## 1 [トンネル-雪国]    1
## 2       [信号-所]    1
## 3 [国境-トンネル]    1
## 4         [夜-底]    1
## 5       [底-信号]    1
## 6       [所-汽車]    1
## 7       [雪国-夜]    1
## ## >   # 以下は以前の出力
## ## #            Ngram Freq
## ## #1 [トンネル-雪国]    1
## ## #2     [国境-長い]    1
## ## #3       [所-汽車]    1
## ## #4       [信号-所]    1
## ## #5       [雪国-夜]    1
## ## #6 [長い-トンネル]    1
## ## #7       [底-白い]    1
## ## #8     [白い-信号]    1
## ## #9         [夜-底]    1

res <- Ngram("yukiguni.txt", type = 2)
res

#             Ngram Freq
#1      [記号-名詞]    2
#2    [形容詞-動詞]    1
#3    [形容詞-名詞]    1
#4    [助詞-形容詞]    2
#5      [助詞-動詞]    2
#6      [助詞-名詞]    3
#7    [助動詞-記号]    3
#8  [助動詞-助動詞]    2
#9      [動詞-助詞]    1
#10   [動詞-助動詞]    2
#11     [名詞-助詞]    6
#12   [名詞-助動詞]    1
#13     [名詞-名詞]    1



# トライグラム

res <- Ngram("yukiguni.txt", type = 2, N = 3)
res

#                    Ngram Freq
#1        [記号-名詞-助詞]    1
#2        [記号-名詞-名詞]    1
#3    [形容詞-動詞-助動詞]    1
#4      [形容詞-名詞-助詞]    1
#5      [助詞-形容詞-動詞]    1
#6      [助詞-形容詞-名詞]    1
#7        [助詞-動詞-助詞]    1
#8      [助詞-動詞-助動詞]    1
#9        [助詞-名詞-助詞]    2
#10     [助詞-名詞-助動詞]    1
#11     [助動詞-記号-名詞]    2
#12   [助動詞-助動詞-記号]    1
#13 [助動詞-助動詞-助動詞]    1
#14       [動詞-助詞-名詞]    1
#15     [動詞-助動詞-記号]    2
#16     [名詞-助詞-形容詞]    2
#17       [名詞-助詞-動詞]    2
#18       [名詞-助詞-名詞]    2
#19   [名詞-助動詞-助動詞]    1
#20       [名詞-名詞-助詞]    1


res <- Ngram("yukiguni.txt", type = 1, pos = "名詞")
res

#             Ngram Freq
# 1 [トンネル-雪国]    1
# 2 [国境-トンネル]    1
# 3       [所-汽車]    1
# 4       [信号-所]    1
# 5       [雪国-夜]    1
# 6       [底-信号]    1
# 7         [夜-底]    1





## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
## res <- Ngram("yukiguni.txt", type = 1, pos = "名詞"  , dic ="C:/Users/ishida/ishida.dic")
## res
#





###################### NgramDF 関数 ### N-gram の作成

# 同じ処理結果をデータフレームとして返す

res <- NgramDF("yukiguni.txt", type = 1, N = 2)
res

##     Ngram1   Ngram2 Freq
## 1 トンネル     雪国    1
## 2     信号       所    1
## 3     国境     長い    1
## 4       夜       底    1
## 5       底     白い    1
## 6       所     汽車    1
## 7     白い     信号    1
## 8     長い トンネル    1
## 9     雪国       夜    1

res <- NgramDF("yukiguni.txt", type = 1, N = 2, pos = "名詞")
nrow(res)  ## 書籍とはターム数が異なっている場合があります．
res

#    Ngram1   Ngram2 Freq
#1 トンネル     雪国    1
#2     国境 トンネル    1
#3       所     汽車    1
#4     信号       所    1
#5     雪国       夜    1
#6       底     信号    1
#7       夜       底    1


res <- NgramDF("yukiguni.txt", type = 1, N = 2, pos = c("名詞","形容詞","助詞"))
nrow(res)  ## 書籍とはターム数が異なっている場合があります．
res

##      Ngram1   Ngram2 Freq
## 1        が     白い    1
## 2        と     雪国    1
## 3        に     汽車    1
## 4        の       底    1
## 5        の     長い    1
## 6        を       と    1
## 7  トンネル       を    1
## 8      信号       所    1
## 9      国境       の    1
## 10       夜       の    1
## 11       底       が    1
## 12       所       に    1
## 13     汽車       が    1
## 14     白い     信号    1
## 15     長い トンネル    1
## 16     雪国       夜    1


res <- NgramDF("yukiguni.txt", type = 2, N = 2)
res

##   Ngram1 Ngram2 Freq
## 1  助動詞 助動詞    2
## 2  助動詞   記号    3
## 3    助詞   動詞    2
## 4    助詞   名詞    3
## 5    助詞 形容詞    2
## 6    動詞 助動詞    2
## 7    動詞   助詞    1
## 8    名詞 助動詞    1
## 9    名詞   助詞    6
## 10   名詞   名詞    1
## 11 形容詞   動詞    1
## 12 形容詞   名詞    1
## 13   記号   名詞    2

## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
# res <- NgramDF("yukiguni.txt", type = 1, N = 2, pos = c("名詞","形容詞","助詞") , dic = "C:/Users/ishida/ishida.dic")
# res
#





#######################################################################
## NgramDF2 関数 ### NgramDF()関数の拡張版
## 
##   指定可能な引数は
##      directory, type, pos, minFreq, N, kigo   である．
## directory 引数はファイル名ないしフォルダ名であり
##              (どちらが指定されたかは自動判定される)
## type 引数は　type=0　が文字、type=1　が形態素、type=2　が記号である
## pos 引数は pos = c(``名詞'', ``形容詞'') のように指定する
##       type引数指定が文字 0 あるいは記号 1 の場合は無視される
## minFreq 引数には頻度の閾値を指定するが，docMatrix() 関数の場合とは異なり，
##     全テキストを通じての総頻度を判定対象とする．
##            例えば minFreq=2 と指定した場合，どれか一つの文書で頻度が二つ以上
##            のタームは，これ以外の各文書に一度しか出現していなくとも，
##            出力のターム・文書行列に含まれる． 
##            docMatrix() 関数では，文書のごとの最低頻度であった．
##            したがって，doc1という文書で二度以上出現しているタームが，
##            他の文書で一度しか出現していない場合，このタームは出力の
##            ターム．文書行列に含まれるが，doc1以外の文書の頻度は一律 0 にされる
## N 引数は N-gram　を指定する。上限は設定されていないが、
##         あまり大きな数値を指定すると
##         R の処理能力の限界を超えるので注意されたい
##  kigo 引数は，抽出タームに句読点なので記号を含めるかを指定する．
##            デフォルトでは kigo = 0 とセットされており，
##            記号はカウントされないが，
##            kigo = 1 とすると，記号を含めてカウントした結果が出力される
##            pos 引数に"記号"が含まれている場合自動的に kigo=1 となる．
## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する

  ## <009 04 21 RMeCab_0.81 にて改訂>
   # sym 引数は廃止しました  
  ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>


res <- NgramDF2("yukiguni.txt")
res

##    Ngram1 Ngram2 yukiguni.txt
## 1      。     信            1
## 2      。     夜            1
## 3      あ     っ            1
## 4      い     ト            1
## 5      が     止            1
## 6      が     白            1
## 7      く     な            1
## 8      け     る            1
## 9      た     。            3
## 10     っ     た            3
## ... 以下略

res <- NgramDF2("yukiguni.txt", type = 1)
res

##     Ngram1   Ngram2 yukiguni.txt
## 1 トンネル     雪国            1
## 2     信号       所            1
## 3     国境     長い            1
## 4       夜       底            1
## 5       底     白い            1
## 6       所     汽車            1
## 7     白い     信号            1
## 8     長い トンネル            1
## 9     雪国       夜            1

res <- NgramDF2("yukiguni.txt", type = 1, N = 2, pos = "名詞")
nrow(res)## 書籍とはターム数が異なっている場合があります．
res

##     Ngram1   Ngram2 yukiguni.txt
## 1 トンネル     雪国            1
## 2     国境 トンネル            1
## 3       所     汽車            1
## 4     信号       所            1
## 5     雪国       夜            1
## 6       底     信号            1
## 7       夜       底            1



res <- NgramDF2("yukiguni.txt", type = 1, N = 2, pos = c("名詞","記号"))   
nrow(res)## 書籍とはターム数が異なっている場合があります．
res   

##      Ngram1   Ngram2 yukiguni.txt
## 1        。     信号            1
## 2        。       夜            1
## 3  トンネル     雪国            1
## 4      汽車       。            1
## 5      国境 トンネル            1
## 6        所     汽車            1
## 7      信号       所            1
## 8      雪国       。            1
## 9        底       。            1
## 10       夜       底            1


res <- NgramDF2("doc")
res

##    Ngram1 Ngram2 doc1.txt doc2.txt doc3.txt
## 1      い     ま        0        0        1
## 2      す     ．        1        1        1
## 3      で     い        0        0        1
## 4      で     す        1        1        0
## 5      の     学        0        1        0
## 6      は     学        1        0        0
## 7      は     数        0        1        1
## 8      ま     す        0        0        1
## 9      を     学        0        0        1
## 10     ん     で        0        0        1
## ... 以下略


res <- NgramDF2("doc", type = 2, minFreq = 2)
res

##   Ngram1 Ngram2 doc1.txt doc2.txt doc3.txt
## 1 助動詞   記号        1        1        1
## 2   助詞   動詞        0        0        1
## 3   助詞   名詞        1        1        0
## 4   助詞 形容詞        0        1        1
## 5   名詞 助動詞        1        1        0
## 6   名詞   助詞        1        1        1
## 7 形容詞   名詞        0        1        1





## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
res <- NgramDF2("doc", dic = "C:/Users/ishida/ishida.dic")
res
# 






################### docNgram関数 # N-gram による文書行列
res <-  docNgram("doc", type = 0)
res

##          Text
## Ngram     doc1.txt doc2.txt doc3.txt
##   [い-ま]        0        0        1
##   [す-．]        1        1        1
##   [で-い]        0        0        1
##   [で-す]        1        1        0
##   [の-学]        0        1        0
##   [は-学]        1        0        0
##   [は-数]        0        1        1
##   [ま-す]        0        0        1
##   [を-学]        0        0        1
##   [ん-で]        0        0        1
##   [学-の]        0        1        0
## ... 以下略


res <- docNgram("doc", type = 1)
res

##   [科-良い]            0        1        0
##   [私-真面目]          1        0        0
##   [真面目-学生]        1        0        0
##   [数学-科]            0        1        0
##   [難しい-数学]        0        0        1
##   [彼女-数学]          0        1        0
##   [彼女-難しい]        0        0        1
##   [良い-学生]          0        1        0






################################################################
## docNgram2関数 # N-gram による文書行列
#################### docNgram()関数の拡張版
##  http://rmecab.jp/wiki/index.php?RMeCabFunctions
##   指定可能な引数は
##      directory, type, pos, minFreq, N, kigo   である．
## directory 引数はファイル名ないしフォルダ名であり
##              (どちらが指定されたかは自動判定される)
## type 引数は　type=0　が文字、type=1　が形態素、type=2　が記号である
## pos 引数は pos = c(``名詞'', ``形容詞'') のように指定する
##       type引数指定が文字 0 あるいは記号 1 の場合は無視される
## minFreq 引数には頻度の閾値を指定するが，docMatrix() 関数の場合とは異なり，
##     全テキストを通じての総頻度を判定対象とする．
##          例えば minFreq=2 と指定した場合，どれか一つの文書で頻度が二つ以上
##          のタームは，これ以外の各文書に一度しか出現していなくとも，
##          出力のターム・文書行列に含まれる． 
##          docMatrix() 関数では，文書のごとの最低頻度であった．
##          したがって，doc1という文書で二度以上出現しているタームが，
##          他の文書で一度しか出現していない場合，このタームは出力の
##          ターム．文書行列に含まれるが，doc1以外の文書の頻度は一律 0 にされる
## N 引数は N-gram　を指定する。上限は設定されていないが、あまり大きな数値を指定すると
##      R の処理能力の限界を超えるので注意されたい
## kigo 引数は，抽出タームに句読点なので記号を含めるかを指定する．
##            デフォルトでは kigo = 0 とセットされており
##            pos 引数に"記号"が含まれている場合自動的に kigo=1 となる．
## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する

  ## <2009 04 21 RMeCab_0.81 にて改訂>
   #  sym 引数は廃止しました
  ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>


res <- docNgram2("doc")
res

##         doc1.txt doc2.txt doc3.txt
## [い-ま]        0        0        1
## [す-．]        1        1        1
## [で-い]        0        0        1
## [で-す]        1        1        0
## [の-学]        0        1        0
## [は-学]        1        0        0
## [は-数]        0        1        1
## [ま-す]        0        0        1
## [を-学]        0        0        1
## [ん-で]        0        0        1
## [学-の]        0        1        0
## ... 以下略


res <- docNgram2("doc", pos = c("名詞","形容詞"), type = 1)
res

##               doc1.txt doc2.txt doc3.txt
## [彼女-数学]          0        1        0
## [彼女-難しい]        0        0        1
## [数学-科]            0        1        0
## [真面目-学生]        1        0        0
## [私-真面目]          1        0        0
## [科-良い]            0        1        0
## [良い-学生]          0        1        0
## [難しい-数学]        0        0        1



res <- docNgram2("doc", type = 1, pos = c("名詞","形容詞","記号"))
res

##               doc1.txt doc2.txt doc3.txt
## [学生-。]            1        1        0
## [彼女-数学]          0        1        0
## [彼女-難しい]        0        0        1
## [数学-。]            0        0        1
## [数学-科]            0        1        0
## [真面目-学生]        1        0        0
## [私-真面目]          1        0        0
## [科-良い]            0        1        0
## [良い-学生]          0        1        0
## [難しい-数学]        0        0        1


res <- docNgram2("doc", type = 2)
res

##               doc1.txt doc2.txt doc3.txt
## [助動詞-名詞]        1        0        0
## [助動詞-記号]        1        1        1
## [助詞-動詞]          0        0        1
## [助詞-名詞]          1        1        0
## [助詞-形容詞]        0        1        1
## [動詞-助動詞]        0        0        1
## [動詞-助詞]          0        0        1
## [名詞-助動詞]        1        1        0
## [名詞-助詞]          1        1        1
## [名詞-名詞]          0        1        0
## [形容詞-名詞]        0        1        1



res <- docNgram2("doc", pos = c("名詞","記号"), kigo = 1, type = 1) # doc はフォルダ名

  ## <2009 04 21 RMeCab_0.81 にて改訂>
   # sym 引数は廃止しました
  ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>

nrow(res)## 書籍とはターム数が異なっている場合があります．
res

##               doc1.txt doc2.txt doc3.txt
## [学生-。]            1        1        0
## [彼女-数学]          0        1        1
## [数学-。]            0        0        1
## [数学-科]            0        1        0
## [真面目-学生]        1        0        0
## [私-真面目]          1        0        0
## [科-学生]            0        1        0


res <- docNgram2("doc", pos = c("名詞","記号"), type = 1, weight = "tf*idf*norm") # doc はフォルダ名
nrow(res)
res

##                doc1.txt doc2.txt  doc3.txt
## [学生-。]     0.5773503      0.5 0.0000000
## [彼女-数学]   0.0000000      0.5 0.7071068
## [数学-。]     0.0000000      0.0 0.7071068
## [数学-科]     0.0000000      0.5 0.0000000
## [真面目-学生] 0.5773503      0.0 0.0000000
## [私-真面目]   0.5773503      0.0 0.0000000
## [科-学生]     0.0000000      0.5 0.0000000

colSums(res^2) #各列とも二乗の合計は１

##  データに NA が含まれる場合や，minFreq 引数に 2 以上を指定した場合は出力には NA が含まれるので注意




## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
# res <- docNgram2("doc", pos = c("名詞","記号"), type = 1, weight = "tf*idf*norm"  , dic ="C:/Users/ishida/ishida.dic") # doc はフォルダ名
# res


#############################################################
##  #docMatrixDF() 関数
##### データフレームから文書・ターム行列を作成する


  library(RMeCab)

targetText <- "photo.csv" #<2009 05 23>  ファイルの中身を一部変えました</2009 05 23>

dat <- read.csv(targetText, head = T)

# 男性の被験者だけを見る
dat[dat$Sex == "M",]

res <- docMatrixDF(dat[,"Reply"]) # デフォルトでは名詞と形容詞のみ
res

##        OBS.1 OBS.2 OBS.3 OBS.4 OBS.5
## 写真       1     1     1     1     1
# 大きい     0     0     1     0     0



res <- docMatrixDF(dat[,"Reply"], pos = c("名詞","動詞"))
res

##          OBS.1 OBS.2 OBS.3 OBS.4 OBS.5
## くださる     0     1     0     1     0
## くれる       1     0     0     0     0
## とる         1     1     1     1     1
## 写真         1     1     1     1     1



### テキスト（被験者）全体を通じて，総頻度が ２ 以上のタームを抽出
## ここで総頻度とは、各タームごとに、各文書での出現した頻度を合計した頻度をいう

res <- docMatrixDF(dat[,"Reply"], pos = c("名詞","動詞"), minFreq = 2)
res

##          OBS.1 OBS.2 OBS.3 OBS.4 OBS.5
## くださる     0     1     0     1     0
## とる         1     1     1     1     1
## 写真         1     1     1     1     1


res <- docMatrixDF(dat[,"Reply"], pos = c("名詞","動詞"), minFreq = 2, weight = "tf*idf*norm")
res

##              OBS.1     OBS.2     OBS.3     OBS.4     OBS.5
## くださる 0.0000000 0.8540570 0.0000000 0.8540570 0.0000000
## とる     0.7071068 0.3678223 0.7071068 0.3678223 0.7071068
## 写真     0.7071068 0.3678223 0.7071068 0.3678223 0.7071068

## 文書に NA がある場合や，minFreq を 2以上に指定した場合，
## 頻度に 0 のセルがありうるので，出力に NA が含まれることがあります 


## co 引数はタームの共起行列を作成する．下記の例を参照．2009 年 ３月実装
## テキストに記載はありません．
## ############### 共起行列を返す
### 共起行列の作成は，非常にメモリを喰います．
### 例えば本書付属の wrinters フォルダから行列を作成する際，
### 同時に co 引数で共起行列への変換を指定すると
### １GB 程度のメモリのマシンではフリーズすることもあります．

## テキストの分量が大きく，行列が大きくなる場合は
## Matrix パッケージを利用した sparse 行列への変換をおすすめします
## docMatrix() 関数や docDF() 関数に実行例があります


## 行名のタームと列名のタームが共起した回数
## 対称行列

res <- docMatrixDF(dat[,"Reply"],  pos = c("名詞","動詞"),co = 1)
res

##          くださる くれる とる 写真
## くださる        2      0    2    2
## くれる          0      1    1    1
## とる            2      1    5    5
## 写真            2      1    5    5

### 行名のタームと列名のタームが共起したか否か
## 対称行列

res <- docMatrixDF(dat[,"Reply"],   pos = c("名詞","動詞"),co = 2)
res

##          くださる くれる とる 写真
## くださる        1      0    1    1
## くれる          0      1    1    1
## とる            1      1    1    1
## 写真            1      1    1    1



## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
res <- docMatrixDF(dat[,"Reply"],   pos = c("名詞","動詞"),co = 2 , dic = "C:/Users/ishida/ishida.dic" )
res
# 


   ## <廃止しました>
   ## # 行名のタームに対して，列名のタームが出現した回数
   ## ## 対称行列とは限らない
   ## res <- docMatrixDF(dat[,"Reply"], co = 3)
   ## res
   ## </廃止しました>





#############################################################
##  #docNgramDF() 関数  ## テキストには記載はありません．
##### データフレームの指定列から文字あるいはタームのNgram頻度行列を作成する


 library(RMeCab)


## 出力が他の関数と異なり，行に文書（被験者回答）列にタームとなっている．
## type = 1 の場合，デフォルトでは "名詞","形容詞" を抽出

targetText <- "H18koe.csv"

dat <- read.csv(targetText, head = T)

# 最初の２行
dat[1:2,]

res <- docNgramDF(dat[,"opinion"])
nrow(res);ncol(res)
res[1:10, 1000:1005]

##       [障] [集] [雑] [離] [難] [雨]
## Row1     0    0    0    0    0    0
## Row2     0    0    0    0    1    0
## Row3     0    0    0    0    0    0
## Row4     0    0    0    0    0    0
## Row5     0    0    0    0    0    0
## Row6     0    0    0    0    0    0
## Row7     0    0    0    0    0    1
## Row8     0    0    0    0    0    0
## Row9     0    0    0    0    0    0
## Row10    0    0    0    0    0    0

res <- docNgramDF(dat[, "opinion"], N = 2)
nrow(res);ncol(res)
res[1:10, 1000:1005]

##       [が-楽] [が-標] [が-殆] [が-残] [が-気] [が-永]
## Row1        0       0       0       0       0       0
## Row2        0       0       0       0       0       0
## Row3        0       0       0       0       0       0
## Row4        0       0       0       0       0       0
## Row5        0       0       0       0       0       0
## Row6        0       0       0       0       0       0
## Row7        0       0       0       0       0       0
## Row8        0       0       0       0       0       0
## Row9        0       0       0       0       0       0
## Row10       0       0       0       0       0       0
## 

res <- docNgramDF(dat[,"opinion"], type = 1)
nrow(res);ncol(res)
res[1:10, 1000:1005]

##       [浴衣] [海] [海中] [海外] [海岸] [海底]
## Row1       0    0      0      0      1      0
## Row2       0    0      0      0      0      0
## Row3       0    0      0      0      0      0
## Row4       0    0      0      0      0      0
## Row5       0    0      0      0      0      0
## Row6       0    0      0      0      0      0
## Row7       0    1      0      0      0      0
## Row8       0    0      0      0      0      0
## Row9       0    0      0      0      0      0
## Row10      0    0      0      0      0      0




res <- docNgramDF(dat[,"opinion"], type = 1, N = 2)
nrow(res);ncol(res)
res[1:3, 1000:1003]

##     [バイキング-どれ] [バイキング-以外] [バイキング-朝] [バイク-多い]
## Row1                 0                 0               0             0
## Row2                 0                 0               0             0
## Row3                 0                 0               0             0

res <- docNgramDF(dat[,"opinion"], pos = "名詞", type = 1, N = 3, weight = "tf*idf*norm")
nrow(res);ncol(res)
res[1:3, 100:102]

##      [いつ-開発-自然] [いつ-風景-生活] [いつか-ツケ-沖縄]
## Row1                0                0                  0
## Row2                0                0                  0
## Row3                0                0                  0

rowSums(res^2 , na.rm = T) # 行（文書・被験者回答）の合計は １

##  データに NA が含まれる場合や，minFreq 引数に 2 以上を指定した場合は出力には NA が含まれるので注意



## dic 引数にユーザーが独自に作成した辞書を指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
res <- docNgramDF(dat[,"opinion"], type = 1, N = 2 , dic = "C:/Users/ishida/ishida.dic")
nrow(res);ncol(res)
res[1:3, 1000:1003]
#

#################################################
## collocate関数 ## 共起
# node 引数で指定された語(ただし形態素原形)の前後に出てくる単語頻度を計算する．
# 記号を除いてすべてのタームを抽出します
# なおスパンは引数 span で指定する

res <- collocate("kumo.txt", node = "極楽", span =3)
nrow(res)

##            Term Before After Span Total
## 1            、      2     0    2   136
## 2            。      4     0    4    61
## 3            う      1     0    1     9
## 4            が      0     1    1    34
## 5          この      1     0    1    11
## 6        しかし      2     0    2     2
## 7            た      1     0    1    51
## 8          ただ      1     0    1     4
## 9            と      2     1    3    43
## 10           に      2     0    2    73
## 11           の      0    12   12   117
## 12           は      3     1    4    46
## 13       はいる      0     1    1     1
## 14           へ      0     1    1    19
## 15         ます      2     0    2    69
## 16           も      0     1    1    21
## 17         もう      0     1    1     5
## 18         丁度      0     1    1     3
## 19           上      1     0    1     9
## 20           事      0     1    1    15
## 21           午      0     1    1     1
## 22         地獄      1     0    1    13
## 23         居る      2     0    2     7
## 24           朝      0     1    1     1
## 25         極楽     10     0   10    10
## 26           様      2     0    2     7
## 27         蓮池      0     4    4     4
## 28         蜘蛛      0     2    2    14
## 29         行く      1     0    1     4
## 30         釈迦      2     0    2     7
## 31           間      0     1    1     3
## 32 [[MORPHEMS]]     18    13   31   413
## 33   [[TOKENS]]     40    30   70  1808

sum(res$Before[1:31] > 0) 
# [1] 18  出現した形態素 [[MORPHEMS]] type の数
 sum(res$Before[1:31])
#[1] 40  出現した語数 [[TOKENS]]   token の数
sum(res$After[1:31])
# [1] 30

#  Total は対象テキスト全体に表われた回数，すなわち総頻度
#  Total  [[MORPHEMS]] はテキスト全体の形態素数
#  Total  [[TOKENS]]  はテキスト全体の総語数






## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux


# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
res <- collocate("kumo.txt", node = "極楽", span =3, dic = "C:/Users/ishida/ishida.dic")
res
# 



########### collScores関数 ## T 値，MI 値
# collocate() 関数の出力であるオブジェクト を第 1 引数として，
# collocate() 関数で指定した中心語を node 引数に，同じく span に前後の語数を指定する．

res2 <- collScores(res, node  = "極楽", span =3)
nrow(res2)
res2[25:nrow(res),]

##            Term Span Total         T       MI
## 25         極楽   10    10        NA       NA
## 26           様    2     7 1.2499520 3.105933
## 27         蓮池    4     4 1.9336283 4.913288
## 28         蜘蛛    2    14 1.0856905 2.105933
## 29         行く    1     4 0.8672566 2.913288
## 30         釈迦    2     7 1.2499520 3.105933
## 31           間    1     3 0.9004425 3.328326
## 32 [[MORPHEMS]]   31   413        NA       NA
## 33   [[TOKENS]]   70  1808        NA       NA


log2( 4 / ((4/1808) * 10 * 3 * 2))



  res <- collocate("kumo.txt", node = "極楽", span =5)
  res

  ## ...
  ## 44         蓮池    4     4
  ## 45         蜘蛛    2    14
  ## 46         行く    1     4
  ## 47         近く    1     1
  ## 48         釈迦    2     7
  ## 49           間    1     3
  ## 50 [[MORPHEMS]]   49   413
  ## 51   [[TOKENS]]  110  1808

  res2 <- collScores(res, node  = "極楽", span =5)
  res2


  res <- collocate("cred.txt", node = "クレジットカード", span =3)
  res
  res2 <- collScores(res, node  = "クレジットカード", span =3)
  res2






######################################
#  2009 年 3月 5日 新規追加
# docDF()関数 # テキストには記載がありません
# http://rmecab.jp/wiki/index.php?RMeCabFunctions

# 第 1 引数で指定されたファイル (フォルダが指定された場合は，その中の全ファイル)，あるいは第1引数でデータフレームを，また第 2 引数で列（番号あるいは名前）を指定して，Ngram行列，あるいはターム・文書行列を作成する．
## なお[[LESS-THAN-1]] と [[TOTAL-TOKENS]] の情報行は追加されない 
## 
##   指定可能な引数は target column type pos minFre N Genkei weight nDF co dic
##      
## target 引数はファイル名ないしフォルダ名,あるいはデータフレーム
## type 引数は　type=0　が文字、type=1　が形態素である
## column はデータフレームを指定し場合，列（番号あるいは名前）を指定する
## pos 引数は pos = c(``名詞'', ``形容詞'', ``記号'') のように指定する．
##                        デフォルトは記号を含め，すべての品詞
## minFreq 引数には頻度の閾値を指定するが，docMatrix() 関数の場合とは異なり，
##     全テキストを通じての総頻度を判定対象とする．
##           例えば minFreq=2 と指定した場合，どれか一つの文書で頻度が二つ以上
##           のタームは，これ以外の各文書に一度しか出現していなくとも，
##           出力のターム・文書行列に含まれる． 
##           docMatrix() 関数では，文書のごとの最低頻度であった．
##           したがって，doc1という文書で二度以上出現しているタームが，
##           他の文書で一度しか出現していない場合，このタームは出力の
##           ターム．文書行列に含まれるが，doc1以外の文書の頻度は一律 0 にされる
##  weight 重みを付ける 標準的には "tf*idf*norm"を指定 
##  Genkei = 0 活用語を原型 (0) にするか，表層形(1) にするか
##  nDF : N個のタームそれぞれを独立した列に取る．デフォルトは 0： nDF = 1 とするとNgramDF() 関数, NgramDF2() 関数に似た出力になります．
## co 共起行列の作成．docMatrix2 の事例を参照のこと
## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する


  library(RMeCab)

(res <- docDF("doc"))

## file_name =  doc/doc1.txt opened
## file_name =  doc/doc2.txt opened
## file_name =  doc/doc3.txt opened
## number of extracted terms = 23
## now making a data frame. wait a while!

##    Ngram doc1.txt doc2.txt doc3.txt
## 1     。        1        1        1
## 2     い        0        1        2
## 3     し        0        0        1
## 4     す        1        1        1
## 5     で        1        1        1
## 6     な        1        0        0
## 7     の        0        1        0
## 8     は        1        1        1
## 9     ま        0        0        1
## 10    を        0        0        1
## ... 以下省略 

res <- docDF("doc", type=1, N=1, co=1 )
res

##      TERM   POS1         POS2 。 いる だ で です の は ます を 学ぶ 学生 彼女
## 1      。   記号         句点  3    1  1  1    2  1  3    1  1    1    2    2
## 2    いる   動詞       非自立  1    1  0  1    0  0  1    1  1    1    0    1
## 3      だ 助動詞            *  1    0  1  0    1  0  1    0  0    0    1    0
## 4      で   助詞     接続助詞  1    1  0  1    0  0  1    1  1    1    0    1
## 5    です 助動詞            *  2    0  1  0    2  1  2    0  0    0    2    1
## 6      の   助詞       格助詞  1    0  0  0    1  1  1    0  0    0    1    1
## 7      は   助詞       係助詞  3    1  1  1    2  1  3    1  1    1    2    2
## 8    ます 助動詞            *  1    1  0  1    0  0  1    1  1    1    0    1
## 9      を   助詞       格助詞  1    1  0  1    0  0  1    1  1    1    0    1
## 10   学ぶ   動詞         自立  1    1  0  1    0  0  1    1  1    1    0
## ... 以下省略


(res <- docDF("doc", pos = c("名詞","形容詞","助詞"),N=1, type = 1))


##      TERM   POS1         POS2 doc1.txt doc2.txt doc3.txt
## 1      で   助詞     接続助詞        0        0        1
## 2      の   助詞       格助詞        0        1        0
## 3      は   助詞       係助詞        1        1        1
## 4      を   助詞       格助詞        0        0        1
## 5    学生   名詞         一般        1        1        0
## 6    彼女   名詞       代名詞        0        1        1
## 7    数学   名詞         一般        0        1        1
## 8  真面目   名詞 形容動詞語幹        1        0        0
## 9      私   名詞       代名詞        1        0        0
## 10     科   名詞         接尾        0        1        0
## 11   良い 形容詞         自立        0        1        0
## 12 難しい 形容詞         自立        0        0        1
## > 


   (res <- docMatrix("doc", pos = c("名詞","形容詞"), weight = "tf*idf"))# 参考



(res <- docDF("doc", N=1, type=1, weight = "tf*idf"))
## file_name =  doc/doc1.txt opened
## file_name =  doc/doc2.txt opened
## file_name =  doc/doc3.txt opened
## number of extracted terms = 18
## now making a data frame. wait a while!
## * * 
##      TERM   POS1         POS2 doc1.txt doc2.txt doc3.txt
## 1      。   記号         句点 1.000000 1.000000 1.000000
## 2    いる   動詞       非自立 0.000000 0.000000 2.584963
## 3      だ 助動詞            * 2.584963 0.000000 0.000000
## 4      で   助詞     接続助詞 0.000000 0.000000 2.584963
## 5    です 助動詞            * 1.584963 1.584963 0.000000
## 6      の   助詞       格助詞 0.000000 2.584963 0.000000
## 7      は   助詞       係助詞 1.000000 1.000000 1.000000
## 8    ます 助動詞            * 0.000000 0.000000 2.584963
## 9      を   助詞       格助詞 0.000000 0.000000 2.584963
## 10   学ぶ   動詞         自立 0.000000 0.000000 2.584963
## 11   学生   名詞         一般 1.584963 1.584963 0.000000
## 12   彼女   名詞       代名詞 0.000000 1.584963 1.584963
## 13   数学   名詞         一般 0.000000 1.584963 1.584963
## 14 真面目   名詞 形容動詞語幹 2.584963 0.000000 0.000000
## 15     私   名詞       代名詞 2.584963 0.000000 0.000000
## 16     科   名詞         接尾 0.000000 2.584963 0.000000
## 17   良い 形容詞         自立 0.000000 2.584963 0.000000
## 18 難しい 形容詞         自立 0.000000 0.000000 2.584963

   (res <- docMatrix("doc", pos = c("名詞","形容詞"), weight = "tf*idf*norm"))
   colSums(res^2)# 参考

(res <- docDF("doc", type = 1, weight = "tf*idf*norm"))

##      TERM   POS1         POS2  doc1.txt  doc2.txt  doc3.txt
## 1      。   記号         句点 0.1922000 0.1765162 0.1456847
## 2    いる   動詞       非自立 0.0000000 0.0000000 0.3765895
## 3      だ 助動詞            * 0.4968298 0.0000000 0.0000000
## 4      で   助詞     接続助詞 0.0000000 0.0000000 0.3765895
## 5    です 助動詞            * 0.3046298 0.2797716 0.0000000
## 6      の   助詞       格助詞 0.0000000 0.4562878 0.0000000
## 7      は   助詞       係助詞 0.1922000 0.1765162 0.1456847
## 8    ます 助動詞            * 0.0000000 0.0000000 0.3765895
## 9      を   助詞       格助詞 0.0000000 0.0000000 0.3765895
## 10   学ぶ   動詞         自立 0.0000000 0.0000000 0.3765895
## 11   学生   名詞         一般 0.3046298 0.2797716 0.0000000
## 12   彼女   名詞       代名詞 0.0000000 0.2797716 0.2309048
## 13   数学   名詞         一般 0.0000000 0.2797716 0.2309048
## 14 真面目   名詞 形容動詞語幹 0.4968298 0.0000000 0.0000000
## 15     私   名詞       代名詞 0.4968298 0.0000000 0.0000000
## 16     科   名詞         接尾 0.0000000 0.4562878 0.0000000
## 17   良い 形容詞         自立 0.0000000 0.4562878 0.0000000
## 18 難しい 形容詞         自立 0.0000000 0.0000000 0.3765895

colSums(res[,4:6]^2) #各列とも二乗の合計は１

##  データに NA が含まれる場合や，minFreq 引数に 2 以上を指定した場合は出力には NA が含まれるので注意





(res <- docDF("doc", N=1))

(res <- docDF("doc", type = 1, N=1))

(res <- docDF("doc", type = 1, N=2))

(res <- docDF("doc", type = 1, pos = c("名詞","動詞"), N=1))

(res <- docDF("doc", type = 1, pos = c("名詞","動詞", "記号"),N=1))

(res <- docDF("doc", type = 1))

(res <- docDF("yukiguni.txt", type = 1))

(res <- docDF("yukiguni.txt", N= 1, type = 1))

# 時間がかかります．
res <- docDF("morikita", pos = c("名詞","形容詞"), type = 1, N=3)
nrow(res); ncol(res)


(target <- read.csv("photo.csv"))

(res <- docDF(targetText, col = 3))

(res <- docDF(targetText, col = 3, type = 1, N = 1,pos = c("名詞","動詞")))

(res <- docDF(targetText, col = 3, type=1, pos = c("名詞","動詞","助詞")))


(res <- docDF("doc", type=1, N=2,pos = c("名詞","動詞"),
          Genkei = 1, nDF = 1))
##       N1     N2      POS1                POS2 doc1.txt doc2.txt doc3.txt
## 1   学ん     い 動詞-動詞         自立-非自立        0        0        1
## 2   彼女   数学 名詞-名詞         代名詞-一般        0        1        1
## 3   数学   学ん 名詞-動詞           一般-自立        0        0        1
## 4   数学     科 名詞-名詞           一般-接尾        0        1        0
## 5 真面目   学生 名詞-名詞   形容動詞語幹-一般        1        0        0
## 6     私 真面目 名詞-名詞 代名詞-形容動詞語幹        1        0        0
## 7     科   学生 名詞-名詞           接尾-一般        0        1        0

(res <- docDF("doc", N=3, nDF = 0))

## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = C:\Users\ishida\ishida.dic
# などとした2行を加えておきます
## (res <- docDF(target, col = 3, type=1, pos = c("名詞","動詞","助詞") , dic = "C:/Users/ishida/ishida.dic" ))
# 

## 共起行列の作成
### 共起行列の作成は，非常にメモリを喰います．
### 例えば本書付属の wrinters フォルダから行列を作成する際，
### 同時に co 引数で共起行列への変換を指定すると
### １GB 程度のメモリのマシンではフリーズすることもあります．


## テキストの分量が大きく，行列が大きくなる場合は
## Matrix パッケージを利用したsparse 行列への変換をおすすめします
## 以下に例があります

(res <- docDF("doc", pos = c("名詞","形容詞"), co = 1))

(res <- docDF("doc", co = 2))

## (res <- docDF("doc", co = 3))

  # 時間がかかります
   rm(list = ls())
   gc(); gc()

  res <- docDF("writers", type = 1,pos = c("名詞","形容詞","助詞"))
  nrow(res); ncol(res)



##### 特に共起行列の作成は注意が必要です
  rm(list = ls())
  gc(); gc()

# 以下の処理は負荷が非常に高くなります
 pt1 <- proc.time()
 res <- docDF("writers", type = 1,pos = c("名詞","形容詞","助詞"), co =1)
 pt2 <- proc.time()
 pt2 - pt1
 ##    user  system elapsed 
 ##   4.744   0.984   5.932
 ## core2duo memory 4GB Ubuntu 8.10  R-2.8.1 


 nrow(res);ncol(res)
## [1] 5643
## [1] 5646 ## ターム名の列が三つある

  ##  library(Matrix)# Matrix パッケージを利用したsparse 行列への変換
 
  ## #  rm(list = ls())
  ##  gc(); gc(); ls()
  ##  pt1 <- proc.time()
  ##  res0 <- docDF("writers", type = 1,pos = c("名詞","形容詞","助詞"))
 

  ##  res1 <- Matrix( (as.matrix( res[,  -c(1,2,3)] ) >0) * 1)
  ##  res2 <- crossprod(t(res1))
  ##  pt2 <- proc.time()
  ##  pt2 - pt1
  ##  ##    user  system elapsed 
  ##  ##   1.240   0.564   2.200
  ##  ## core2duo memory 4GB Ubuntu 8.10  R-2.8.1 
  ## all(res == res2)





####################################################
#                                                  #
#                                                  #
#   第６章　インターネット上の口コミ情報の分析     #
#                                                  #
#                                                  #
####################################################

  library(RMeCab)

## データは読者の皆さんがご用意ください

phone <- RMeCabFreq("phone.txt")  # ファイルの読み込み
nrow(phone)       # 行数 (形態素数) の確認

## 書籍とはターム数が異なっている場合があります．

phone[1:3,]
phone[phone$Term == "こと",]


phone2 <- phone[ (phone$Info1 == "名詞" |
		                    phone$Info1 == "形容詞" |
		                    phone$Info1 == "動詞" |
		                    phone$Info1 == "助動詞")  &
		                   (phone$Info2 != "非自立"   &
		                    phone$Info2 != "数" ) ,]
 nrow(phone2)   # 出力の行数を確認する
#		 [1] 274
phone2[1:3,]   # 最初の 3 行を確認する

phone3 <- phone2[phone2$Freq> 2,] # 頻度が 2 より大きい場合 
nrow(phone3)
#		 [1] 37
phone3[rev(order(phone3$Freq)),]

phoneRaw <- readLines("phone.txt")
length(phoneRaw)
# 		 [1] 100               # phone.txt は100行からなる
 phoneMorp <- list(100)
 for(i in 1:100){
		     phoneMorp[[i]] <- unlist(RMeCabC(phoneRaw[i]))
		     if(any( phoneMorp[[i]] %in%   c("売れる", "使える", "ない" ))){
		          # print(phoneMorp[[i]])
		          print(as.vector( phoneMorp[[i]]))                  
		     }
		 }













####################################################
#                                                  #
#                                                  #
#        第７章　アンケートの自由記述の分析        #
#                                                  #
#                                                  #
####################################################


## for Linux Users
## X11.options(fonts=c("-misc-vl gothic-medium-r-normal--%d-*-*-*-*-*-jisx0201.1976-*",    "-adobe-symbol-*-*-*-*-%d-*-*-*-*-*-*-*"))
## X11.options(fonts=c("-kochi-gothic-medium-r-normal--%d-*-*-*-*-*-jisx0201.1976-*",    "-adobe-symbol-*-*-*-*-%d-*-*-*-*-*-*-*"))
ps.options(family= "Japan1")# HeiseiKakuGo-W5

  # old.par <- par(oma = rep(1, 4), mar = rep(1, 4),  bg = "white" )

## 日本語の配慮表現の分析

# getwd()          # 現在の作業フォルダの確認
# setwd("C:/data") # 作業フォルダの設定
## library(RMeCab)
# setwd("/home/ishida/data")

dat <- read.csv("dat.csv")

class(dat)
nrow(dat) ## 書籍とはターム数が異なっている場合があります．
colnames(dat)

summary(dat$Q1A2)
summary(dat$Q2A2)


# 欠損値を省く
dat <- na.omit(dat)
nrow(dat)
attach(dat)


Q1A2 <- ordered(Q1A2, levels = c("E", "D","C","B", "A"))
Q2A2 <- ordered(Q2A2, levels = c("E", "D","C","B", "A"))

summary(Q1A2)
summary(Q2A2)

dat.t1 <- xtabs(~ Q1A2 + Sex)
dat.t1
sum(dat.t1)

dat.t2 <- xtabs(~ Q2A2 + Sex)
dat.t2
sum(dat.t2)


x <- matrix(c(229, 98, 286, 58), ncol = 2)
x
chisq.test(x)
kekka <- chisq.test(x, corr = FALSE)

(kekka$observed - kekka$expected)^2/ kekka$expected

pchisq(16.14, df = 1, lower = F)
1 - pchisq(16.14, df = 1)


#　カイ二乗検定

chisq.test(dat.t1)
chisq.test(dat.t2)


# マクネマー検定
dat.t <- xtabs(~ Q1A2 + Q2A2)
dat.t
mcnemar.test(dat.t)


## 日本語形態素解析
colnames(dat) # 列名を再確認

# library(RMeCab)

Q1 <- RMeCabDF(dat, 3)
 # Q1 <- RMeCabDF(dat, "Q1A1") # 同じことだが

Q2 <- RMeCabDF(dat, 5)
 # Q2 <- RMeCabDF(dat, "Q2A1")

 # Q1 <- docMatrixDF(dat[,"Q1A1"], pos = c("名詞"))

dat[1,]
Q1[[1]]


## 平均頻度が 3 の場合のグラフ
x <- rpois(1000,3)
hist(x)
#

## 日本語文の長さを測る
Q1Len <- Q2Len <- NULL

for(i in 1: length(Q1)){
		   if( any(is.na(Q1[[i]]))) {
		      Q1Len[i] <- NA
		   }else{
		      Q1Len[i] <- length(Q1[[i]])
		   }
		 }
for(i in  1: length(Q2)){
		   if( any(is.na(Q2[[i]]))) {
		      Q2Len[i] <- NA
		   }else{
		      Q2Len[i] <- length(Q2[[i]])
		   }
		 }

summary(Q1Len)
summary(Q2Len)

par(mfrow = c(1,2))
hist(Q1Len)
hist(Q2Len)


## ウィルコクスンの符号付順位和検定
wilcox.test(Q1Len, Q2Len, paired = TRUE)


## 記号を除去

## 始めに rmSign 関数を定義します
# 形態素解析の結果から「記号」を取る

## rmSign <- function (x){
##   if(!is.list(x)){
##     stop("x must be a list")
##   }
##   for(i in 1:length(x)){
##     if(any(is.na(x[[i]]))){
##       x[[i]] <- NA
##     }
##     else{
##       tmp <- NULL
##       for(j in 1:length(x[[i]])){
##         if(names(x[[i]][j]) != "記号"){
##           tmp <- c(tmp, j)
##         }
##       }
##       x[[i]] <- x[[i]] [tmp]
##       tmp <- NULL
##     }
##   }
##   return (x)
## }



##  
res1 <- rmSign(Q1)
res2 <- rmSign(Q2)



##################################################

## 文末2語を抽出するための関数を用意

last2morp <- function(x){
		  if(!is.list(x)){
		    stop("x must be a list")
		  }
		  else{
		    for(i in 1:length(x)){
		      if(any(is.na(x[[i]]))){
		        x[i] <- NA
		      }else{
		        len <- length(x[[i]])
		        x[i] <- paste(x[[i]][(len-1)],x[[i]][(len)], sep ="")
		      }
		    }
		  }
		  return(unlist(x))
        }

res1 <- last2morp(res1)
res2 <- last2morp(res2)


## 結果の確認
dat[which(res1 == "んか" ), "Q1A1"]

unique(res1)
unique(res2)


##
# Q1A1 カテゴリの統合
res1[res1 == "てください" ] <- "て下さい"
res1[res1 == "かなぁ" | res1 == "かなー" | res1 == "かなあ" ] <- "かな"

res1[res1 == "んかぁ" ] <- "んか"
res1[res1 == "けどいい" | res1 == "ていい" |
res1 == "もいい"] <- "いい"
res1[res1 == "けど頼める"] <- "お願いできる"
res1[res1 == "すかー"] <- "っすか"
res1[res1 == "だけなんで"] <- "ますか"

# Q2A1カテゴリの統合
res2[res2 == "だけなんで"] <- "ますか"



###
# 語尾のバリエーションを再確認
unique(res1)
unique(res2)

dat$gobi1 <- res1
dat$gobi2 <- res2

 ######
 ## Linux ユーザー向け : グラフィックスで日本語表示を可能にするために
 ##  X11.options(fonts=c("-ipamona-gothic-*-*-normal--%d-*-*-*-*-*-*-*",  "-adobe-symbol-*-*-*-*-%d-*-*-*-*-*-*-*")) ;  ps.options(family= "Japan1Ryumin")
#    X11.options(fonts=c("-shinonome-gothic-*-*-normal--%d-*-*-*-*-*-*-*",    "-adobe-symbol-*-*-*-*-%d-*-*-*-*-*-*-*"));  ps.options(family= "Japan1Ryumin")
 ##  X11.options(fonts=c("-ipamona-gothic-medium-r-normal--0-0-0-0-m-0-jisx0212.1", "-adobe-symbol-*-*-*-*-%d-*-*-*-*-*-*-*")); ps.options(family= "Japan1Ryumin")
 ######

 #####
 ## Macintosh  : グラフィックスで日本語表示を可能にするために
 ## 同封の .Rprofile ファイル(ドットで始まるファイルであるため，フォルダ内に表示されていないかもしれません)を自分のアカウントのホームディレクトリに置いて
 ## R を実行し直してください
 #####


dat.color <-  rainbow(length(unique(dat$gobi1)))
 length(dat.color)
dat.t1 <- table(dat$Q1A2, dat$gobi1)


matplot(prop.table(dat.t1, 1), type = "l", xlab = "Q1A2", ylab = "割合",
           #  cex.main = 1.2, 
		    lwd = 3, lty = 1:ncol(dat.t1),  # 線の太さとスタイルの指定
            cex.main = 1.2, cex.lab = 1.2,  col = dat.color, axes = F, main = "少年の場合")
legend(1, max(prop.table(dat.t1, 1)), legend= colnames(dat.t1),#  cex = 1.2,
		      lwd = 3, lty = 1:ncol(dat.t1), col  = dat.color,  cex = 1.2 ) # R-2.7.0 以降の場合 fill = dat.color とする
                                    
axis(1, at = c(1,2,3,4,5), labels = c("A","B","C","D","E"))
axis(2, at = c(0,.2, .4, .6, .8, 1))


# データを確認する
prop.table(dat.t1, 1) # 「ですか」が多いようだが
dat[which(res1 == "ですか" ),"Q1A1" ]
dat[which(res1 == "ますか" ),"Q1A1" ]
dat[which(res1 == "んか" ),"Q1A1" ]


## 中年男性の場合

dat.color <-  rainbow(length(unique(dat$gobi2)))
dat.t2 <- table(dat$Q2A2, dat$gobi2)


matplot(prop.table(dat.t2, 1), type = "l",
		  xlab = "Q2A2", ylab = "割合", axes = F,
        lwd = 3, lty = 1:ncol(dat.t2),  # 線の太さとスタイルの指定
		  cex.main = 1.2, cex.lab = 1.2,  col = dat.color, main = "中年男性の場合" )

legend(1, max(prop.table(dat.t2, 1)), legend= colnames(dat.t2),
		  lwd = 3, lty = 1:ncol(dat.t2), col = dat.color ,  cex = 1.2) 
axis(1, at = c(1,2,3,4,5), labels = c("A","B","C","D","E"))
axis(2, at = c(0,.2, .4, .6, .8, 1))

## データを確認する
prop.table(dat.t2, 1)# 「ですか」が多いようだが
dat[which(res1 == "ですか" ),"Q2A1" ]


## 対応分析
mat <- matrix(c(1,2,0,0,  0,2,6,0,  0,1,2,2,  0,0,0,2),
		     ncol = 4, byrow = T)
dimnames(mat) <- list(c("中卒F","高中退F","高卒F","大卒F"),
		       c("中卒M","高中退M","高卒M","大卒M"))
mat

library(MASS)  # 対応分析の用意

mat.ca <- corresp(mat, nf = 2)
biplot(mat.ca, cex = 1.2)  # バイプロットを作成



##相手が少年の場合
dat1.t1 <-ftable(xtabs(~ Region + Sex + Q1A2 + gobi1, data = dat))

lab <- NULL
for(x in 1:length( attr(dat1.t1, "row.vars")$Region )){
		   for(y in 1:length( attr(dat1.t1, "row.vars")$Sex)){
		     for(z in 1:length( attr(dat1.t1, "row.vars")$Q1A2)){
		       lab <- c(lab, paste(attr(dat1.t1, "row.vars")$Region[x],
		                attr(dat1.t1, "row.vars")$Sex[y], attr(dat1.t1,
		                "row.vars")$Q1A2[z], sep = ""))
		     }
		   }
		 }
dimnames(dat1.t1)  <- list(lab, attr(dat1.t1, "col.vars")$gobi1)


# 各列の頻度がすべて 0，つまり行合計が 0 の行を除く
dat1.t2 <- dat1.t1[rowSums(dat1.t1) != 0, ]

## 対応分析を実行
##  library(MASS) 

dat1.corr <- corresp(dat1.t2, nf = 2 )
biplot(dat1.corr, cex = 1.2)

dat[which(res1 == "っすか" ), c("Region","Sex","Q1A1","Q1A2")]

dat[dat$Region == "E" & dat$Sex == "M", c("Region","Sex","Q1A1","Q1A2")]

# subset(dat, Region %in% c("E") & Sex %in% c("M"))


biplot(dat1.corr, xlim = c(-.31,.31), ylim = c(-.31, .31), cex = 1.2)

# 座標の目盛は以下の計算で設定されている
dat1.corr
dat1.corr$rscore[, 1:2] %*% diag(dat1.corr$cor[1:2])
dat1.corr$cscore[, 1:2] %*% diag(dat1.corr$cor[1:2])

# 
plot(dat1.corr[2]$rscore, type = "n",
		    xlim = c(0.05,.35), ylim = c(-1, .35) )
text(dat1.corr[2]$rscore, lab = rownames(dat1.corr[2]$rscore), cex = 1.2)

# 二つの図を並べる
       quartz(); # mac ユーザー # x11() # Linux ユーザー

plot(dat1.corr[3]$cscore, type = "n",
		    xlim = c(0.05, .35), ylim = c(- 1, .35) )
text(dat1.corr[3]$cscore, lab = rownames(dat1.corr[3]$cscore) , cex = 1.2 )

dev.off()


# 相手が中年男性の場合 Q2A1 

dat2.t1 <-ftable(xtabs(~ Region + Sex + Q2A2 + gobi2, data = dat))
 dimnames(dat2.t1)

lab <- NULL
for(x in 1:length( attr(dat2.t1, "row.vars")$Region )){
  for(y in 1:length( attr(dat2.t1, "row.vars")$Sex)){
    for(z in 1:length( attr(dat2.t1, "row.vars")$Q2A2)){
      lab <- c(lab, paste(attr(dat2.t1, "row.vars")$Region[x],  attr(dat2.t1, "row.vars")$Sex[y], attr(dat2.t1, "row.vars")$Q2A2[z], sep = ""))
    }
  }
}


dimnames(dat2.t1) <- list(lab,   attr(dat2.t1, "col.vars")$gobi2  )
# 反応の無い行を除く
dat2.t2 <- dat2.t1[rowSums(dat2.t1) != 0, ]

  # library(MASS)
dat2.corr <- corresp(dat2.t2, nf = 2 )
#biplot(dat2.corr)

biplot(dat2.corr, ylim = c(-.5, 1), cex = 1.2)



## 多重ロジスティックモデル
# install.packages("nnet")

library(nnet)

model1 <- multinom(as.factor(gobi2) ~ Region + Sex + Q2A2, data = dat)

model2 <- step(model1)
		# ... 中略
summary(model2)


## # 相手を考慮した分析を行ってみるmy.sample <- sample(1:nrow(dat), 119)
## colnames(dat)
## dat.b <- dat[dat$id  %in% my.sample,  c("Region", "Sex", "gobi1")]
## colnames(dat.b) <- c("Region ", "Sex", "gobi")
## dat.s <- dat[(!dat$id  %in% my.sample),  c("Region", "Sex", "gobi2")]
## colnames(dat.s) <- c("Region ", "Sex", "gobi")

## dat.b$BS <- rep("B",nrow(dat)/2)
## dat.s$BS <-rep("S",nrow(dat)/2)

## dat.all <- rbind(dat.b, dat.s)

## model3 <- multinom(as.factor(gobi) ~ Region + Sex + BS, data = dat.all)

## model4 <- step(model3)
## 		# ... 中略
## summary(model4)



####################################################
#                                                  #
#                                                  #
#        第８章　沖縄観光のアンケートの分析        #
#                                                  #
#                                                  #
####################################################


########### RMeCabによるアンケート分析2 ########

## データは読者の皆さんがご用意ください
## 沖縄県観光商工部観光企画課

# http://www3.pref.okinawa.jp/site/view/contview.jsp?cateid=233&id=14739&page=1

library(RMeCab)


okinawa <- read.csv("H18koe.csv")#  encoding = "UTF-8"
colnames(okinawa)
# # # # # okinawa <- okinawa[,-1] # ID 列を削除

nrow(okinawa) ## 書籍とはターム数が異なっている場合があります．

# 自由記述欄以外の要約
summary(okinawa[, -1])
## summary(okinawa[,c("Region","Sex","Age","Satis")])
## ##  NA's        :  3              NA's   : 4
## > summary(okinawa[,-1])
##           Region      Sex           Age            Satis    
##  関東        :123   女性:186   ６０代 :79   やや不満  : 14  
##  近畿        : 59   男性:141   ５０代 :72   やや満足  :146  
##  九州        : 38   NA's:  4   ３０代 :58   該当しない:  2  
##  中国・四国  : 27              ２０代 :46   大変不満  :  2  
##  中部        : 59              ４０代 :44   大変満足  :147  
##  北海道・東北: 22              (Other):28   NA's      : 20  
##  NA's        :  3              NA's   : 4


# xtabs(~ Sex + Age,data = okinawa)
xtabs(~ Sex + Satis,data = okinawa)
chisq.test(xtabs(~Sex + Satis,data = okinawa))

xtabs(~ Age + Satis,data = okinawa)
chisq.test(xtabs(~ Age + Satis,data = okinawa))

xtabs(~ Region + Satis,data = okinawa)
chisq.test( xtabs(~ Region + Satis,data = okinawa))


colnames(okinawa)
# library(RMeCab)

res <- RMeCabDF(okinawa, "opinion", 1) # res <- RMeCabDF(okinawa, 1, 1) # に同じ 

    # res <- docMatrixDF(okinawa$opinion)
head(res)

#####################################

   ## 途中経過を確認しつつ作業するのではなく、結果だけをえるだけなら
   ## 教科書の全コードは 以下に代えられる。

     okinawa$newVar <- interaction(okinawa$Sex, okinawa$Age)
    # 　で新規の列を追加して
    levels(okinawa$newVar)
    head(okinawa[,-1])
    # 形態素解析の結果から、必要なタームだけ残す
    okinawaWords <-  c( "人",  "海",  "タクシー", "多い", "運転",  "ほしい",  "いい", 
                    "離島" , "バス" , "充実",  "良い", "道",  "車",  "きれい", 
                    "ホテル", "渋滞", "交通", "やすい", "北部",  "店",  "整備",
                    "自然",  "欲しい", "モノレール", "料金", "美しい", "道路",
                    "料理", "時間", "必要" )    
    select.words <- function(x){
       x [x %in% okinawaWords ]
    } 
    newList <- lapply(res, select.words)
    # グループごとにアンリスト化し、その結果を新しいリストに保存
    newList2 <- tapply (newList, okinawa$newVar, unlist)
    length(newList2) # 14　グループ
　　　　　　　　　　　###　(データには７０代の回答もある　 okinawa[okinawa$Age == "７０代",1])
    newList2 <-  newList2[!(sapply(newList2, "is.null"))]
    newList3 <- lapply(newList2, table)
    newList4 <- lapply(newList3, as.data.frame)
    ## install.packages("reshape")
    library(reshape)
    okinawa2 <- melt(newList4, measure.var = "Freq")
    newTable <- xtabs(value ~ Var1 + L1, data = okinawa2)
    newTable2 <- newTable[, 
         !(colnames(newTable) %in% c("女性.７０代","男性.７０代"))] 
    library(MASS)
    okinawa.corr  <- corresp(newTable2,  nf = 2)
    biplot( okinawa.corr )
    

    ## ただしテキストマイニングでは、出力を確認・検討しながら実行すべきである

#####################################



length(res)
length(unlist(res))# 14464 # Mac では　Linux 14465　となる
length(unique(unlist(res)))# 
res.t <- table(unlist(res))
length(res.t)## 1966

res.t[ rev(order(res.t)) ][1:10]

##   。   の   が   た   、   て   に   を する   は 
##  823  727  631  510  485  447  435  339  322  314


## 名詞と形容詞のみを抽出する
res2 <- list()
for(i in 1:length(res)){
    res2[[i]] <-  res[[i]][names(res[[i]]) == "名詞" | names(res[[i]]) == "形容詞"]
}
length(res2)
# [1] 331

length(unlist(res2))
length(unique(unlist(res2)))
res.t2 <- table(unlist(res2))
length(res.t2)#

res.t2[ rev(order(res.t2)) ][1:10]

# res.t2[ order(res.t2) ][1:10]
#  沖縄   観光     の     人     海   こと ほしい   良い   旅行   バス 
#   148    117     85     75     64     60     54     52     52     49




##
res60F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "６０代"){

    res60F[[i]] <-  res2[[i]]
  }else{  res60F[[i]] <- NA }
}

  ## 沖縄と観光，旅行 は除いた上位10
res60F1 <- unlist(res60F) [unlist(res60F) != "沖縄" & unlist(res60F) != "観光"& unlist(res60F) != "旅行"]
res60F.t <- table(res60F1)
res60F.t <- res60F.t [rev(order(res60F.t))][1:10]
res60F.t 

## ホテル   今回   バス     海     さ   良い   ない   時間     人   自然 
##    17     12     12     11     11     10     10      9      8      8 



res60M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "６０代"){
    res60M[[i]] <-  res2[[i]]
    
  }else{  res60M[[i]] <- NA }
}


# 沖縄と観光，旅行 は除いた上位10
res60M1 <- unlist(res60M) [unlist(res60M) != "沖縄" & unlist(res60M) != "観光"& unlist(res60M) != "旅行"]
res60M.t <- table(res60M1)
res60M.t <- res60M.t [rev(order(res60M.t))][1:10]
res60M.t

## こと 良い   の   さ 必要 よう 整備 道路   地 多い 
##  10    9    9    8    7    7    6    5    5    5 




############ 50 

res50F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "５０代"){

    res50F[[i]] <-  res2[[i]]
  }else{  res50F[[i]] <- NA }
}
 


## 沖縄と観光，旅行 は除いた上位10
res50F1 <- unlist(res50F) [unlist(res50F) != "沖縄" & unlist(res50F) != "観光"& unlist(res50F) != "旅行"]
res50F.t <- table(res50F1)
res50F.t <- res50F.t [rev(order(res50F.t))][1:10]
res50F.t

##     人   こと     の ほしい     海   良い 美しい     店   多い     方 
##     18     13     12     11     10      9      9      9      9      6 


#####
res50M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "５０代"){
    res50M[[i]] <-  res2[[i]]
  }else{  res50M[[i]] <- NA }
}



# 沖縄と観光，旅行 は除いた上位10
res50M1 <- unlist(res50M) [unlist(res50M) != "沖縄" & unlist(res50M) != "観光"& unlist(res50M) != "旅行" ]
res50M.t <- table(res50M1)
res50M.t <- res50M.t [rev(order(res50M.t))][1:10]
res50M.t

##     の   道路   自然     さ   バス やすい   料理 美しい   大変     人 
##      8      7      6      6      5      5      4      4      4      4



############## 40


res40F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "４０代"){
    res40F[[i]] <-  res2[[i]]
  }else{  res40F[[i]] <- NA }
}



# 沖縄と観光，旅行 は除いた上位10
res40F1 <- unlist(res40F) [unlist(res40F) != "沖縄" & unlist(res40F) != "観光"& unlist(res40F) != "旅行" ]
res40F.t <- table(res40F1)
res40F.t <- res40F.t [rev(order(res40F.t))][1:10]
res40F.t 

##     の   今回     海   バス ほしい   こと     日     等     前   整備 
##      8      5      5      5      5      5      4      4      4      4


res40M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "４０代"){
    res40M[[i]] <-  res2[[i]]
  }else{  res40M[[i]] <- NA }
}



# 沖縄と観光，旅行 は除いた上位10
res40M1 <- unlist(res40M) [unlist(res40M) != "沖縄" & unlist(res40M) != "観光"& unlist(res40M) != "旅行" ]
res40M.t <- table(res40M1)
res40M.t <- res40M.t [rev(order(res40M.t))][1:10]
res40M.t

##       自然       良い     欲しい モノレール       バス         の         さ 
##          7          6          6          5          5          5          5 
##         私         海       料金 
##          4          4          3 


############## 30

res30F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "３０代"){
    res30F[[i]] <-  res2[[i]]
  }else{  res30F[[i]] <- NA }
}


# 沖縄と観光，旅行 は除いた上位10
res30F1 <- unlist(res30F) [unlist(res30F) != "沖縄" & unlist(res30F) != "観光"& unlist(res30F) != "旅行" ]
res30F.t <- table(res30F1)
res30F.t <- res30F.t [rev(order(res30F.t))][1:10]
res30F.t 

##     人     海     の ほしい きれい   いい   多い ホテル   よう   こと 
##     11     11      9      8      8      8      7      7      6      6


## 
res30M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "３０代"){
    res30M[[i]] <-  res2[[i]]# 
  }else{  res30M[[i]] <- NA }
}


# 沖縄と観光，旅行 は除いた上位10
res30M1 <- unlist(res30M) [unlist(res30M) != "沖縄" & unlist(res30M) != "観光"& unlist(res30M) != "旅行" ]
res30M.t <- table(res30M1)
res30M.t <- res30M.t [rev(order(res30M.t))][1:10]
res30M.t 

##     人   渋滞   交通 やすい   バス   こと   北部   那覇     店     さ 
##      7      5      5      5      4      4      3      3      3      3


############ 20

res20F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "２０代"){
    res20F[[i]] <-  res2[[i]]# 
  }else{  res20F[[i]] <- NA }
}




# 沖縄と観光，旅行 は除いた上位10
res20F1 <- unlist(res20F) [unlist(res20F) != "沖縄" & unlist(res20F) != "観光"& unlist(res20F) != "旅行" ]
res20F.t <- table(res20F1)
res20F.t <- res20F.t [rev(order(res20F.t))][1:10]
res20F.t 

##       の       人       海 タクシー     多い     運転   ほしい     こと 
##       15       11       10        9        7        7        7        7 
##     いい     離島 
##        7        6

#### 

res20M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "２０代"){
    res20M[[i]] <-  res2[[i]]
  }else{  res20M[[i]] <- NA }
}


# 沖縄と観光，旅行 は除いた上位10
res20M1 <- unlist(res20M) [unlist(res20M) != "沖縄" & unlist(res20M) != "観光"& unlist(res20M) != "旅行" ]
res20M.t <- table(res20M1)
res20M.t <- res20M.t [rev(order(res20M.t))][1:10]
res20M.t 

##   バス   充実   運転 ほしい     さ   良い     道   多い     車     者 
##      4      3      3      3      3      2      2      2      2      2 
## #



## ラベルの作成
okinawa.lab <- unique(c(names(res20F.t), names(res20M.t), names(res30F.t), names(res30M.t), names(res40F.t), names(res40M.t),  names(res50F.t), names(res50M.t), names(res60F.t), names(res60M.t) ))
okinawa.lab  

##  [1] "の"         "人"         "海"         "タクシー"   "多い"      
##  [6] "運転"       "ほしい"     "こと"       "いい"       "離島"      
## [11] "バス"       "充実"       "さ"         "良い"       "道"        
## [16] "車"         "者"         "きれい"     "ホテル"     "よう"      
## [21] "渋滞"       "交通"       "やすい"     "北部"       "那覇"      
## [26] "店"         "今回"       "日"         "等"         "前"        
## [31] "整備"       "自然"       "欲しい"     "モノレール" "私"        
## [36] "料金"       "美しい"     "方"         "道路"       "料理"      
## [41] "大変"       "ない"       "時間"       "必要"       "地"        
## > 

oki <-  which(okinawa.lab %in%  c("さ", "の","こと","ない","私","者", "よう", "等","前","日", "那覇",  "今回", "方","大変","地", "ー") )

okinawa.lab <- okinawa.lab [ -oki ]
okinawa.lab

##  [1] "人"         "海"         "タクシー"   "多い"       "運転"      
##  [6] "ほしい"     "いい"       "離島"       "バス"       "充実"      
## [11] "良い"       "道"         "車"         "きれい"     "ホテル"    
## [16] "渋滞"       "交通"       "やすい"     "北部"       "店"        
## [21] "整備"       "自然"       "欲しい"     "モノレール" "料金"      
## [26] "美しい"     "道路"       "料理"       "時間"       "必要"      
## > 
## データフレームの作成

res60F1[which(res60F1 == "きれい")] <- "美しい"
res60F1[which(res60F1 == "欲しい")] <- "ほしい"
res60F1[which(res60F1 == "いい")] <- "良い"
res60F.t2 <- table(res60F1)
res60F.t3 <- res60F.t2[names(res60F.t2) %in% okinawa.lab]
res60F.t3

#res60F1 ##
##   ほしい   やすい タクシー     バス   ホテル     運転       海     交通 
##        6        2        1       12       17        5       11        1 
##     時間     自然       車     渋滞       人     多い       店     道路 
##        9        8        3        1        8        2        4        1 
##   美しい     必要     料金     料理     良い 
##        7        1        1        5       14



res60M1[which(res60M1 == "きれい")] <- "美しい"
res60M1[which(res60M1 == "欲しい")] <- "ほしい"
res60M1[which(res60M1 == "いい")] <- "良い"
res60M.t2 <- table(res60M1)
res60M.t3 <- res60M.t2[names(res60M.t2) %in%  okinawa.lab] #row.names(okinawa.t)]


res50F1[which(res50F1 == "きれい")] <- "美しい"
res50F1[which(res50F1 == "欲しい")] <- "ほしい"
res50F1[which(res50F1 == "いい")] <- "良い"
res50F.t2 <- table(res50F1)
res50F.t3 <- res50F.t2[names(res50F.t2) %in%  okinawa.lab] #row.names(okinawa.t)]


res50M1[which(res50M1 == "きれい")] <- "美しい"
res50M1[which(res50M1 == "欲しい")] <- "ほしい"
res50M1[which(res50M1 == "いい")] <- "良い"
res50M.t2 <- table(res50M1)
res50M.t3 <- res50M.t2[names(res50M.t2) %in%  okinawa.lab] #row.names(okinawa.t)]


res40F1[which(res40F1 == "きれい")] <- "美しい"
res40F1[which(res40F1 == "欲しい")] <- "ほしい"
res40F1[which(res40F1 == "いい")] <- "良い"
res40F.t2 <- table(res40F1)
res40F.t3 <- res40F.t2[names(res40F.t2) %in%  okinawa.lab] #row.names(okinawa.t)]


res40M1[which(res40M1 == "きれい")] <- "美しい"
res40M1[which(res40M1 == "欲しい")] <- "ほしい"
res40M1[which(res40M1 == "いい")] <- "良い"
res40M.t2 <- table(res40M1)
res40M.t3 <- res40M.t2[names(res40M.t2) %in%  okinawa.lab] #row.names(okinawa.t)]

res30F1[which(res30F1 == "きれい")] <- "美しい"
res30F1[which(res30F1 == "欲しい")] <- "ほしい"
res30F1[which(res30F1 == "いい")] <- "良い"
res30F.t2 <- table(res30F1)
res30F.t3 <- res30F.t2[names(res30F.t2) %in%  okinawa.lab] #row.names(okinawa.t)]


res30M1[which(res30M1 == "きれい")] <- "美しい"
res30M1[which(res30M1 == "欲しい")] <- "ほしい"
res30M1[which(res30M1 == "いい")] <- "良い"
res30M.t2 <- table(res30M1)
res30M.t3 <- res30M.t2[names(res30M.t2) %in% okinawa.lab] # row.names(okinawa.t)]


res20F1[which(res20F1 == "きれい")] <- "美しい"
res20F1[which(res20F1 == "欲しい")] <- "ほしい"
res20F1[which(res20F1 == "いい")] <- "良い"
res20F.t2 <- table(res20F1)
res20F.t3 <- res20F.t2[names(res20F.t2) %in%  okinawa.lab] #row.names(okinawa.t)]


res20M1[which(res20M1 == "きれい")] <- "美しい"
res20M1[which(res20M1 == "欲しい")] <- "ほしい"
res20M1[which(res20M1 == "いい")] <- "良い"
res20M.t2 <- table(res20M1)
res20M.t3 <- res20M.t2[names(res20M.t2) %in%  okinawa.lab] #row.names(okinawa.t)]



okinawa.DF <- NULL

okinawa.DF <- data.frame(word = names(res20M.t3), id = rep("20M",length(res20M.t3) ), Freq = as.integer(res20M.t3))

okinawa.DF <- rbind(okinawa.DF,
      data.frame(word = names(res20F.t3), id = rep("20F", length(res20F.t3)), Freq = as.integer(res20F.t3)),
      data.frame(word = names(res30M.t3), id = rep("30M", length(res30M.t3)), Freq = as.integer(res30M.t3)),
      data.frame(word = names(res30F.t3), id = rep("30F", length(res30F.t3)), Freq = as.integer(res30F.t3)),
      data.frame(word = names(res40M.t3), id = rep("40M", length(res40M.t3)), Freq = as.integer(res40M.t3)),
      data.frame(word = names(res40F.t3), id = rep("40F", length(res40F.t3)), Freq = as.integer(res40F.t3)),
      data.frame(word = names(res50M.t3), id = rep("50M", length(res50M.t3)), Freq = as.integer(res50M.t3)),
      data.frame(word = names(res50F.t3), id = rep("50F", length(res50F.t3)), Freq = as.integer(res50F.t3)),
      data.frame(word = names(res60M.t3), id = rep("60M", length(res60M.t3)), Freq = as.integer(res60M.t3)),
      data.frame(word = names(res60F.t3), id = rep("60F", length(res60F.t3)), Freq = as.integer(res60F.t3)))

okinawa.t <- xtabs(Freq ~ word + id, data = okinawa.DF)
row.names( okinawa.t )

##  [1] "ほしい"     "やすい"     "バス"       "ホテル"     "モノレール"
##  [6] "運転"       "自然"       "車"         "充実"       "人"        
## [11] "整備"       "多い"       "道"         "道路"       "必要"      
## [16] "料理"       "良い"       "タクシー"   "海"         "交通"      
## [21] "時間"       "渋滞"       "店"         "美しい"     "北部"      
## [26] "離島"       "料金"



###### 対応分析の実行

 library(MASS)

okinawa.corr  <- corresp(okinawa.t,  nf = 2)
biplot( okinawa.corr , cex = 1.2)

 # 以下は Linux ユーザーが，Windows ユーザーと同じ出力を得るため
 #  okinawa.corr[2]$rscore[,2] <- okinawa.corr[2]$rscore[,2] * -1
 #  okinawa.corr[3]$cscore[,2] <- okinawa.corr[3]$cscore[,2] * -1

## もとデータとの照合



for(i in 1:length(res)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & ( okinawa$Age[i] == "６０代" |  okinawa$Age[i] == "５０代")){
    if(any( res[[i]] %in% c( "時間", "ホテル")  )){
      print(as.character(okinawa[i, "opinion"]))
    }
  }
}


 for(i in 1:length(res)){
   if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "５０代" ){
    if(any( res[[i]] %in%  "道路"  )){
      print(as.character(okinawa[i, "opinion"]))
    }
  }
}




 for(i in 1:length(res)){
   if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & (okinawa$Age[i] == "６０代" )){
#   print(i)
    if(any( res[[i]] %in%  "必要" )){
      print(as.character(okinawa[i, "opinion"]))
    }
  }
}

 for(i in 1:length(res)){
   if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "２０代" ){
#   print(i)
    if(any( res[[i]] %in%  "整備"  | res[[i]] %in%  "充実" )){
      print(as.character(okinawa[i, "opinion"]))
    }
  }
}
#########################



####################################################
#                                                  #
#                                                  #
#        第９章　テキストの自動分類                #
#                                                  #
#                                                  #
####################################################



######　新聞記事の分類
## 著作権の関係でデータは同封されていません．
## データは読者の皆さんがご用意ください

DM <- docMatrix("yomi",   pos = c("名詞","動詞","形容詞"))
DM[1:2,] # 頻度情報の確認
nrow(DM) ## 書籍とはターム数が異なっている場合があります．
ncol(DM)

  DM <- DM[ row.names(DM) !=  "[[LESS-THAN-1]]" , ]
  DM <- DM[ row.names(DM) !=  "[[TOTAL-TOKENS]]" , ]

  nrow(DM)
  ncol(DM)
  plot( hclust(dist( t(DM)))) # テキストの図


## pdf(file = "yomi2.pdf", family = "Japan1")
 plot( hclust(dist( t(DM), "canberra"), "ward"))


   yomi.clus <- hclust(dist( t(DM), "canberra"), "ward")

  # コーフェン行列の抽出
  cophenetic(yomi.clus)


## 潜在的意味インデキシング
# 特異値分解

TD <- matrix(c(1,0,0,0,1,0,
                   0,1,0,1,0,1,
                   0,1,0,0,0,0,
                   0,1,0,0,0,0,
                   0,0,1,0,0,1,
                   1,1,1,1,0,0,
                   0,0,1,2,1,0,
                   1,1,0,0,0,0), nrow=8, byrow=T)

# 上の各列は文書ベクトルを表す

TD.svd <- svd(TD)
is.list(TD.svd); length(TD.svd)
TD.svd$u # word vectors
TD.svd$d # 特異値を確認
TD.svd$v # document vectors
( t(TD.svd$u[,1:3]) %*% TD)

TD.svd$u %*% diag(TD.svd$d) %*% TD.svd$v x






# はじめにターム・文書行列を作成する
DM <- docMatrix("yomi", pos = c ("名詞","動詞","形容詞"), weight = "tf*idf*norm" ) # この際重みを付ける

DM.svd <- svd(DM)          # 特異値分解を行う
DM3 <- t(DM.svd$u[,1:3]) %*% DM # 文書行列を 3 次元で近似
# 色分けの準備
DM3.col <- substring(colnames(DM3), 1,3)
# ラベルの準備
DM3.name <- unlist(strsplit(colnames(DM3), ".txt"))



##### 3次元グラフィックスの作成
## install.packages("rgl")
library(rgl)

rgl.open()
                                        
rgl.bg(color=c("white","black"))
rgl.lines(c(-1,1),0,0,color="gold")
rgl.lines(0, c(-1,1),0,color="gray")
rgl.lines(0,0,c(-1,1),color="black")

rgl.bbox(color="blue",  emission="green")

rgl.texts(DM3[1,], DM3[2,], DM3[3,],  DM3.name,
		    color = as.numeric(as.factor(DM3.col)), adj = 0.5)

## #
rgl.close()


## DM.k <- kmeans(t(DM), 7)
## summary(DM.k)
## DM.k$cluster
## DM.k$center
## plot(DM)

## ## SOM
## # install.packages("e1071")
## library(e1071)
## head(DM)

## DM.df <- as.data.frame(t(DM))

## DM.som <- svm()




####################################################
#                                                  #
#                                                  #
#        第１０章　書き手の判別                    #
#                                                  #
#                                                  #
####################################################


##### 森鴎外と夏目漱石

    library(RMeCab)

# setwd("C:/data")


res <- docNgram("writers", type = 0) # writers はフォルダ名
nrow(res) ## 書籍とはターム数が異なっている場合があります．
ncol(res) 
head(res)


plot( hclust(dist( t(res)),"ward" ))
# plot( hclust(dist( t(res),"minkowski" ),"ward" ))
# plot( hclust(dist( t(res), "canberra"), "ward"))


    ogai.soseki <- hclust(dist( t(res) ), "ward")
    cophenetic(ogai.soseki)

# pdf(file = "ogai.soseki.chap10.pdf", family = "Japan1")

# plot( hclust(dist( t(res) , "canberra"),"ward" ))
plot( hclust(dist( t(res)),"ward" ))
lines(c(1,8), c(500, 500), lty = 2, lwd = 2)

dev.off()



res2 <- res[ rownames(res) %in% c("[と-、]", "[て-、]", "[は-、]", "[が-、]", "[で-、]",  "[に-、]",  "[ら-、]",  "[も-、]" ) ,  ]

nrow(res2)
ncol(res2)

res2


## 主成分分析
iris.pc <- princomp(iris[,-5])

iris.name <- as.numeric(iris[,5])

plot(iris.pc$scores[, 1:2], type = "n")
text(iris.pc$scores[, 1:2], lab = iris.name,  col = as.numeric(iris.name))






res2.pc <- princomp(t(res2))
# summary(res2.pc)

# ラベルの準備
res2.name <- unlist(strsplit(colnames(res2), ".txt"))
 
plot(res2.pc$scores[, 1:2], type = "n")
text(res2.pc$scores[, 1:2], lab = res2.name)




# plot(res2.pc,type ="l")
biplot(res2.pc, cex = 1.2)


## 非計量多次元尺度法による分類
   library(MASS)

res2.dist <- dist(t(res2))
res2.samm <- sammon(res2.dist)
plot(res2.samm$points, type = "n", xlab = "多次元尺度法による分類", ylab = "鴎外と漱石")
text(res2.samm$points , lab = res2.name, col = c(rep(1,4), rep(2,4) ))




####
td <- tempfile("tmp")
dir.create(td)
 write( c("私は真面目な学生です。"), file=paste(td, "D1", sep="/") )


file.exists (td)
file.show (td)

# library(RMeCab)

test <- docNgram (td)

unlink(td, recursive=TRUE)


## txt <- textConnection ("私は真面目な学生です。")
## file.exists (txt)

## txt <- textConnection ("foo", "w")
## char <- "私は真面目な学生です。"


## textConnectionValue(txt)
## scan (file = txt)

library (RMeCab)
dazai <- docDF("merosu.txt")

head (dazai)
tail (dazai)


# 判別分析
library (MASS)
lda

res3 <- as.data.frame ( t(res2))
res3$name <- as.factor (rep(c("鴎外", "漱石"), each = 4))
res3 <- res3[, c(1:3,9)]
resLDA <- lda (name ~ ., data = res3)
plot (resLDA)


## _ RMeCab の出力に topicmodels の LDA を適用
## http://rmecab.jp/wiki/index.php?RMeCab_Tips#u97160a7

library (RMeCab)

test <- docMatrix2( "morikita") # フォルダを指定

install.packages("slam")

library(slam)
test.sparse <-  as.simple_triplet_matrix( t(test) )

library (tm)
test.sparse2 <-  as.DocumentTermMatrix ( test.sparse, weighting = weightTf )

inspect(test.sparse2 [1:3, ] ) # 1-3行目を確認
inspect(removeSparseTerms(test.sparse2, 0.4))

findAssocs(test.sparse2, "出版", 0.3)


## sudo apt-get install libgsl0-dev
install.packages("topicmodels")

library(topicmodels)
# # class(test.sparsea) <- "DocumentTermMatrix"


topic.mod <- LDA(test.sparse2, control = list(alpha = 0.1), k = 5)

get_terms (topic.mod)

terms (topic.mod)
topics (topic.mod)

# sapply (topic.mod)

library(RMeCab)
x <- docDF("writers")
x [200:205,]
