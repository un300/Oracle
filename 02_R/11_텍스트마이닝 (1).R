########### 워드클라우드를 통한 단어빈도
install.packages("wordcloud")
install.packages("tm")

Sys.setenv(JAVA_HOME = "C:\\Program Files\\Java\\jdk1.8.0_121")
library(rJava)
library(KoNLP)  #################### 주의점!! : KoNLP는 install.packages로 설치하면 안댐!!
library(tm) # > 텍스트 전처리 용도
library(wordcloud)
library(RColorBrewer) # > 색깔을 이쁘게 꾸며주는 라이브러리임



## 분석하고자 하는 텍스트를 분석하기 위해서는
## 분석하고자 하는 테스트의 언어 사전(형태소분석)을 설치해야한다.

## 명사, 형용사등을 추출한 사전
useSejongDic()  # 카이스트에서 만든 사전이레



text <- "최근 이슈가 되고 있는 빅데이터에 대한 이해와 활용을 위해 데이터 과학(Data Science)의 측면에서 접근한다.
빅데이터는 통계학을 비롯한 경영, IT 등의 다양한 분야들이 서로 결합되어 있고 그 정의가 다양하지만, 본 강의는 데이터 분석을
기반으로 하는 과학적 의사결정의 관점에서 바라보고자 한다. 빅데이터에 대한 이해를 위해 실제 사례들을 살펴보고,
데이터를 통해 의사결정에 유용한 정보 및 지식을 찾는 과정을 이해한다. 나아가 빅데이터 분석에서 필수적으로 언급되고 있는
R 통계프로그램을 소개하고 이를 분석에 활용할 수 있게 한다."

text

# 형태소 분석을 도와주는 함수 : extractNoun
#         > 자동으로 의미없는 조사나 문장부호를 걸러내고 의미를 가진 단어만을 추출해준다.
nouns <- extractNoun(text)
nouns


# nchar() : 문자의 길이
# nchar() 함수를 사용하여 문자길이가 2이상인 단어만 추출하자.
nouns <- nouns[nchar(nouns) >= 2]



# 추출해낸 단어를 활용하여 빈도표를 만들어보자
wFreq <- table(nouns)
wFreq  ## > exteactNoun을 통해 형태소를 제거했지만..
       ## 빅데이터는, 빅데이터에 처럼 완벽히 제거되지 않았슴
       ## 그렇기에 남아있는 조사를 처리해보자


nouns <- gsub("빅데이터.+", "빅데이터", nouns)
nouns
wFreq <- table(nouns)
wFreq    # '빅데이터는', '빅데이터에' 가 '빅데이터'로 통합됨을 볼 수 있다.
names(wFreq)




# wordcloud()를 통해 위에서 만든 wFreq를 시각화 해보자
?wordcloud


pal <- brewer.pal(6, "Accent")  # > 워드클라우드 색을 지정하기 위한 함수!

wordcloud(words = names(wFreq),
          freq = wFreq,
          min.freq = 1,
          random.order = F,
          colors = pal)

























################################################################################
#######################    텍스트 마이닝    ####################################
################################################################################


# 텍스트 마이닝 단계
# 1. 문장 읽어들이기
# 2. 말뭉치 만들기
# 3. 의미없는 단어 (불용어, 공백, 특수문자) 제거




# text -> corpus(말뭉치) -> TDM(TermDocumentMatrix) -> TM분석 -> matrix() or data.frame() -> wordcloud
# sercice_data_I_love_mom.txt


#################################### 1. 문장 읽어 들이기
data <- readLines(file.choose(), encoding = 'UTF-8')
data
str(data)








#################################### 2. 말뭉치 만들기
corpus <- VCorpus(VectorSource(data)) # > 데이터를 말뭉치(corpus)로 만들어 놓아야 한다.
str(corpus)
corpus

?VCorpus
?VectorSource


#################################### 3. 의미없는 단어 제거


# tm_map(코퍼스(말뭉치), function) : 공백, 특수문자를 function(텍스트 전용 함수)를 적용하여 제거해주는 작업입니다


# function : stripWhitespace > 공백을 제거합니다
corpus_map <- tm_map(corpus, stripWhitespace)
corpus_map
corpus_map[[1]]$content  # 공백이  사라졌어요!

# function : removeNumbers > 숫자를 제거합니다.

corpus_map <- tm_map(corpus_map, removeNumbers)

# function : removePunctuation > 특수문자를 제거합니다.
corpus_map <- tm_map(corpus_map, removePunctuation)
corpus_map[[9]]$content


###############################TermDocumentMatrix()를 사용해서 위 작업을 한번에 적용하는 방법!

corpus_tm2 <- TermDocumentMatrix(corpus,
                                 control = list(stripWhitespace = T,
                                                removeNumbers = T,
                                                removePunctuation = T))

# stopword(불용어) 처리 방법
# 불용어란? : I, My, Me 처럼 자주 등장하지만, 실제 의미 분석에는 큰 의미가 없는 단어들을 지칭하는 용어
# 그러므로 불용어를 제거해주어야 한다.
stopwords('en')      # 영어에서 자주 사용되는 불용어 목록
stopword2 <- stopwords('en')
stopword2 <- c(stopwords('en'), 'and', 'not', 'but')   # 이런식으로 사용하고자 하는 단어를 임의로 추가하여 가져올 수 있음
stopword2


?stopwords

?stopword2
# 불용어 제거
corpus_map <- tm_map(corpus, removeWords, stopword2)
str(corpus_map)
corpus_map[[1]]$content







############################# TermDocumentMatrix / DocumentTermMatrix




TDM <- TermDocumentMatrix(corpus_map)   # > TDM : 행이 단어 / 열이 문장!
as.matrix(TDM)

DTM <- DocumentTermMatrix(corpus_map)   # > DTM : 행이 문장 / 열아 단어!
as.matrix(DTM)








# 빈도 체크
# TermDocumentMatrix
# > 해당문서에서 단어발생 유무를 0, 1로 코딩한 매트릭스
# TDM <- TermDocumentMatrix(코퍼스!)


TDM2 <- TermDocumentMatrix(corpus_map)
TDM2
corpus_freq <- as.matrix(TDM2)
corpus_freq







# 만들어진 TDM에서 원하는 빈도수의 단어를 출력하는 방법
?findFreqTerms
# findFreqTerms(코퍼스, 최소빈도수, 최대빈도수)

findFreqTerms(TDM, 2, 4)








# 빈도표
# 만들어진 TermDocumentMatrix를 이용하여 빈도표를 만들어 보자
matrix <- as.matrix(TDM)


rownames(matrix)
rowSums(matrix)



wFreq <- sort(rowSums(matrix), decreasing = T)
wFreq


################ 만들어진 빈도표를 이용하여 워드클라우드를 그리자

pal <- brewer.pal(6, "Accent")  # > 워드클라우드 색을 지정하기 위한 함수!

wordcloud(words = names(wFreq),
          freq = wFreq,
          min.freq = 1,
          random.order = F,
          colors = pal)







### 어떻게 하시는지 아셧죠?
##############################################################################
### 실습해보세요!
# service_data_president_text_mining.txt

# 한국어 사전 가져오기
useSejongDic()


# 1. 파일 불러오기
president <- readLines(file.choose())
president
str(president)


# 2. 말뭉치 만들기

corpus <- VCorpus(VectorSource(president))
str(corpus)



?VCorpus

# 3. 의미없는 단어 제거
corpus_map <- tm_map(corpus, removePunctuation)
corpus_map <- tm_map(corpus_map, removeNumbers)
corpus_map <- tm_map(corpus_map, stripWhitespace)
str(corpus_map)

corpus_map

temp_TDM <- TermDocumentMatrix(corpus_map)
rowSums(as.matrix(temp_TDM))

stopword1 <- c('가겠습니다', '은', '을', '으로', '의', '이가', '이', '가', '입니다', '냐고', '지만', '만',
                         '와', '라', '는','합니다', '겠습니다', '들께', '스러웠지만', '하겠습니다', '할', '에는',
                         '했던', '되면', '없는', '서','에서', '에서는','들','들이', '했다고')

corpus_map <- tm_map(corpus_map, removeWords, stopword1)

TDM2 <- TermDocumentMatrix(corpus_map)
rowSums(as.matrix(TDM2))

# 4. 말 뭉치에서 명사를 추출하기
nounsWord <- function(doc){
  d <- as.character(doc)
  extractNoun(d)
}


TDM <- TermDocumentMatrix(corpus_map,
                          control = list(tokenize = nounsWord))

row.names(TDM)
rowSums(as.matrix(TDM))

stopword <- c('전합니', 청)


# TDM 만들기
TDM <- TermDocumentMatrix(corpus_map)
as.matrix(TDM)
For_viewer <- data.frame(as.matrix(TDM))
View(For_viewer)


rowSums(as.matrix(TDM))

table(nouns)

nouns <- extractNoun(rowSums(as.matrix(TDM)))



pal <- brewer.pal(8, "Accent")
wordcloud(words = names(table(nouns)),
          freq = table(nouns),
          min.freq = 1,
          random.order = F,
          colors = pal)



