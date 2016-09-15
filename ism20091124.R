## 2009 11 22 # Shift-JIS 

      # # # # ## # # # # # # # # # # # # # # # 
      #   Rによるテキストマイニング入門                 
      #   石田基広  徳島大学大学院                           
      #   統計数理研究所公開講座2009年11月24日   
      #             
      # 
      #   教科書：『Rによるテキストマイニング入門』森北出版2008
      # 
      # # # # # # # # # # # # # # # # # # # # # 

# Windows 版 R-2.10.0 用スクリプトファイル 

http://groups.google.co.jp/group/rmecab
ism20091124.zip   


## [午前１] テキストマイニングの準備
## [午前２] 日本語解析の実際
## [午後３] 基礎
## [午後４] 応用１
## [午後５] 応用２

########################### 午前１#########################################

##[午前-0-1] テキストマイニングとは

## 「電子化されたテキスト（あるいはテキスト集合）から機械的に情報を取り出す技術の総称」

##自然言語（人間の言語）は、数値データなどのように定型化して扱うのが困難であった
##しかし自然言語処理技術の進歩により、パソコンでも言語テキストを定型化して扱うことが容易になった

######

##[午前-0-2] テキストマイニングで何ができるのか.応用事例


## １） WEB上の情報の分析（教科書第６章）
## ２） アンケート自由記述文の分析（第７，８章）
## ３） 文書の自動分類（第９，１０章）

### などなどがあげられる。

##徳島大学での授業アンケートの事例
##臨床心理学分野での事例


## [午前-0-3] これをRで実現する方法の講習会
##すなわち「Rによる」テキストマイニングの入門
### 午前はテキストマイニングに必要な技術や環境について述べ
###午後は、簡単な応用事例を中心に、実際の作業工程を説明する


###############################午前 １#############################

## [午前１] 「テキストマイニングの準備」 では，
###テキストマイニングを実行する上で必要となる形態素解析について述べる

## [午前２] 「日本語解析の実際」では，形態素解析を R で実行する方法について述べる



########## テキストマイニングの準備

# [午前-1-1] 
## テキストの構造化

##テキストを解読ではなく解析する
###解読は個人ごとに「結果」が異なる。また同じ個人でも一貫性に欠ける
###解析は機械に任せられる。
##前者は再現あるいは追試不可能。後者が少なくとも再現が可能

##では解析するとはどういうことなのか
### (1)  テキストを、「節」、「文」、「単語」、「文字」に切り分ける
### (2) この結果をもとに、個々の要素の頻度、あるいは要素のつながりの頻度を集計
### (3) 得られた集計からターム・文書行列を作成


#[午前-1-2]
## ただし自然言語は曖昧である

### たとえば文に切り分けるといっても##

 彼は
 「はい」
 と答えた。

####

 彼は、はいと答えた。

## ##
### ここで、それぞれのテキストは、いくつの文から成り立っているであろうか、二つであろうか？

## またテキストを単語に区切るといっても##

 徳島中央郵便局

## ##
## は一つの単語であろうか？二つ、三つ、四つ？

## このような曖昧性は決して解消されないが
##人間ではなくコンピュータに任せれば、少なくとも再現や追試は可能になる
###すなわちテキストマイニングではコンピュータの利用が前提となる。これが解釈とは違うという意味である。



# [午前-1-3] 

##今回の講座では文字あるいは単語に分割した集計表に基づく
##集計する対象は、個々の文字・単語のこともあれば、いつくかの文字・単語の連なり(Ngram)の場合もある



##少し先回りになるが、文字に基づく頻度表の例を示す
##テキストを単語単位で分割するには、単語および品詞についての情報が必要であり、
##専用のソフトウェアが必要になる。こうしたソフトを形態素解析器という


###{文字単位で分割}であれば、プログラミング言語を使うことで処理できる
####Rもプログラミング言語である

kawabata <- "国境の長いトンネルを抜けると雪国であった。夜の底が白くなった。信号所に汽車が止まった。"
kawabata.2 <- strsplit(kawabata,"")
kawabata.3 <- table(kawabata.2)
# 文字の頻度表
data.frame(kawabata.3)
    # 同じことだが
    # data.frame(char = names(kawabata.3),
    #            freq = as.numeric(kawabata.3))



##Rでは関数という命令を通して、すべての処理を行う
###関数には「引数」という概念がある

###strsplit関数は第一引数に文字列（あるいは文字列を保存したオブジェクト）を、
###また第2引数には、区切りとする文字を指定する。空白を指定すると文字単位で区切る
 strsplit("石田 基広"," ")


#[午前-1-4] 

##テキストを単語単位に区切る

##形態素解析を行うソフトウェアが必要### 教科書第４章も参照

###茶筅     http://chasen-legacy.sourceforge.jp/
###Juman   http://nlp.kuee.kyoto-u.ac.jp/nl-resource/juman.html
###MeCab   本講座で利用する
###CaBochahttp://chasen.org/~taku/software/cabocha/
####が広く使われている。

##### これらの違いについてはhttp://mecab.sourceforge.net/feature.html



## {形態素解析 1}

## MeCab の導入

##  形態素解析器 MeCab: \url{http://mecab.sourceforge.net/ ：工藤 拓 氏
##  例文：「彼は R を使った．」

## Windows 版  
##  スタート -- プログラム  -- MeCab -- MeCab [Alt + 半角全角]で入力
## Mac (Linux) 版
## Finder -- アプリケーション -- ターミナル -- mecab[かな]で入力ctrl+cで終了

彼はRを使った。
彼      名詞,代名詞,一般,*,*,*,彼,カレ,カレ
は      助詞,係助詞,*,*,*,*,は,ハ,ワ
R       名詞,一般,*,*,*,*,*
を      助詞,格助詞,一般,*,*,*,を,ヲ,ヲ
使っ    動詞,自立,*,*,五段・ワ行促音便,連用タ接続,使う,ツカッ,ツカッ
た      助動詞,*,*,*,特殊・タ,基本形,た,タ,タ
        名詞,固有名詞,組織,*,*,*,*
EOS

##出力の順番
###表層型品詞、品詞細分類１、細分類２、細分類３、活用形、活用型、原形、読み、発音

##お正月の読みはオショウガツ発音はオショーガツ

## 品詞情報出力は IPA 素性辞書にそっている
##http://chasen.aist-nara.ac.jp/snapshot/ipadic/ipadic/doc/ipadic-ja.pdf

####IPA辞書については
######http://parame.mwj.jp/blog/0209
######http://www.unixuser.org/~euske/doc/postag/index.html
####にわかりやすい説明があります

#### MeCab では UniDic  などの辞書も利用することができる
#####http://www.tokuteicorpus.jp/dist/


##活用語には「表層形」と「原形」がある
##  例文：「彼は R を使う。」
##  例文：「彼女も R を使った。」

彼はRを使った。
彼      名詞,代名詞,一般,*,*,*,彼,カレ,カレ
は      助詞,係助詞,*,*,*,*,は,ハ,ワ
R       名詞,一般,*,*,*,*,*
を      助詞,格助詞,一般,*,*,*,を,ヲ,ヲ
使っ    動詞,自立,*,*,五段・ワ行促音便,連用タ接続,使う,ツカッ,ツカッ
た      助動詞,*,*,*,特殊・タ,基本形,た,タ,タ
。記号,一般,*,*,*,*,*
EOS

彼女もRを使う。
彼女    名詞,代名詞,一般,*,*,*,彼女,カノジョ,カノジョ
も      助詞,係助詞,*,*,*,*,も,モ,モ
R       名詞,一般,*,*,*,*,*
を      助詞,格助詞,一般,*,*,*,を,ヲ,ヲ
使う    動詞,自立,*,*,五段・ワ行促音便,基本形,使う,ツカウ,ツカウ
。記号,一般,*,*,*,*,*
EOS


##「使った」と「使う」は表層形としては異なるが、形態素としては同じである。
##したがって語の種類（異なり語、タイプ）を考える場合、二つの語ではなく、
##一つの語として数えるべきである。
###ただし「使う」という一つの異なり語が、このテキストの延べ語数（トークン）には二つ含まれている。




#[午前-1-5]

##RMeCabパッケージの導入 # CRAN には登録しておりません
### http://cran.r-project.org/

##http://rmecab.jp  
## http://groups.google.co.jp/group/rmecab

### Windows の場合MeCabに添付される libmecab.dll を
### RMeCab に同封される RMeCab.dll と同じ場所へコピーする必要がある
file.show("README_RMeCab.txt")


#[午前-1-6]

## RMeCabの基本操作

library(RMeCab)

  #Rではデータはベクトル単位である
  vec <- c(1,2,3)
  vec
  
  # ベクトルの各要素には名前をつけることができる
  names(vec) <- c("A","B","C")
  vec

  ##ベクトルなどを要素として取り込んだデータ形式にリストがある
  (vec1 <- 1:3)        # 全体を括弧でくくると、実行後、結果を表示する
  (vec2 <- LETTERS[1:3])
  myList <- list(vec1,vec2)
  myList
  unlist(myList)


##テキストは複数の語（形態素）からなり、かつ
## 一つの単語について複数の情報（品詞、原形、読み）があるので
##リストの操作が重要になる

#[午前-1-7]

# RMeCabC 関数 教科書p.52

res1 <- RMeCabC("すもももももももものうち")
res1
unlist(res1)
# unlist 関数はリストをベクトルに変える


### 特定の名前と一致する要素を探す
res2 <- unlist(res1)   
res2[ names(res2) == "名詞" ]

length(res2[names(res2) == "名詞"])
#lengthは要素数（ベクトルの長さ）を返す

### 複数の名前のいずれかと一致する要素を探す。%in%を使う

res2[names(res2) %in% c("名詞","助詞")]


#####
#RMeCabCには第二引数を指定できる

res1 <- table(unlist(RMeCabC("彼はRを使う。",1)))
res1

res2 <- table(unlist(RMeCabC("彼女もRを使った。",1)))
res2

res3 <- merge(data.frame(res1),data.frame(res2),by = "Var1",all = TRUE)
res3




#[午前-1-8]

# RMeCabText 関数 教科書p.55

getwd()

setwd("C:/data")

res <- RMeCabText("yukiguni.txt")
# ファイルの読み込みではフォルダを指定する

#フォルダの指定は絶対パスを指定しても良い
     res <- RMeCabText("/Users/ishida/data/yukiguni.txt")#ファイル名だけを指定する

res
##MeCabの出力をそのまま返す。以下のように加工して使うことも可能。

### 原型を拾う

res2 <- lapply(res,"[[",8)
data.frame(table(unlist(res2)))

### 発音を拾う

res2 <- lapply(res,"[[",9)
data.frame(table(unlist(res2)))


  ##lapply関数はR以外のプログラミング言語には見られない特徴的な関数である
  ###便利で高速な処理を行うが、反面、直感的にわかりにくいところがある
  
  vec1 <- 1:1000
  vec2 <- 5000:6000
  vec3 <- 9000:10000

  myList <- list(vec1,vec2,vec3)
  head(myList)

  ## myListには三つの要素（ベクトル）があるが、そのそれぞれの平均を求めるには？

  for(i in 1:length(myList)){
    print(mean(myList[[i]]))
  }
  ## myList[i] はエラーになるので注意

  ## ループを避ける
  lapply(myList,mean)
  sapply(myList,mean)



########################### 午前２####################################

##### 日本語解析の実際


#[午前-2-1]  

##形態素解析の結果の加工

##ユーザーの側で追加の処理が必要なもの
###語形の統合
###馬、うま、ウマの三つは異なる単語として別々にカウントすべきではない
###計算機、コンピュータ、電算機は異なる単語であるが、意味は同じとしてまとめてカウントしたい

## 語形についてはMeCabの辞書で定義しておく。教科書p.58
###あるいは次のような処理を行う

test <- c("うま","ウマ","馬","犬")
test
 
test[test %in% c("うま","ウマ")] <- "馬"
test

##同義語
test <- c("食卓","テーブル","椅子")
test
 
test[test %in% c("テーブル","食卓")] <- "卓"
test

### 同義語については以下のデータベースをRに組み込み、ある程度自動的に語義による統一も可能

 #日本語 WordNet http://nlpwww.nict.go.jp/wn-ja/

 # 計算機をキーワードにした結果

 #   Jpn: 計算機, 電子計算機, データプロセッサー, 電算, コンピュータ, コンピューター, 計算器, 電算機, 電脳 
 #   Eng: data processor, information processing system, computing device, computer, electronic computer, computing machine 



## さらには形態素解析器の出力のすべてが必要になるわけではない。

###内容語あるいは機能語のみを抽出
###頻度がある閾値を超えるタームのみ利用
####など検討が必要

###アンケート分析 -- 内容語
###文体の解析 -- 機能語
###テキスト分類 -- 閾値を超えるターム


##市販のソフトウェアは、これらの処理をマウス操作で直感的に行えるのが売りであろう。
###それ以外の機能についてはRのほうがはるかに優れている

## いずれにせよ、最終的にはユーザーの側で手作業での修正を行わざる得ない
##当然主観が入ることになるが、処理は一括して行うなどして、第三者が再現できるようにする





#[午前-2-2]

# テキストデータそのものについては種類は大きく二つ
## RMeCab には、それぞれのタイプのいずれか、あるいは両方に適した関数が用意されている

setwd("C:/data")

##[データファイル]アンケートの集計結果のように、特定の列に「自由記述文」が記録されている
file.show("photo.csv")
###この場合は以下の関数を用いる

RMeCabDF      (p.60)
docMatrix     (p.69)
docNgramDF    (記載なし)
docDF         (記載なし)

##[テキストファイル]ファイル全体がテキストである。
file.show("merosu.txt")
###この場合は以下の関数を用いる

 MeCabFreq s,                 (p.56)
 docMatrix s,  docMatrix2 s-p (p.62 -72 改編あり)
 Ngram     s,                 (p.72)
 NgramDF   s,  NgramDF2   s-p (p.75)
 docNgram  p,  docNgram2  s-p (p.77)
 collocate s                  (p.79)
 docDF     s-p                (記載なし)



####前者、データファイルの処理
##ファイルをデータフレームとして読み込み、特定の列だけを解析したオブジェクトを別に作成する



#[午前-2-3]

#RMeCabDF関数 p.60
 ?RMeCabDF

setwd("C:/data")

file.show("photo.csv")

dat <- read.csv("photo.csv")
dat # データの形式はデータフレーム

res <- RMeCabDF(dat, "Reply", 1)
res


#[午前-2-4] 

#docMatrixDF関数 p 69 # 2009 3月共起行列機能を追加
 ?docMatrixDF

##ターム・文書行列を出力
###ターム・文書行列とは行あるいは列に言語要素（文字や語）を、
###また列あるいは行にテキスト（被験者回答）をとり
###交差する成分が、頻度などを表すデータである


res <- docMatrixDF(dat$Reply, pos = c("名詞","形容詞","助詞"))
res

###ターム・文書行列では頻度をそのまま使うのではなく、これに「重み」をかけることがある。
###重みについてはあとでdocMatrix関数を利用する際に補足する

res <- docMatrixDF(dat$Reply, pos = c("名詞","形容詞","助詞"), weight = "tf*idf")
res

res <- docMatrixDF(dat$Reply, pos = c("名詞","形容詞","助詞"), weight = "tf*idf*norm")
res

colSums(res^2)


#[午前-2-5]

# 2009 3月共起行列機能を追加 # 教科書に記載はありません
res <- docMatrixDF(dat$Reply, pos = c("名詞","形容詞","動詞"), co = 1)
res#交差する単語のペアが共起しているテキストの数

dat


#[午前-2-6]

#docNgramDF関数 # 2009 3月新規追加教科書に記載はありません
 ?docNgramDF

## 被験者を行にとり、文字あるいは語の Ngramを列に取る
### Ngram については後に詳しく述べる

res <- docNgramDF(dat$Reply)
res


res <- docNgramDF(dat$Reply, N=2)
res


res <- docNgramDF(dat$Reply, type = 1)
res


res <- docNgramDF(dat$Reply, type = 1, N=2)
res





###テキストファイル、あるいはテキストファイルを含むフォルダ全体を対象とする

#[午前-2-7]

# RMeCabFreq 関数p.56#もっともオーソドックスな頻度表
?RMeCabFreq

#形態素原型の頻度表#教科書p.56

res <- RMeCabFreq("yukiguni.txt")
res

aggregate(res$Freq,res[1:2], sum)

  ## 品詞情報を一切考慮せず、語形だけでカウントするなら（その必要があれば）
 # aggregate(res$Freq,res[1], sum)
 # tapply(res$Freq,res$Term, sum)


#[午前-2-8]

###検索結果を効率的に検索する


res[res$Freq >= 2, ] 

res[res$Info1 %in% c("名詞","形容詞"), ]

res[grep("国", res$Term), ]

#grep 関数とメタ文字|による検索「正規表現」
res[grep("国|い", res$Term), ]

# 最初の文字が「国」である形態素を抽出
res[grep("^国", res$Term), ]


# 最後の文字が「国」である形態素を抽出
res[grep("国$", res$Term), ]


## 取り出した要素に、もとのリストでの総頻度を追加したデータフレームを作成しなおす
rbind(res[grep("国|い", res$Term), ], data.frame(Term = "TOTAL",
     Info1 = NA, Info2 = NA, Freq = sum(res$Freq) ) )






#################################
###ターム・文書行列の作成

##[午前-2-9]

# ?docMatrix 関数?docMatrix2 関数p.62
##重み共起行列 # 教科書p.70
##引数が教科書の記載とは異なっています
###sym引数を廃止し、kigo引数に代えました

setwd("C:/data")

## 教科書で利用しているデータとは文章が若干異なります
file.show("doc/doc1.txt")
file.show("doc/doc2.txt")
file.show("doc/doc3.txt")

#doc1.txt 私は真面目な学生です。
#doc2.txt 彼女は数学科の良い学生です。
#doc3.txt 彼女は難しい数学を学んでいます。


##デフォルトでは名詞と形容詞を抽出
res <- docMatrix("doc")
res

##抽出する品詞を変えてみる
res <- docMatrix("doc", pos = c("名詞","助詞") )
res

## docMatrix()の情報行を削除
res <- res[ row.names(res) !=  "[[LESS-THAN-1]]" , ]
res <- res[ row.names(res) !=  "[[TOTAL-TOKENS]]" , ]
res


#句読点などの記号を総計に含めるか否か
res <- docMatrix("doc", kigo = 1) # sym 引数を廃止
res[order(rownames(res)),]

# docMatrix2関数は総計を含まない行列を返す
res2 <- docMatrix2("doc", kigo = 1)
res2[order(rownames(res2)),]


## やや大きめのテキスト集合

res <- docMatrix("morikita", minFreq = 2)
head(res)

res <- res[ row.names(res) != "[[LESS-THAN-2]]", ]
 # LESS-THAN-1ではない
res <- res[ row.names(res) != "[[TOTAL-TOKENS]]", ]
res

##docMatrix関数とdocMatrix2関数の違い
###関数の内部コーディングでの計算が前者がベクトル、後者は行列
### minFreq 引数指定による結果が違う
  # 行列作成時に minFreq引数を指定した結果とは異なる（p.66）
  #いずれかの文書で頻度が２以上のタームのみを行列に含める

#docMatrix2 関数では、すべての文書を通しての合計頻度が２以上のタームだけ
res2 <- docMatrix2("morikita", minFreq = 2)
  res2 <- res2[order(rownames(res2)),]
  res2


  #  docMatrix2("morikita", minFreq = 2) と同じ出力を docMatrix で求める
res <- docMatrix("morikita")
res <- res[ row.names(res) != "[[LESS-THAN-1]]", ]
res <- res[ row.names(res) != "[[TOTAL-TOKENS]]", ]

res3 <- res[rowSums(res) >= 2, ]
res3 <- res3[order(rownames(res3)),]

all(res2 == res3)   # すべてが一致しているかどうか

## 総頻度タームにおよび記号を含める
res <- docMatrix("doc", pos = c("記号","名詞","形容詞"))
res


##重み付け p.70
## tf (term frequency) 文書に出現する程度--通常は頻度をそのまま使う
##idf (inverse document frequency)  文章集合における語の相対的重要度
##norm (normalization) 文書の長さに影響されないよう標準化

#詳細は徳永健伸著『情報検索と言語処理』東京大学
#詳細は北研二他著『情報検索アルゴリズム』共立出版

res <- docMatrix("doc", pos = c("名詞","助詞"), weight = "tf*idf" )
res # ひとつの文書だけに出現する語の重みが大きくなっている

#doc1.txt 私は真面目な学生です。
#doc2.txt 彼女は数学科の良い学生です。
#doc3.txt 彼女は難しい数学を学んでいます。


##さらに標準化を行う
res <- docMatrix("doc", pos = c("名詞","助詞"), weight = "tf*idf*norm" )
res

colSums(res^2)




###教科書未記載の機能

#[午前-2-10]

##共起行列#二つのタームが互いに含まれていた文書数

res <- docMatrix("doc", co = 1)
res

res <- docMatrix("doc", pos = c("名詞","助詞"), co = 1)
res




##### Ngram のカウント

#[午前-2-11]

# Ngram 関数 p.73
?Ngram

res <- Ngram("yukiguni.txt")
 # 文字のbigram
res

res <- Ngram("yukiguni.txt", N=3)
 # 文字のtrigram
res

res <- Ngram("yukiguni.txt",type =1)
 # 形態素のbigram
res

res <- Ngram("yukiguni.txt",type =1,pos = c("名詞","形容詞","助詞"), N = 3)
 # 形態素のbigram
res


res <- Ngram("yukiguni.txt",type =2)
 # 品詞のbigram
res


#[午前-2-12]

## NgramDF 関数 とNgramDF2 関数
?NgramDF?NgramDF2

## ネットワーク分析用の関数へのインプットとなる

res <- NgramDF("yukiguni.txt",type =1)
 # 形態素のbigram
res
   # 先ほど紹介したNgram関数の場合
   res <- Ngram("yukiguni.txt",type =1)
    # 形態素のbigram
   res


## NgramDF2 関数は単独ファイルだけでなく、フォルダ全体も解析対象とする
res <- NgramDF2("doc",type =1)
    # 形態素のbigram
res



#[午前-2-13]

# docNgram 関数 とdocNgram2 関数
##Ngram頻度を要素とする行列を作成
?docNgram ?docNgram2
# 

res <- docNgram("doc")
 # 形態素がデフォルト
res

res <- docNgram2("doc")
 #文字がデフォルト
res

res <- docNgram2("doc", type = 1)
res

## docNgram2 関数には重みを指定できる
res <- docNgram2("doc", type = 1, weight = "tf*idf*norm") 
res
colSums(res^2)



#[午前-2-14]

# docDF 関数 # 教科書に記載なし
### 汎用関数です。ここまで紹介した関数機能を網羅した関数
###docDFとRMeCabC, RMeCabText の三つの関数だけを実装した R2MeCab パッケージもあります

?docDF

res <- docDF("doc")
 #デフォルト文字のカウント
res

res <- docDF("doc", type = 1)
 #単語の頻度表
res


res <- docDF("doc", type = 1, N=2)
 #Ngram
res


res <- docDF("doc", type = 1, N=2, nDF = 1)#Ngramを列ごとに
res

# データフレームを対象
dat <- read.csv("photo.csv")
dat

res <- docDF(dat, col = "Reply", type = 1, N = 2)
res

## 表層形で出力
res <- docDF(dat, col = "Reply", type = 1, N = 2, Genkei = 1)
res


## 表層形で出力、かつ列を別に取る
res <- docDF(dat, col = "Reply", type = 1, N = 2, Genkei = 1, nDF = 1)
res


#[午前-2-15]

##collocate関数と collScores関数#語の共起関係p.79

merosu <- RMeCabFreq("merosu.txt")
merosu[merosu$Term == "友",]
merosu[merosu$Term == "友人" |merosu$Term == "友達",]#or検索
merosu[grep("友", merosu$Term), ] # grep を使った検索

merosu[merosu$Info1 %in% c("形容詞","動詞"), ]
merosu <- collocate("merosu.txt", node = "友", span = 3)
merosu2 <- collScores(merosu, node = "友", span = 3)
merosu2[order(merosu2$MI),] # 「友」と共起の高い語




############################# 以上午前#################################



##午後の予定
###午後３テキストマイニング基礎編Zipfの法則、語彙の比較
###午後４応用編：アンケート分析、テキスト分類
###午後５ネットワーク分析、係り受け、欧米語テキストの場合



#############################午後 ３#######################################

############################## 基礎編

##### 形態素解析の結果がどのように使えるのか

# [午後-3-1]
 
#####有名なZipfの法則##金明哲著『テキストデータの統計科学』第５章から

# 頻度とその順位（ランク）には一定の関係がある（直線で表現できる）
## 鳩山首相の所信表明演説
setwd("C:/data")

file.show("Jin/Hatoyama.txt")

hatoyama <- RMeCabFreq("Jin/Hatoyama.txt")
nrow(hatoyama)
which(hatoyama$Term == "友愛")
hatoyama[1193:1200,]
  
  ### docDF 関数を使っても良い
  # hatoyama <- docDF("Jin/Hatoyama.txt", type =1)
  # nrow(hatoyama)
  # head(hatoyama)



#! 演算子を使って数詞と記号を取り去る
hatoyama <- hatoyama[!(hatoyama$Info1 %in% c("数", "記号")),]
nrow(hatoyama)

##順位で並べる
hatoyama2 <- data.frame(rank= 1:nrow(hatoyama), hatoyama[order(hatoyama$Freq, decreasing=T),c("Term", "Freq")])
head(hatoyama2)

par(mfrow = c(1,2))
  # グラフィックス画面を二つに分ける命令
plot(hatoyama2$rank, hatoyama2$Freq, xlab ="ランク", ylab="頻度")
plot(log(hatoyama2$rank), log(hatoyama2$Freq), xlab ="ランクの対数", ylab="頻度の対数")


## したがって原理的には、線形回帰が可能になる

hatoyama.lm <- lm(log(hatoyama2$Freq) ~ log(hatoyama2$rank) )
summary(hatoyama.lm)
abline( hatoyama.lm ,col=2, lwd = 3)

dev.off()

data.frame(hatoyama2[1:10,], exp(6.53 + -0.94 * log(1:10))  )
                            # exp(predict(hatoyama.lm)[1:10])#


# [午後-3-2]

## 語彙の豊かさ
###延べ語と異なり語

(V1 <- nrow(hatoyama) )
   # 異なり語（タイプ）
(N1 <- sum(hatoyama$Freq) )
   #  延べ語（トークン）

V1 / N1
   #タイプ・トークン比

##  麻生元総理の場合

file.show("Jin/Aso.txt")

aso <- RMeCabFreq("Jin/Aso.txt")
nrow(aso)

aso <- aso[!(aso$Info1 %in% c("数", "記号")),]
###延べ語と異なり語
(V2 <- nrow(aso) )
(N2 <- sum(aso$Freq) )

V2 / N2



## 頻度スペクトル # H. Baayen "Word Frequency Distributions" Kluwer
### 頻度スペクトルとは、ある頻度で使われたタイプがいくつあるかをカウントしたものである

aso2 <- aso[order(aso$Freq, decreasing=T),c("Term", "Freq")]
head(aso2)
   # 頻度が172の語はひとつで「を」、頻度が160の語もひとつで「の」
aso2[aso2$Freq == 15,]
   #頻度が15の語は二つある

aso3 <- data.frame(table(aso2$Freq))
   #頻度スペクトルの作成

colnames(aso3) <- c("m","VmN")
head( aso3 )



# [午後-3-3]

## 頻度スペクトルを利用して語彙の豊かさをはかる

###Yule ' K 
# K <- (sum(m^2 * VmN) - N ) / N^2 * 10^4

#### トークン数 N が100語で、そのすべてが異なる場合 m = 1, VmN = 1
((1^2 * 1)*100 - 100) / 100^2 * 10^4

#### トークン数 N が100語で、そのすべてが同じ場合 m = 1, VmN = 1

(100^2 * 1 - 100) / 100^2 * 10^4

## Kの小さいほうが語彙が豊か

### 麻生首相の場合

K1 <- (sum( as.numeric(aso3$m)^2 * aso3$VmN )  - sum(aso3$VmN) ) / (sum(aso3$VmN))^2  * 10^4



### 鳩山首相の場合

hatoyama2 <- hatoyama[order(hatoyama$Freq, decreasing=T),c("Term", "Freq")]
head(hatoyama2)
  # 頻度が172の語はひとつで「を」、頻度が160の語もひとつで「の」
hatoyama2[hatoyama2$Freq == 15,]
  #頻度が15の語は二つある

hatoyama3 <- data.frame(table(hatoyama2$Freq))
  #頻度スペクトルの作成


colnames(hatoyama3) <- c("m","VmN")
head(hatoyama3)


### 鳩山首相の語彙の豊かさ#Yule ' K

K2 <- (sum( as.numeric(hatoyama3$m)^2 * hatoyama3$VmN )  - sum(hatoyama3$VmN) ) / (sum(hatoyama3$VmN))^2  * 10^4


K1 < K2







# [午後-3-4]

#### 話題分析（特徴語の抽出）  ## 金明哲著『テキストデータの統計科学入門』第12章

##安部、福田、麻生、鳩山氏らの首相就任所信表明演説

res <- docDF("Jin", pos=c("名詞","動詞","形容詞"), type = 1, minFreq = 20)
unique(res$POS2)
res[res$POS2 == "接尾",]
res <- res[!(res$POS2 %in% c("数","非自立", "接尾", "代名詞") ), ]
nrow(res)
head(res)

## 数値データのみからなる行列に変える
rownames(res) <- res$TERM
res <- res[, -which(colnames(res) %in% c("TERM","POS1", "POS2"))]
    ##res <- res[, -c(1,2,3)]
head(res)


##主成分分析##多くの次元（単語）の情報を可能な限り圧縮する手法
res.pc <- princomp(res, scale = 1)
biplot(res.pc)

rownames(res)
res2 <- res[!(rownames(res) %in% c("する","ある","すべて","ない","なる")), ] 
rownames(res2)

res2.pc <- princomp(res2, scale = 1)
biplot(res2.pc)


## 主成分負荷量#もとのデータと合成変数（主成分）の相関を意味している
barplot(res2.pc$loadings[,1])

barplot(res2.pc$loadings[,2])

##もとのデータの主成分得点（主成分ともとデータの線形結合）を小さい順に並べてみる
sort(res2.pc$scores[,2])






# [午後-3-5]

##### 助詞と読点 鴎外と漱石
##金明哲『テキストデータの統計科学入門』岩波書店
##村上征勝『真贋の科学』朝倉書店

dir("writers")

res <- docNgram("writers", type = 0)
                # writers はフォルダ名

res2 <- res[ rownames(res) %in% c("[と-、]", "[て-、]", "[は-、]", "[が-、]", "[で-、]",  "[に-、]",  "[ら-、]",  "[も-、]" ) ,  ]
res2


## 鴎外また漱石それぞれについて、助詞＋句点の使い方の平均を見る
res3 <- data.frame(Ogai = rowMeans(res2[,1:4]), Soseki= rowMeans(res2[,5:8]))
res3

##箱ひげ図 ## それぞれデータが四つだけなので、ちょっと無理だが

par(mfrow = c(1,2))
boxplot(res2["[が-、]",1:4], res2["[が-、]",5:8], main = "が", names = c("鴎外","漱石") )
boxplot(res2["[は-、]",1:4], res2["[は-、]",5:8], main = "は", names = c("鴎外","漱石") )

dev.off()

plot( res2["[は-、]",], res2["[が-、]",], type = "n")
text(res2["[は-、]",], res2["[が-、]",], label=c( rep("O", 4), rep("S", 4)),
   col =c(rep("red", 4), rep("blue", 4) ))






#############################  午後４########################

############################# 応用編１

# [午後-4-1]


#####口コミ情報の分析
setwd("C:/data")

phone <- RMeCabFreq("phone.txt")
  # ファイルの読み込み
## phone.txtはGoogleの検索結果の見出し。ただし商品名は省いている
nrow(phone)
  # 行数 (形態素数) の確認


## 抽出した結果にはあらゆる品詞が入っているので，取捨選択する．
###ここでは携帯電話の評価に関する記述に興味があるので，内容語を抽出する．
###すなわち名詞や形容詞，そして動詞などである．

## ただし名詞と分類されるものでも，「こと」のように，評価には直接関係ない形態素もある．
## そこで品詞第２情報を使って，これらの語をのぞく．すなわち非自立語と数詞をのぞく．


phone[1:3,]
phone[phone$Term == "こと",]
  #評価には直接関係のない「名詞」


phone2 <- phone[ (phone$Info1 %in% c("名詞", "形容詞", "動詞", "助動詞") ) &
		                   !(phone$Info2 %in% c("非自立", "数" )),  ]

 nrow(phone2)
    # 出力の行数を確認する
#
phone2[1:3,]
    # 最初の 3 行を確認する

phone3 <- phone2[phone2$Freq> 2,]
    # 頻度が 2 より大きい場合 
nrow(phone3)
#
phone3[rev(order(phone3$Freq)),]


# 以上のように抽出した結果をもとのテキストと照合したい
### R に取り込んでいるのは，もとのテキストを加工した結果である．
### 別のソフト（Wordなど）を起動して元ファイルを表示し，検索をかけて確認する方法もある．
### が，ここでは R から元テキストをそのまま取り込んで照合してみたい．

phoneRaw <- readLines("phone.txt")
length(phoneRaw)
# 		 [1] 100               # phone.txt は100行からなる

phoneMorp <- list(100)
##作業用の一時オブジェクト

# 教科書とはコードを変えています
for(i in 1:100){
		     phoneMorp[[i]] <- unlist(RMeCabC(phoneRaw[i], 1))
		     if(any( phoneMorp[[i]] %in%   c("売れる", "使える", "ない" ))){
               print(phoneRaw [i])

		     }
		 }







############################################

# [午後-4-2]

#####アンケート分析の実際
#####沖縄県観光課が実施した観光客アンケート調査の分析対応分析

#####                分析手順１：データの読み込み
http://www3.pref.okinawa.jp/site/view/contview.jsp?cateid=233&id=14739&page=1

setwd("C:/data")

okinawa <- read.csv("H18koe.csv")

nrow(okinawa) 

# 自由記述欄以外の要約
summary(okinawa[, -1])

colnames(okinawa)

res <- RMeCabDF(okinawa, "opinion", 1)
  # res <- RMeCabDF(okinawa, 1, 1) # に同じ 
length(res) 
head(res)


#####################################

   ## 途中経過を確認しつつ作業するのではなく、結果だけをえるだけなら
   ## 教科書の全コードは 以下に代えられる。

     okinawa$newVar <- interaction(okinawa$Sex, okinawa$Age)
    # で新規の列を追加して
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
    length(newList2) # 14グループ
     ###(データには７０代の回答もある okinawa[okinawa$Age == "７０代",1])
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
    #######################################################
           #  reshapeパッケージを使わないのであれば
           #for(i in 1:length(newList4)){
           #  if(length(newList3[[i]])>   0){
           #    newList4[[i]]$id <- names(newList4[i])
           #  }
           # }
           # newTable <- do.call("rbind", newList4)
           # newTable2 <- xtabs(Freq ~ Var1 + id, data = newTable)
           # newTable2 <- newTable2[, 
           #      !(colnames(newTable2) %in% c("女性.７０代","男性.７０代"))] 
           # library(MASS)
           # okinawa.corr  <- corresp(newTable2,  nf = 2)
           # biplot( okinawa.corr )

    ## ただしテキストマイニングでは、出力を確認・検討しながら実行すべきである

#####################################

#####          {分析手順２：データの概観}

res.t <- table(unlist(res))
length(res.t)
  ##ターム数

res.t[ rev(order(res.t)) ][1:10]
  # 高頻出ターム




#####           {分析手順３：内容語（ここでは名詞と形容詞）のみを抽出する}
res2 <- list()


noun.adj <- function(x){
  x [names(x) %in% c("名詞", "形容詞")]
}
res2 <- lapply(res, noun.adj)

  ## 教科書には以下のコードがありますが、結果は上と変わりません。
  #  for(i in 1:length(res)){
  #    res2[[i]] <-  res[[i]][names(res[[i]]) == "名詞" | names(res[[i]]) == "形容詞"]
  # }

length(res2)



length(unlist(res2))
length(unique(unlist(res2)))
res.t2 <- table(unlist(res2))
length(res.t2)#

res.t2[ rev(order(res.t2)) ][1:10]



#####            {分析手順４：性別と年齢ごとの回答を抽出}
 

############ 60 代
##女性
res60F <- list()

for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "６０代"){

    res60F[[i]] <-  res2[[i]]
  }else{  res60F[[i]] <- NA }
}
length(res60F)

## 沖縄と観光，旅行 は除いた上位 10 位
res60F1 <- unlist(res60F) [unlist(res60F) != "沖縄" & unlist(res60F) != "観光"& unlist(res60F) != "旅行"]
res60F.t <- table(res60F1)
res60F.t <- res60F.t [rev(order(res60F.t))][1:10]
res60F.t 


## 男性
res60M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "６０代"){
    res60M[[i]] <-  res2[[i]]
    
  }else{  res60M[[i]] <- NA }
}

# 沖縄と観光，旅行 は除いた上位 10  位
res60M1 <- unlist(res60M) [unlist(res60M) != "沖縄" & unlist(res60M) != "観光"& unlist(res60M) != "旅行"]
res60M.t <- table(res60M1)
res60M.t <- res60M.t [rev(order(res60M.t))][1:10]
res60M.t


############ 50 代
##女性

res50F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "５０代"){

    res50F[[i]] <-  res2[[i]]
  }else{  res50F[[i]] <- NA }
}

## 沖縄と観光，旅行 は除いた上位 10 位
res50F1 <- unlist(res50F) [unlist(res50F) != "沖縄" & unlist(res50F) != "観光"& unlist(res50F) != "旅行"]
res50F.t <- table(res50F1)
res50F.t <- res50F.t [rev(order(res50F.t))][1:10]
res50F.t


## 男性
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


############## 40代
##女性

res40F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "４０代"){
    res40F[[i]] <-  res2[[i]]
  }else{  res40F[[i]] <- NA }
}

# 沖縄と観光，旅行 は除いた上位 10 位
res40F1 <- unlist(res40F) [unlist(res40F) != "沖縄" & unlist(res40F) != "観光"& unlist(res40F) != "旅行" ]
res40F.t <- table(res40F1)
res40F.t <- res40F.t [rev(order(res40F.t))][1:10]
res40F.t 

##男性

res40M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "４０代"){
    res40M[[i]] <-  res2[[i]]
  }else{  res40M[[i]] <- NA }
}

# 沖縄と観光，旅行 は除いた上位 10 位
res40M1 <- unlist(res40M) [unlist(res40M) != "沖縄" & unlist(res40M) != "観光"& unlist(res40M) != "旅行" ]
res40M.t <- table(res40M1)
res40M.t <- res40M.t [rev(order(res40M.t))][1:10]
res40M.t



############## 30代
##女性
res30F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "３０代"){
    res30F[[i]] <-  res2[[i]]
  }else{  res30F[[i]] <- NA }
}

# 沖縄と観光，旅行 は除いた上位 10 位
res30F1 <- unlist(res30F) [unlist(res30F) != "沖縄" & unlist(res30F) != "観光"& unlist(res30F) != "旅行" ]
res30F.t <- table(res30F1)
res30F.t <- res30F.t [rev(order(res30F.t))][1:10]
res30F.t 


## 男性
res30M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "３０代"){
    res30M[[i]] <-  res2[[i]]# 
  }else{  res30M[[i]] <- NA }
}

# 沖縄と観光，旅行 は除いた上位 10 位
res30M1 <- unlist(res30M) [unlist(res30M) != "沖縄" & unlist(res30M) != "観光"& unlist(res30M) != "旅行" ]
res30M.t <- table(res30M1)
res30M.t <- res30M.t [rev(order(res30M.t))][1:10]
res30M.t 


############ 20代
##女性
res20F <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "女性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "２０代"){
    res20F[[i]] <-  res2[[i]]# 
  }else{  res20F[[i]] <- NA }
}

# 沖縄と観光，旅行 は除いた上位 10 位
res20F1 <- unlist(res20F) [unlist(res20F) != "沖縄" & unlist(res20F) != "観光"& unlist(res20F) != "旅行" ]
res20F.t <- table(res20F1)
res20F.t <- res20F.t [rev(order(res20F.t))][1:10]
res20F.t 

##男性

res20M <- list()
for(i in 1:length(res2)){
  if(!is.na(okinawa$Sex[i]) & okinawa$Sex[i] == "男性" & !is.na(okinawa$Age[i]) & okinawa$Age[i] == "２０代"){
    res20M[[i]] <-  res2[[i]]
  }else{  res20M[[i]] <- NA }
}

# 沖縄と観光，旅行 は除いた上位 10 位
res20M1 <- unlist(res20M) [unlist(res20M) != "沖縄" & unlist(res20M) != "観光"& unlist(res20M) != "旅行" ]
res20M.t <- table(res20M1)
res20M.t <- res20M.t [rev(order(res20M.t))][1:10]
res20M.t 



#####                 {分析手順５：各世代・性別ごとの頻出語}
## ラベルの作成
okinawa.lab <- unique(c(names(res20F.t), names(res20M.t), names(res30F.t), names(res30M.t), names(res40F.t), names(res40M.t),  names(res50F.t), names(res50M.t), names(res60F.t), names(res60M.t) ))

okinawa.lab  


#####                {分析手順６：頻出語の間引き}
oki <-  which(okinawa.lab %in%  c("さ", "の","こと","ない","私","者", "よう", "等","前","日", "那覇",  "今回", "方","大変","地", "ー") )

okinawa.lab <- okinawa.lab [ -oki ]
okinawa.lab



#####                 {分析手順７：対象語の統合}
## データフレームの作成

res60F1[which(res60F1 == "きれい")] <- "美しい"
res60F1[which(res60F1 == "欲しい")] <- "ほしい"
res60F1[which(res60F1 == "いい")] <- "良い"
res60F.t2 <- table(res60F1)
res60F.t3 <- res60F.t2[names(res60F.t2) %in% okinawa.lab]
res60F.t3



res60M1[which(res60M1 == "きれい")] <- "美しい"
res60M1[which(res60M1 == "欲しい")] <- "ほしい"
res60M1[which(res60M1 == "いい")] <- "良い"
res60M.t2 <- table(res60M1)
res60M.t3 <- res60M.t2[names(res60M.t2) %in%  okinawa.lab] 

res50F1[which(res50F1 == "きれい")] <- "美しい"
res50F1[which(res50F1 == "欲しい")] <- "ほしい"
res50F1[which(res50F1 == "いい")] <- "良い"
res50F.t2 <- table(res50F1)
res50F.t3 <- res50F.t2[names(res50F.t2) %in%  okinawa.lab]

res50M1[which(res50M1 == "きれい")] <- "美しい"
res50M1[which(res50M1 == "欲しい")] <- "ほしい"
res50M1[which(res50M1 == "いい")] <- "良い"
res50M.t2 <- table(res50M1)
res50M.t3 <- res50M.t2[names(res50M.t2) %in%  okinawa.lab]

res40F1[which(res40F1 == "きれい")] <- "美しい"
res40F1[which(res40F1 == "欲しい")] <- "ほしい"
res40F1[which(res40F1 == "いい")] <- "良い"
res40F.t2 <- table(res40F1)
res40F.t3 <- res40F.t2[names(res40F.t2) %in%  okinawa.lab]

res40M1[which(res40M1 == "きれい")] <- "美しい"
res40M1[which(res40M1 == "欲しい")] <- "ほしい"
res40M1[which(res40M1 == "いい")] <- "良い"
res40M.t2 <- table(res40M1)
res40M.t3 <- res40M.t2[names(res40M.t2) %in%  okinawa.lab]

res30F1[which(res30F1 == "きれい")] <- "美しい"
res30F1[which(res30F1 == "欲しい")] <- "ほしい"
res30F1[which(res30F1 == "いい")] <- "良い"
res30F.t2 <- table(res30F1)
res30F.t3 <- res30F.t2[names(res30F.t2) %in%  okinawa.lab]

res30M1[which(res30M1 == "きれい")] <- "美しい"
res30M1[which(res30M1 == "欲しい")] <- "ほしい"
res30M1[which(res30M1 == "いい")] <- "良い"
res30M.t2 <- table(res30M1)
res30M.t3 <- res30M.t2[names(res30M.t2) %in% okinawa.lab]

res20F1[which(res20F1 == "きれい")] <- "美しい"
res20F1[which(res20F1 == "欲しい")] <- "ほしい"
res20F1[which(res20F1 == "いい")] <- "良い"
res20F.t2 <- table(res20F1)
res20F.t3 <- res20F.t2[names(res20F.t2) %in%  okinawa.lab] 

res20M1[which(res20M1 == "きれい")] <- "美しい"
res20M1[which(res20M1 == "欲しい")] <- "ほしい"
res20M1[which(res20M1 == "いい")] <- "良い"
res20M.t2 <- table(res20M1)
res20M.t3 <- res20M.t2[names(res20M.t2) %in%  okinawa.lab]




#####     {分析手順８：タームの整理結果から改めてデータフレームを新規作成}
okinawa.DF <- NULL

okinawa.DF <- data.frame(word = names(res20M.t3), id = rep("20M",length(res20M.t3) ), Freq = res20M.t3)

okinawa.DF <- rbind(okinawa.DF,
      data.frame(word = names(res20F.t3), id = rep("20F", length(res20F.t3)), Freq = res20F.t3),
      data.frame(word = names(res30M.t3), id = rep("30M", length(res30M.t3)), Freq = res30M.t3),
      data.frame(word = names(res30F.t3), id = rep("30F", length(res30F.t3)), Freq = res30F.t3),
      data.frame(word = names(res40M.t3), id = rep("40M", length(res40M.t3)), Freq = res40M.t3),
      data.frame(word = names(res40F.t3), id = rep("40F", length(res40F.t3)), Freq = res40F.t3),
      data.frame(word = names(res50M.t3), id = rep("50M", length(res50M.t3)), Freq = res50M.t3),
      data.frame(word = names(res50F.t3), id = rep("50F", length(res50F.t3)), Freq = res50F.t3),
      data.frame(word = names(res60M.t3), id = rep("60M", length(res60M.t3)), Freq = res60M.t3),
      data.frame(word = names(res60F.t3), id = rep("60F", length(res60F.t3)), Freq = res60F.t3))

okinawa.t <- xtabs(Freq ~ word + id, data = okinawa.DF)
row.names( okinawa.t )

#

#####              分析手順９：対応分析の実行

 library(MASS)

okinawa.corr  <- corresp(okinawa.t,  nf = 2)
biplot( okinawa.corr )


## 対応分析については
## B.エヴェリット (著) 『RとS-PLUSによる多変量解析』 シュプリンガー・ジャパン

#####               分析手順：もとデータの確認
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


###################





# [午後-4-3]

###########テキスト分類
######読売新聞WEB版記事の自動分類クラスター分析

setwd("C:/data")

DM <- docMatrix("yomi",   pos = c("名詞","動詞","形容詞"))
  DM <- DM[ row.names(DM) !=  "[[LESS-THAN-1]]" , ]
  DM <- DM[ row.names(DM) !=  "[[TOTAL-TOKENS]]" , ]

DM[100:105,]

  nrow(DM)
  ncol(DM)

  plot( hclust(dist( t(DM))) ) 
  plot( hclust(dist( t(DM))), hang = -1) 
methods(plot)
getS3method("plot", "hclust")

?plot.hclust
## pdf(file = "yomi2.pdf", family = "Japan1")
 plot( hclust(dist( t(DM), "canberra"), "ward"))
 plot( hclust(dist( t(DM), "canberra"), "ward"), hang = -1)

   yomi.clus <- hclust(dist( t(DM), "canberra"), "ward")

  # コーフェン行列の抽出  ## コーフェン行列で固体の距離からクラスター間の距離を求める
  cophenetic(yomi.clus)


##########潜在的意味インデキシングとは北研二他『情報検索アルゴリズム』

TD <- matrix(c(1,0,0,0,1,0,
                   0,1,0,1,0,1,
                   0,1,0,0,0,0,
                   0,1,0,0,0,0,
                   0,0,1,0,0,1,
                   1,1,1,1,0,0,
                   0,0,1,2,1,0,
                   1,1,0,0,0,0), nrow=8, byrow=T)

rownames(TD) <- c("Bioinformatics","Biology","Chemistry","Enzymes","Evolution","Genes", "Genome", "Protein")
colnames(TD) <- paste("D", 1:6, sep = "")
TD


# 上の各列は文書ベクトルを表す

# 特異値分解 # ターム・文書行列を，タームの自己相関行列，また文書の自己相関行列，そして次元の重要度を表す特異値の三つに分ける

TD.svd <- svd(TD, nu = 8)
   # 8は求める特異値の数。ただしこの場合最後の二つは0 
   is.list(TD.svd); length(TD.svd)

TD.svd$u
   # 左特異行列 単語 x 単語 word vectors 語の共起頻度を表現
# もとのベクトルの要素が 0 であった場合にも関連性を表す数値が求められている．

TD.svd$d
   # 特異値を確認 (次元の重要度を表現)

TD.svd$v
   # 右特異行列は文書 x 文書行列 document vectors テキスト間における共起語の出現頻度を表現
# もとのベクトルの要素が 0 であった場合にも関連性を表す数値が求められている．

( t(TD.svd$u[,1:3]) %*% TD)
   # もとの文書ベクトルを ３ 次元で表現






# はじめにターム・文書行列を作成する
DM <- docMatrix("yomi", pos = c("名詞","動詞","形容詞"),
                weight = "tf*idf*norm" )
                # この際重みを付ける

colnames(DM)

DM.svd <- svd(DM)
         # 特異値分解を行う
DM3 <- t(DM.svd$u[,1:3]) %*% DM
         # 文書行列 を 3 次元で近似
# 色分けの準備
colnames(DM3)

DM3.col <- substring(colnames(DM3), 1,3)
DM3.col  # 同じラベルには同じ色で表現する

# ラベルの準備
DM3.name <- unlist(strsplit(colnames(DM3), ".txt"))
DM3.name



##### 3次元グラフィックスの作成
## install.packages("rgl")
library(rgl)

rgl.open()
#
rgl.bg(color=c("white","black"))
rgl.lines(c(-1,1),0,0,color="gold")
rgl.lines(0, c(-1,1),0,color="gray")
rgl.lines(0,0,c(-1,1),color="black")

rgl.bbox(color="blue",  emission="green")

rgl.texts(DM3[1,], DM3[2,], DM3[3,],  DM3.name,
		    color = as.numeric(as.factor(DM3.col)), adj = 0.5)

## #
rgl.close()


gc();gc()





# [午後-4-4]

###########作家判別
######森鴎外と夏目漱石の分類主成分分析

setwd("C:/data")

# 文字のバイグラムを抽出する
res <- docNgram("writers", type = 0) # writers はフォルダ名
nrow(res) ## 書籍とはターム数が異なっている場合があります．
ncol(res) 
head(res)


# バイグラムの頻度で二人作家を分けることが可能である．
plot( hclust(dist( t(res)),"ward" ))
lines(c(1,8), c(500, 500), lty = 2, lwd = 2)


# 金明哲・村上征勝の研究に基づき，助詞と読点の組み合わせだけを取り出してみる．

res2 <- res[ rownames(res) %in% c("[と-、]", "[て-、]", "[は-、]", "[が-、]", "[で-、]",  "[に-、]",  "[ら-、]",  "[も-、]" ) ,  ]
res2


    
  ## 主成分分析
   head(iris)
   iris.pc <- princomp(iris[,-5])
   iris.name <- as.numeric(iris[,5])
   plot(iris.pc$scores[, 1:2], type = "n")
   text(iris.pc$scores[, 1:2], lab = iris.name,  col = as.numeric(iris.name))





## 鴎外・漱石データを主成分分析
res2.pc <- princomp(t(res2))
summary(res2.pc)

# ラベルの準備
res2.name <- unlist(strsplit(colnames(res2), ".txt"))

plot(res2.pc$scores[, 1:2], type = "n")
text(res2.pc$scores[, 1:2], lab = res2.name)

 



# plot(res2.pc,type ="l")
biplot(res2.pc, cex = 1.2)
lines(c(-200,220),  c(100,-170), lty =2, lwd = 2, col = "blue")

 ## 参考：biplot での座標の計算
 ### getS3method("biplot", "princomp")
 t(t(res2.pc$loadings[,1:2]) * (res2.pc$sdev[1:2] * sqrt(res2.pc$n.obs)) )
 t(t(res2.pc$scores[,1:2]) / (res2.pc$sdev[1:2] * sqrt(res2.pc$n.obs)) )

barplot(res2.pc$loadings[,1])

## 非計量多次元尺度法による分類
   library(MASS)

res2.dist <- dist(t(res2))
res2.samm <- sammon(res2.dist)
plot(res2.samm$points, type = "n", xlab = "多次元尺度法による分類", ylab = "鴎外と漱石")
text(res2.samm$points , lab = res2.name, col = c(rep(1,4), rep(2,4) ))






############################午後５########################

############################ 応用編２

#同志社大学教授金明哲『テキストデータの統計科学』岩波書店2009より

# [午後-5-1]

##########第６章ネットワーク分析
#####参考書R.グリッツマン、R.ブランデンブルグ『最短経路の本』シュプリンガー・ジャパン2007

# library(RMeCab)
setwd("C:/data")

file.show("Jin/Aso.txt")

A.df <- NgramDF("Jin/Aso.txt", type = 1,  pos ="名詞")
nrow(A.df)
head(A.df)

A.df <- A.df[A.df$Freq > 1, ]
nrow(A.df)
# install.packages("igraph")

library(igraph)

aso.g <- graph.data.frame(A.df)
E(aso.g)$weight <- A.df[,3]

tkplot(aso.g, vertex.label =V(aso.g)$name, edge.label =E(aso.g)$weight, vertex.size = 22)


############
file.show("Jin/Hatoyama.txt")

H.df <- NgramDF("Jin/Hatoyama.txt", type = 1,  pos ="名詞")
nrow(H.df)

H.df <- H.df[H.df$Freq > 2, ]
nrow(H.df)

hato.g <- graph.data.frame(H.df)
E(hato.g)$weight <- H.df[,3]

tkplot(hato.g, vertex.label =V(hato.g)$name, edge.label =E(hato.g)$weight , vertex.size = 23)



   ## 参考：　福田元首相
   file.show("Jin/Fukuda.txt")
   F.df <- NgramDF("Jin/Fukuda.txt", type = 1,  pos ="名詞")
   nrow(F.df)

   F.df <- F.df[F.df$Freq > 1, ]
   F.df

   fuku.g <- graph.data.frame(F.df)
   E(fuku.g)$weight <- F.df[,3]

   tkplot(fuku.g, vertex.label = V(fuku.g)$name, edge.label = E(fuku.g)$weight)

   ## 参考：　安部元首相
   file.show("Jin/Abe.txt")
   A.df <- NgramDF("Jin/Abe.txt", type = 1,  pos ="名詞")
   nrow(A.df)

   A.df <- A.df[A.df$Freq > 1, ]
   A.df
   abe.g <- graph.data.frame(A.df)
   E(abe.g)$weight <- A.df[,3]

   tkplot(abe.g, vertex.label =V(abe.g)$name, edge.label =E(abe.g)$weight)


# [午後-5-2]

### 複数のテキストと，そこに表れるタームの関連性を一枚のネットワーク図に描くことも可能である．
# install.packages("network")
library(network)


# doc1.txt 私は真面目な学生です。
# doc2.txt 彼女は数学科の良い学生です。
# doc3.txt 彼女は難しい数学を学んでいます。

test <- docMatrix2("doc", pos = "名詞")
test.net <- network(test)
plot(test.net, displaylabels = TRUE)



  test <- docMatrix2("Jin", pos = "名詞" , minFreq = 30)
  test <- (test>0) * 1
  test.net <- network(test,directed = F)
  plot(test.net, displaylabels = TRUE)




# [午後-5-3]

##### 落穂ひろい
##かかりうけ判定を行うCaBoChaと、その入出力をRで行うRCaBoCha

library(RCaBoCha)

RCaBoChaFreq("それは面白い本であった。しかし、この本に比べると面白くはない。")

dat <- read.csv("H18koe.csv")  ## 沖縄観光についての自由意見
res <- RCaBoChaDF(dat[,"opinion"])
nrow(res)
res[48:53, 1:10]



# [午後-5-4]

# 欧米語テキストのテキストマイニング
##  I.Feinerer. An introduction to text mining in R. R News, 8(2):19{22, Oct. 2008. URL http://CRAN.R-project.
org/doc/Rnews/.
##  I.Feinerer, K.~Hornik, and D.~Meyer. Text mining infrastructure in R. Journal of Statistical Software, 25(5):
1{54, March 2008. ISSN 1548-7660. URL http://www.jstatsoft.org/v25/i05.
  
# tm パッケージは複数の別パッケージを前提とする．
## 以下，必須パッケージ以外にテキストマイニングを利用する上では便利なパッケージを含めている

  
  install.packages("cba")
  install.packages("filehash")
  install.packages("XML")
  install.packages("rJava")
  install.packages("RWeka")
  install.packages("Snowball")
  install.packages("tm")
  install.packages("gsubfn")

##  install.packages("Rstem", repos = "http://www.omegahat.org/R",type = "source")


library(tm)

  # 簡単な文書定義
  docs <- c("This is a text.", "This another one.")
  show(docs)

  # 文書をセットとして扱う
  Corpus(VectorSource(docs))
  show(docs)


# tm パッケージに付属のロイター記事データ
reut21578 <- system.file("texts", "crude", package = "tm")
reuters <- Corpus(DirSource(reut21578), readerControl = list(reader = readReut21578XML))
show(reuters[[1]])  # XML タグ付きテキストデータ

reuters <- tm_map(reuters, as.PlainTextDocument) #平テキストに変換
show(reuters[[1]])

reuters <- tm_map(reuters, stripWhitespace) # 余分のスペースを削除
show(reuters[[1]])

reuters <- tm_map(reuters, tolower) # 大文字を小文字へ
#  "A dog" -- > "a dog"
show(reuters[[1]])

reuters <- tm_map(reuters, removeWords, stopwords("english")) # Stop words の削除
show(reuters[[1]])

# ftp://ftp.cs.cornell.edu/pub/smart/english.stop
file.show("english.stop.txt")

reuters <- tm_map(reuters, stemDocument) # ステミング
##同じ内容を表す語については語尾などの違いを取り去る

show(reuters[[1]])



## 検索１
query <- "id == '237' & heading == 'INDONESIA SEEN AT CROSSROADS OVER ECONOMIC CHANGE'"
tm_filter(reuters, FUN = sFilter, query)
tm_filter(reuters, FUN = sFilter, query)

## 検索２
tm_filter(reuters, pattern = "compan")# = companies -- > compan


# ターム・文書行列の作成

dtm <- DocumentTermMatrix(reuters) 
show(dtm)
inspect(dtm[1:5, 150:155])


findFreqTerms(dtm, 5) # 頻度が５以上のターム


findAssocs(dtm, "opec", 0.8) # opec との相関が0.8以上のターム

## sparse なタームをのぞく
inspect(removeSparseTerms(dtm, 0.4))

## 詳細は tm パッケージのヴィネットを参照されたい


 http://cran.r-project.org/web/views/NaturalLanguageProcessing.html 
CRAN Task View: Natural Language Processing
Maintainer:	Ingo Feinerer and Fridolin Wild
Contact:	Fridolin.Wild at wu-wien.ac.at
Version:	2009-02-05

This CRAN Task View contains a list of packages useful for natural language processing.
Phonetics and Speech Processing:

    * emu is a collection of tools for the creation, manipulation, and analysis of speech databases. At the core of EMU is a database search engine which allows the researcher to find various speech segments based on the sequential and hierarchical structure of the utterances in which they occur. EMU includes an interactive labeller which can display spectrograms and other speech waveforms, and which allows the creation of hierarchical, as well as sequential, labels for a speech utterance.

Lexical Databases:

    * wordnet provides an R interface to WordNet , a large lexical database of English.

Keyword Extraction and General String Manipulation:

    * Rs base package already provides a rich set of character manipulation routines. See help.search(keyword = "character", package = "base") for more information on these capabilities.
    * RKEA provides an R interface to KEA (Version 5.0). KEA (for Keyphrase Extraction Algorithm) allows for extracting keyphrases from text documents. It can be either used for free indexing or for indexing with a controlled vocabulary.
    * gsubfn can be used for certain parsing tasks such as extracting words from strings by content rather than by delimiters. demo("gsubfn-gries") shows an example of this in a natural language processing context.

Natural Language Processing:

    * openNLP provides an R interface to OpenNLP , a collection of natural language processing tools including a sentence detector, tokenizer, pos-tagger, shallow and full syntactic parser, and named-entity detector, using the Maxent Java package for training and using maximum entropy models.
    * openNLPmodels.en ships trained models for English and openNLPmodels.es for Spanish to be used with openNLP.
    * RWeka is a interface to Weka which is a collection of machine learning algorithms for data mining tasks written in Java. Especially useful in the context of natural language processing is its functionality for tokenization and stemming.
    * Snowball provides the Snowball stemmers which contain the Porter stemmer and several other stemmers for different languages. See the Snowball webpage for details.
    * Alternatively, the Omegahat package Rstem provides an R interface to a C version of Porters word stemming algorithm.

String Kernels:

    * kernlab allows to create and compute with string kernels, like full string, spectrum, or bounded range string kernels. It can directly use the document format used by tm as input.

Text Mining:

    * tm provides a comprehensive text mining framework for R. The Journal of Statistical Software article Text Mining Infrastructure in R gives a detailed overview and presents techniques for count-based analysis methods, text clustering, text classification and string kernels.
    * lsa provides routines for performing a latent semantic analysis with R. The basic idea of latent semantic analysis (LSA) is, that text do have a higher order (=latent semantic) structure which, however, is obscured by word usage (e.g. through the use of synonyms or polysemy). By using conceptual indices that are derived statistically via a truncated singular value decomposition (a two-mode factor analysis) over a given document-term matrix, this variability problem can be overcome. The article Investigating Unstructured Texts with Latent Semantic Analysis gives a detailed overview and demonstrates the use of the package with examples from the are of technology-enhanced learning.
    * corpora offers utility functions for the statistical analysis of corpus frequency data.
    * languageR provides data sets and functions exemplifying statistical methods, and some facilitatory utility functions used in the book by R. H. Baayen: "Analyzing Linguistic Data: a Practical Introduction to Statistics Using R", Cambridge University Press, 2008.
    * zipfR offers some statistical models for word frequency distributions. The utilities include functions for loading, manipulating and visualizing word frequency data and vocabulary growth curves. The package also implements several statistical models for the distribution of word frequencies in a population. (The name of this library derives from the most famous word frequency distribution, Zipfs law.)

CRAN packages:

    * corpora
    * emu
    * gsubfn
    * kernlab
    * languageR
    * lsa
    * openNLP
    * openNLPmodels.en
    * openNLPmodels.es
    * RKEA
    * RWeka
    * Snowball
    * tm (core)
    * wordnet
    * zipfR

Related links:

    * CRAN Task View: Cluster
    * CRAN Task View: MachineLearning
    * A Gentle Introduction to Statistics for (Computational) Linguists (SIGIL)
    * ttda: Tools for Textual Data Analysis (Deprecated)


