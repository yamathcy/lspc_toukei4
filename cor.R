# 相関分析
# 陰キャ度に関するデータの相関をいろいろ出してみよう
# 陰キャ度：連続量，陰キャらしさ
# ツイート数：連続量，一日のツイート数の平均
# 学年：順序尺度，何年生か
# トーク好き度：順序尺度，1~5でおしゃべりが好きかを回答(大きいほど好き)

inkya <- read.csv("inkya.csv")

head(inkya)

# 連続量×連続量
# 陰キャ度とツイート数の相関をピアソンの積率相関係数で求める
inkya.tweet <- cor(inkya$陰キャ度, inkya$ツイート数, method="pearson")
inkya.tweet

# 無相関か検定
cor.test(inkya$陰キャ度, inkya$ツイート数, methods="pearson")

# 順序尺度を含む相関
# スピアマンの順位相関
inkya.gakunen <- cor(inkya$陰キャ度,inkya$学年, method="spearman")
inkya.gakunen
# 無相関か検定
cor.test(inkya$陰キャ度, inkya$ツイート数, methods="spearman")

# ケンドールの順位相関
inkya.gakunen <- cor(inkya$陰キャ度,inkya$学年, method="kendall")
inkya.gakunen
# 無相関か検定
cor.test(inkya$陰キャ度, inkya$ツイート数, methods="kendall")
