# 重回帰分析
# ケース：ジムの顧客数をあげるために必要な要素とはなにか？を調べる
# gym.csv：ジムのチェーン店の顧客アンケート調査の結果
# 店舗番号：各店舗のID
# 顧客数：各店舗の顧客数
# 立地満足度：立地に関する満足度
# 設備満足度：設備（ｒｙ
# 店舗面積満足度：店舗面積（ｒｙ
# トレーナー満足度：トレーナー（ｒｙ
# トレーナー数：各店舗のトレーナーの人数
# 接客研修：１あり，０なし
# 入会特典：１あり，０なし

# データの読み込み
csdat <- read.csv("gym.csv")

# 先頭数行を確認
head(csdat)

# Rによる重回帰分析ではlm関数を用いる
# ~(チルダ)の左に目的変数，右に説明変数を書く
res1 <- lm(csdat$顧客数 ~ csdat$立地満足度 + csdat$設備満足度 + csdat$店舗面積満足度 + csdat$トレーナー満足度)

# 出力の確認
summary(res1)

# 結果
# Call:
#   lm(formula = csdat$顧客数 ~ csdat$立地満足度 + csdat$設備満足度 + 
#        csdat$店舗面積満足度 + csdat$トレーナー満足度)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -63.636 -36.548  -0.314  21.419 101.890 
# 
# Coefficients: (係数)
# Estimateが偏回帰係数
#                            Estimate Std. Error t value Pr(>|t|)    
# (Intercept)             -35.204     50.659  -0.695  0.49351    
# csdat$立地満足度         29.105      5.684   5.120 2.73e-05 ***
#   csdat$設備満足度         21.640      7.036   3.076  0.00503 ** 
#   csdat$店舗面積満足度     23.803      6.971   3.414  0.00219 ** 
#   csdat$トレーナー満足度   32.421      5.608   5.781 5.01e-06 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 45.11 on 25 degrees of freedom

# 決定係数（目的変数の分散のうち説明変数の分散で説明できた割合）と自由度調節済み決定係数（説明変数の数を考慮して下方修正した決定係数）
# Multiple R-squared:  0.8248,	Adjusted R-squared:  0.7968 
# 決定係数の有意性：偏回帰係数がすべて０という帰無仮説のF検定
# F-statistic: 29.43 on 4 and 25 DF,  p-value: 3.957e-09

# 多重共線性のチェック
# トレーナー数もモデルに入れようと考えたときを想定
cor(csdat$トレーナー満足度,csdat$トレーナー数)
# 0.9843212 めっちゃ高い，これで重回帰すると
resm1 <- lm(顧客数 ~ トレーナー満足度, data=csdat)
resm2 <- lm(csdat$顧客数 ~ csdat$トレーナー満足度 + csdat$トレーナー数)
summary(resm1)
summary(resm2)
# (略)相関が高い変数同士をぶち込んだモデルの標準誤差は極端に低くなる

# 多重共線性をチェックするにはVIF（分散拡大要因）を算出する
library(car)
