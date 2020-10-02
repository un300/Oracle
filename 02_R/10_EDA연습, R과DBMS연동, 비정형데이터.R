
# packages

{
library(readxl)
library(dplyr)
library(plyr)
library(lubridate)
library(ggplot2)
library(stringr)
}

######################################수행평가래~

# 데이터 전처리 및 탐색적 분석

# 1. 데이터 로드 및 라이브러리 로드


raw_data <- read_excel(file.choose())
str(raw_data)
View(raw_data)
as_tibble(raw_data)

temp_data <- raw_data

temp_data$area <- as.factor(temp_data$area)
temp_data$yyyymmdd <- ymd(temp_data$yyyymmdd)

as_tibble(temp_data)



# 로드한 데이터로 부터 성북구와 중구의 미세먼지를 비교하고
# 시각화 해보려한다.

# 2. 비교할 지역 데이터만 추출하여 미세먼지 농도차이가 있는지
# 확인해보자


two_area <- temp_data %>% 
  filter(area == '성북구' | area == '중구')


as_tibble(two_area)

str(two_area$yyyymmdd)




ggplot(data = two_area,
       aes(x = yyyymmdd,
           y = finedust,
           col = area)) + 
  geom_line(linetype = 5, size = 0.8) + 
  geom_point(size = 1.5) +
  labs(title = '성북구와 중구의 미세먼지 변화') + 
  xlab(label = '시간') +
  ylab(label = '미세먼지농도')







# 3. 현황 파악하기
# yyyymmdd에 따른 데이터 수 파악(내림차순 정렬)
# count() 함수 이용
?count

two_area %>% 
  count(yyyymmdd) %>% 
  arrange(desc(n))

# area에 따른 데이터 수 파악(내림차순 정렬)

two_area %>% 
  count(area, sort = TRUE) %>% 
  arrange(desc(n))






# 4. 지역(area)에 따른 데이터를 변수에 각각 할당해보자!
as_tibble(two_area)

joong_data <- two_area[two_area$area == '중구', ] 
sung_data <- two_area[two_area$area == '성북구', ] 

as_tibble(joong_data)
as_tibble(sung_data)

summary(joong_data)
summary(sung_data)



# 5. boxplot을 이용하여 시각화 해보자
ggplot(data = two_area,
       aes(x = area,
           y = finedust,
           fill = area)) +
  geom_boxplot() + 
  labs(title = '성북구와 중구의 미세먼지 boxplot')

ggplot(data = two_area,
       aes(x = area,
           y = finedust,
           fill = area)) +
  geom_boxplot() + 
  labs(title = '성북구와 중구의 미세먼지 boxplot') + 
  coord_flip()


# 만약 가설에 대한 검정을 한다면..?

t.test(data = two_area,
       finedust ~ area,
       var.equal = T)   # t 검정 결과 p값이 0.05보다 현저이 작게나타남
                        # 그러므로 지역별 미세먼지 농도 차이가 없다는 귀무가설을 기각할 수 있다. 


#################################################################################



# R과 DBMS 연동을 통한 정형 데이터 처리 방법

install.packages("rJava") # R와 java를 연동하기위한 패키지 > 사용하기전에 
install.packages("DBI")   # 인터페이스
install.packages("RJDBC") # jdbd 함수 제공 > 여러가지 회사(벤더)의 기준이 적용된 DBMS를 R상에서 하나의 표준으로 만들어 주는 패키지


# 자바 플랫폼을 R과 연동! : 연동을 해야 위의 package들을 library로 불러올 수 있음 
Sys.setenv(JAVA_HOME = "C:\\Program Files\\Java\\jdk1.8.0_121")
library(rJava)
library(DBI)
library(RJDBC)


# DB 연동을 위한 순서는
# 1. Driver loading, 2. Connection(hr,hr), 3 .Query 수행, 4. 결과 집합 확인하는 과정으로 진행



# Driver loading
# 예를들어 ORACLE DBMS를 사용하기 위해서는 ORACLE DBMS 드라이버를 설치하여야 한다.
# 왜 ? DBMS를 만드는 회사는 여러가지기 때문에 R에서 회사에 상관없이 동일한 
#      구문을 적용하여 데이터베이스를 접근하기 위해서는
#      접근하고자 하는 DBMS의 DRIVER가 설치되어 있어야하기 때문!
# 이 컴퓨터의 경우 'C:\oraclexe\app\oracle\product\11.2.0\server\jdbc\lib' 경로에
# ORACLE 드라이버 있음 

driver <- JDBC(driverClass = 'oracle.jdbc.driver.OracleDriver',
               classPath = 'C:\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\jdbc\\lib\\ojdbc6.jar')

driver

conn <- dbConnect(driver, 'jdbc:oracle:thin:@localhost:1521:xe',
                  'hr',
                  'hr')

conn
# 어렵다..
# 오라클이 아닌 또 다른 DBMS를 쓰고 싶을때!!
# 인터넷에 검색하면 어떤 경로를 지정해야 하는지 다 나옴
# 위의 틀에서 경로와 옵션만 인터넷에서 찾아 입력하면된다.



selectEmpQuery <- 'select * from employee'

# dbGetQuery() : 테이블을 가져오세요
empTable <- dbGetQuery(conn, selectEmpQuery)

str(empTable)
dim(empTable)




# table 생성
createTempTable <- 'create table r_tbl(
                    id varchar2(20) primary key,
                    pwd varchar2(20),
                    username varchar2(50),
                    upoint number default 1000)';


# dbSendUpdate() : DML(insert, update, delete), DDL(create, drop, alter)
# > 테이블을 업데이트 하세요
dbSendUpdate(conn, createTempTable)



# insert(dumy data)
insertTemptable <- "INSERT INTO r_tbl
                    VALUES('1', 'jaewon', 'LeeJaeWon', 2000)"
dbSendUpdate(conn, insertTemptable)



selectTable <- "SELECT  *
                FROM    r_tbl"
view <- dbGetQuery(conn, selectTable)
view




# update LeeJaeWon로 입력된 USERNAME을 관리자로 변경하세요
updateTable <- "UPDATE    r_tbl
                SET       USERNAME = '관리자'
                WHERE     USERNAME = 'LeeJaeWon'"   


dbSendUpdate(conn, updateTable)

view <- dbGetQuery(conn, selectTable)
view

# delete > 하나있는 행일 지워보세요

deleteTable <- "DELETE FROM r_tbl
                WHERE       ID = '1'"

dbSendUpdate(conn, deleteTable)
view <- dbGetQuery(conn, selectTable)
view


# drop > 테이블을 날리세요

dropTable <- "drop table r_tbl"
dbSendUpdate(conn, dropTable)
view <- dbGetQuery(conn, selectTable)
view










###오라클에서 사용했던 employee table을 이용하여 R에서 시각화를 해보라.
## 성별에 따른 임금차이가 있는가? 시각화해 보아라

empTable <- dbGetQuery(conn, selectEmpQuery)

empTable
str(empTable)
as_tibble(empTable)


substr(empTable$EMP_NO, 8, 8)

as_tibble(empTable)
empTable$gender <- ''
empTable[substr(empTable$EMP_NO, 8, 8) == 1,]$gender <- '남'
empTable[substr(empTable$EMP_NO, 8, 8) == 2,]$gender <- '여'

str(empTable)

empTable$JOB_ID <- as.factor(empTable$JOB_ID)
empTable$MARRIAGE <- as.factor(empTable$MARRIAGE)
empTable$gender <- as.factor(empTable$gender)

str(empTable)


mean_data <- empTable %>% 
  group_by(gender) %>% 
  summarise(mean_SALARY = mean(SALARY, na.rm = T))




as_tibble(mean_data)

# 성별에 따른 평균임금 BOXPLOT
ggplot(data = empTable,
       aes(x = gender,
           y = SALARY,
           fill = gender)) +
  geom_boxplot()


# 성별에 따른 평균임금 BARPLOT

ggplot(data = mean_data,
       aes(x = gender,
           y = mean_SALARY,
           fill = gender)) + 
  geom_bar(stat = 'identity',
           col = 'black',
           width = 0.3)



# 성별에 따른 평균임금은 차이가 있느냐? (t.test)
t.test(data = empTable,
       SALARY ~ gender,
       var.equal = T)





# 직급과 성별에 따른 평균임금
JOB_ID.mean <- empTable %>% 
  group_by(JOB_ID, gender) %>% 
  summarise(meanSALARY = mean(SALARY, na.rm = T))


ggplot(data = JOB_ID.mean,
       aes(x = gender,
           y = meanSALARY,
           fill = JOB_ID)) +
    geom_bar(stat = 'identity', 
             position = 'dodge', 
             col = 'black')








#### DB 종료
dbDisconnect(conn)














###############################################################################
######################  비정형 데이터 처리 ####################################
###################### 텍스트 마이닝 ##########################################
###############################################################################

# 단어의 빈도 시각화(wordcloud, koNLP, tm)


install.packages(c("hash", "tau", "Sejong", 
                   "RSQLite", "devtools", "bit", 
                   "rex", "lazyeval", "htmlwidgets", 
                   "crosstalk", "promises", "later", 
                   "sessioninfo", "xopen", "bit64", 
                   "blob", "DBI", "memoise", "plogr", 
                   "covr", "DT", "rcmdcheck", "rversions"), 
                 type = "binary")  



## R cran에서 제공해주는 package가 아니라 일반 민간인들이 만든 package를 설치하기위한 방법
# github 버전 설치
install.packages("remotes")
# 64bit 에서만 동작합니다.
remotes::install_github('haven-jeon/KoNLP', 
                        upgrade = "never", 
                        INSTALL_opts=c("--no-multiarch"))







# 감성분석
# service_data_facebook_bigdata.txt


# 1. 비정형 데이터 불러오기

# 비정형 데이터(문자) 불러오는 방법!
# 데이터이름 <- file(file.choose())
fbook <- file(file.choose(), encoding = 'UTF-8')

# 비정형 데이터 읽는 방법
# 데이터이름 <- readLines(불러온데이터)
fbook_read <- readLines(fbook)
head(fbook_read)
str(fbook_read)




# 2. 비정형 데이터 전처리
#                           >  정규표현식을 필요로 한다.
# 문장부호 제거하는 정규표현식을 활용한다면????     >>  문장부호를 지칭하는 정규표션식은? [[:punct:]]
# 특수문자 제거                                     >>  특수문자를 지칭하는 정규표현식은? [[:cntrl:]]
# 숫자 제거                                         >>  숫자를 지칭하는 정규표현식은? [0-9], \\d+,
#                                                   >>  그외를 지칭하는 정규표헌식!! \\w, \\s, \\n, \\t


# gsub() 함수를 이용해서 전처리 ㄱㄱ


# 문장부호 제거
s1 <- gsub('[[:punct:]]', '', fbook_read)
fbook_read[1]
s1[1]

# 숫자 제거
s2 <- gsub('\\d', '', s1)
s1[1]
s2[1]

# 특수문자 제거
s3 <- gsub('[[:cntrl:]]', '', s2)
s2[1]
s3[1]

# 대문자 영어를 소문자로
s4 <- tolower(s3)
s3[1]
s4[1]



# 공백을 기준으로 단어를 구분하자
word <- str_split(s4, '\\s+')
word  # list가 반환되기에.. 데이터를 다루기 쉽도록 unlist()함수를 이용해 벡터로 만들어보자

# 벡터 만들기
wordVec <- unlist(word)
wordVec



# 제공되는 단어사전으로부터 파일을 읽어와 보자

# service_data_pos_pol_word.txt
positiveDic <- file(file.choose(), encoding = 'UTF-8')
pDic <- readLines(positiveDic)

# service_data_neg_word.txt
negativeDic <- file(file.choose(), encoding = 'UTF-8')
nDic <- readLines(negativeDic)

head(pDic)
head(nDic)

pDic<- c(pDic, '긍정의 씨앗')
nDic<- c(nDic, '부정의 씨앗')
str(pDic)
str(nDic)


# 분석을 위한 함수 정의
# 분석딘 단어(wordVec) vs 사전 단어(pDic / nDic)에 매치가 되는지를 검사
# match() 

pMatch <- match(wordVec, pDic)
nMatch <- match(wordVec, nDic)




# NA : 부정 사전 단어, 긍정 사전 단어에 매치되는 것이 없다!
# 숫자: 매치되는 것이 있다

# 사전에 등록된 단어 추출을 한다면?
pMatch_bool <- !is.na(pMatch)
nMatch_bool <- !is.na(nMatch)

pDic[pMatch]
nDic[nMatch]

View(nDic)

# 밑의 코드 실행 결과 긍정의 단어가 부정의 단어보다 31개 정도 많다
scores <- sum(pMatch_bool) - sum(nMatch_bool)
scores

scoreDF <- data.frame(score = scores, text = wordVec)
scoreDF






# 이 함수를 정의하세요

# 이 함수를 정의하세요
resultS <- function(words , positive , negative) {
  scores = laply(words, function(words, positive, negative) {
    pMatch = match(words, positive) 
    nMatch = match(words, negative)
    
    pMatch = !is.na(pMatch) 
    nMatch = !is.na(nMatch)
    
    score = sum(pMatch) - sum(nMatch) 
    return(score)
  }, positive, negative)
  
  scores.df = data.frame(score=scores , text=words)
  return(scores.df)
}


resultTbl <- resultS(wordVec, pDic, nDic)



str(resultTbl)
table(resultTbl$text)

resultTbl$remark <- ''
resultTbl$remark[resultTbl$score >= 1] <- '긍정'
resultTbl$remark[resultTbl$score == 0] <- '중립'
resultTbl$remark[resultTbl$score < 0] <- '부정'

as_tibble(resultTbl)





pieResult <- table(resultTbl$remark)
pie(pieResult, 
    labels = names(pieResult),
    col = c('yellow', 'red', 'blue'),
    radius = 0.8)




# 이 함수를 내 임의대로 짜보라

resultS <- function(words , positive , negative) {
  scores = laply(words, function(words, positive, negative) {
    pMatch = match(words, positive) 
    nMatch = match(words, negative)
    
    pMatch = !is.na(pMatch) 
    nMatch = !is.na(nMatch)
    
    score = sum(pMatch) - sum(nMatch) 
    return(score)
  }, positive, negative)
  
  scores.df = data.frame(score=scores , text=words)
  return(scores.df)
}

# 위의 함수를 내 임의대로 짜보라!! > 틀린거 같당

My_function <- function(words, positive, negative){
  data <- data.frame(words = words)
  data$index <- 0
  data[words %in% positive,]$index <- 1
  data[words %in% negative,]$index <- -1
  return(data)
}


## 비교해보자

rkdtkslaRj <- resultS(wordVec, pDic, nDic)
soRj <- My_function(wordVec, pDic, nDic)

rkdtkslaRj$score == soRj$index




a <- c(1, 2, 3)

b <- c(1,2)


b %in% a
a %in% b
