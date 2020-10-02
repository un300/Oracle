


Sys.setenv(JAVA_HOME = "C:\\Program Files\\Java\\jdk1.8.0_121")
library(rJava)
library(KoNLP)  #################### 주의점!! : KoNLP는 install.packages로 설치하면 안댐!!
library(tm) # > 텍스트 전처리 용도
library(wordcloud)
library(RColorBrewer) # > 색깔을 이쁘게 꾸며주는 라이브러리임


## service_data_text_mining_movie.csv

movie <- read.csv(file.choose())
str(movie)


as_tibble(movie)







movieCorp <- VCorpus(VectorSource(tolower(movie$Description)))
str(movieCorp)


movieCorp <- tm_map(movieCorp, stripWhitespace)
movieCorp <- tm_map(movieCorp, removeNumbers)
movieCorp <- tm_map(movieCorp, removePunctuation)
movieCorp <- tm_map(movieCorp, removeWords, stopwords('en'))

str(movieCorp)



movieTDM <- TermDocumentMatrix(movieCorp)

matrix_movie <- as.matrix(movieTDM)

View(matrix_movie)


words_data <- rowSums(matrix_movie)
class(words_data)

dfMovie <- data.frame(name = names(words_data), word = words_data)
rownames(dfMovie) <- c()
dfMovie <- dfMovie %>% arrange(desc(word))

str(dfMovie)

# 워드클라우드, 단어 빈도 그래프(barplot)



# 단어 빈도가 5이상인 단어들을 이용하여 워드클라우드를 그리시오

pal <- brewer.pal(6, "Accent")
wordcloud(words = names(words_data), 
          freq = words_data,
          min.freq = 5,
          random.order = F,
          col = pal)


library(wordcloud2)
?wordcloud2

wordcloud2(dfMovie,
           size = 0.5,
           minSize = 0.1)



# 빈도 top 15인 단어들을 활용하여 barplot을 그려라


library(dplyr)
library(ggplot2)

str(dfMovie)


Top15df <- dfMovie[1:15, ]

str(Top15df)
Top15df

ggplot(data = Top15df,
       aes(x = name,
           y = word,
           fill = name)) +
  geom_bar(stat = 'identity', col ='black') +
  labs(title ='Very Frequency Word' ,face = 'bold')




























