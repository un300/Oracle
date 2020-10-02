
### 파생변수 : 기존변수를 이용하여 새로운 변수를 추가하는 방법

stock <- read.csv(file.choose())
str(stock)
View(stock)

head(stock)
tail(stock)



stock$diff <- stock$High - stock$Low
str(stock)

mean(stock$diff)


## diff변수를 이용해서 diff_result라고 하는 파생변수를 생성..
## stock$diff의 값이 stock$diff의 평균보다 크면 diff_resul에"mean over"
## 작으면 "mean under"을 넣어라


stock$diff_result <- c(0)
stock[ (stock$diff >= mean(stock$diff)),  ]$diff_result <- "mean over"
stock[ (stock$diff < mean(stock$diff)),  ]$diff_result <- "mean under"
stock$diff_result <- as.factor(stock$diff_result)

str(stock)
View(stock)





## 루프 : while

i = 1

while(i <= 10) {
  print(i)
  i <- i + 1
}




## 1 ~ 100 사이에 5의 배수만 출력하고 싶다면?

x <- 5
while(x <= 100) {
  print(x)
  x <- x + 5
}



## next(다른 언어에서는 continue 같은거!) : 밑의 코드를 실행하지 않고, 루프의 위로 올라가라!

i <- 0
while(i <= 10){
  if(i %% 2 != 0){
    i <- i + 1
    next
  }
  print(i)
  i <- i + 1
}



## break : 루프를 끝내고 빠져나와라!


i <- 0
while(i <= 10){
  print(i)
  i <- i + 1
  if(i == 5){
    break
  }
}




## NA 확인


is.na( c(1, 2, 3, 4, NA) )

naDF <- data.frame(x = c(NA, 2, 3),
                   y = c(NA, 4, 5))


naDF

sum(is.na(naDF))


## NA 처리

NA & T


## 문제를 해결하기 위해서 (결측치를 제외하고 합계나 평균을 볼떼..)
sum( c(1, 2, 3, NA) , na.rm = T)
mean( c(1, 2, 3, NA) , na.rm = T)



### 결측치를 다루는 또다른 방법
### package : caret
### na.omit(), na.pass(), na.fail

na.omit(c(1, 2, 3, NA))
na.pass(c(1, 2, 3, NA))
na.fail(c(1, 2, 3, NA))








# 임의적으로 결측값을 넣어보자
# 데이터 프레임 결측치 시각화하기
irisDF <- iris
irisDF

irisDF[4:10, 3] <- NA
irisDF[1:5, 4] <- NA
irisDF[60:70, 5] <- NA
irisDF[97:103, 5] <- NA
irisDF[133:138, 5] <- NA
irisDF[140, 5] <- NA

irisDF
?heatmap
heatmap(1 * is.na(irisDF),
        Rowv = NA, 
        Colv = NA,
        scale = "none",
        cexCol = 0.8)






## 함수정의
## 다른 언어에선 return 을 적어주어야 하지만
## R의 경우는 retuen을 적지 않으면 가장 밑에 있는 값이 자동으로 return된다.


newSumFunc <- function(x, y) {
  result <- x + y
  return (result)
}


resultSum <- newSumFunc(5, 4)
resultSum



## 가변함수 : 함수를 호출할때 매번 받는 매개변수의 수가 다른 함수
varFunc <- function(...) {
  args <- list(...)       ## <- 가변함수는 어떤 타입의 데이터가 들어오는지 알수 없기에, 모든 형태를 담을 수 있는 list를 사용
  result <- 0
  for(idx in args) {
    result <- result + idx
  }
  return (result)
}



varFunc(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
varFunc(1, 2, 3)
varFunc(10, 10, 10, 10)




## 결측치 비율을 계산하는 함수를 만들어보자.
## 행의 합 및 열의 합별로 비율 계산하기


naMissFunc <- function(x) {
  sum(is.na(x)) / length(x) * 100
}

naMissFunc(irisDF)

rowMissingPer <- apply(irisDF, 1, naMissFunc)
colMissingPer <- apply(irisDF, 2, naMissFunc)

barplot(colMissingPer)


## 조작함수

iris
mtcars



## merge() : 오라클에서 join과 비슷함
## rbind(), cbind() 와는 다름
## 어떤점이??
## rbind(), cbind()는 조건없이 두 데이터를 합침
## BUT, merge()는 두 데이터의 동일한 열을 중복하지 않고 
## 두 데이터를 합침 (sql에서 외래키 참조하는 것과 같음)

x <- data.frame(name = c("임정섭", "임은결", "임재원"),
                math = c(100, 60, 95))

y <- data.frame(name = c("임재원", "임은결", "임정섭"),
                english = c(100, 70, 90))



cbind(x, y)  ## name 칼럼이 중복된다.
merge(x, y)  ## name 칼럼이 중복되지 않는다.










## package : doBy
## summaryBy(), orderBy(), splitBy(), sampleBy()

install.packages("doBy")
library(doBy)

## summaryBy()
## 원하는 칼럼의 값을 특정 조건에 따라 요약하는 목적
?summaryBy

summaryBy(Sepal.Length + Sepal.Width ~ Species, iris)
summaryBy(. ~ Species, iris)

## orderBy()
## 정렬을 위한 목적

?orderBy
orderBy( ~ Species, iris)
orderBy( ~ Species + Sepal.Width, iris)


## sampleBy()

?sampleBy
examSampleBy <- sampleBy(~ Speices, frac = 0.1, data = iris)   ### "frac = " 가져올 데이터의 비율
examSampleBy

train <- sampleBy(~ Speices, frac = 0.8, data = iris)
test <- sampleBy(~ Speices, frac = 0.2, data = iris)

train
test



## splitBy()
## split()과 비교
## split()  >  리스트를 리턴함
## splitBy()   >   
?split
split(iris, iris$Species)   # -> 리스트가 반환



## 문) iris종별 Sepal.Length 평균을 구해라
?sapply
mean_Sepal.Length <- sapply(split(iris$Sepal.Length, iris$Species), mean)



library(dplyr)
mean_Sepal.Length_dplyr <- iris %>% 
  group_by(Species) %>% 
  summarise(mean_Sepal.Length = mean(Sepal.Length))


mean_Sepal.Length_2
mean_Sepal.Length_dplyr


## 문) 위 결과를 데이터 프레임으로 만들어라
as.data.frame(mean_Sepal.Length)
as.data.frame(mean_Sepal.Length_dplyr)






###############################################
###리스트를 데이터프레임으로 만드는 [(정석)] 방법
# 1. lapply등을 이용해 리스트를 만든다
# 2. 만들어진 리스트를 unlist()함수를 이용하여 벡터로 만든다.
# 3. 만들어진 벡터를 matrix()함수를 이용하여 행렬로 만든다.
# 4. 만들어진 행렬을 as.data.frame()함수를 이용해 데이터 프레임화 한다.








## package : base
## 
install.packages("base")
library(base)


## base package의 order() : 주어진 값을 정렬하고, 정렬한 값이 아니라 정렬한 값의 색인을 출력해준다

sorted_by_SW <- base::order(iris$Sepal.Width)
iris[sorted_by_SW, ]




## sample() : 모집단으로 부터 표본을 추추하는 함수
# 복원추출
sample(1:10, 5)

# 비복원추출
sample(1:10, 5, replace=T)


## iris에 sample 적용 : iris 데이터를 렌덤하게 모두 뽑아라
iris[sample(1:nrow(iris), nrow(iris)), ]










## 자료의 분포 quantile()
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, seq(0, 1, by=0.1))













## 조작
## package :: plyr
## filter() : 원하는 조건의 행을 가져오는 함수. SQL에서 WHERE조건절과 비슷!
## select() : 원하는 조건의 열을 가져오는 함수.
## mutate() : 열추가
## arrange() : 정렬
## summarise() : 집계
## %>%


install.packages(c("plyr", "hflights"))
install.packages("dplyr")
library(plyr)
library(hflights)
library(dplyr)

str(hflights)
View(hflights)


## dplyr :: tbl_df() 혹은, as_tibble() : 데이터의 구조를 한눈에 파악하게 해줌
tbl_df(hflights)




##### filter() : 조건에따라 행을 추출
# 1월 1일 데이터 추출
hflights %>% 
  filter(Month==1, DayofMonth==1)


# 1월 혹은 2월 데이터 추출
data <- hflights %>% 
  filter(Month==1 | Month==2)



##### arrange() : 기본 오름차순 정렬
# 데이터를 ArrDelay, Month, Year 순으로 정렬

as_tibble(hflights)

hflights %>% 
  arrange(ArrDelay, Month, Year)

hflights %>% 
  arrange(desc(Month))  ## -> desc() : 내림차순 정렬



##### select(), mutate() : 열 추출
# select()

## Year부터 DayofWeek를 제외하고 열을 추출하라
as_tibble(hflights)

hflights %>% 
  select(DepTime:Diverted)

hflights %>% 
  select(4:ncol(hflights))

hflights %>% 
  select(-c(1:3))



# mutate()

# ArrDeley - DepDelay의 값을 파생변수인 gain에 넣고싶다.
# 또한, gain/(AirTime/60) 값을 파생변수인 gain_per_hour에 넣고싶다.
# 위에서 만든 두가지 변수를 flightDF 데이터 프레임에 넣어라

as_tibble(hflights)

flightDF <- hflights %>% 
  mutate(gain = ArrDelay - DepDelay,
         gain_per_hour = gain/(AirTime/60)
  )

flightDF




#### mutate()와 비슷한 함수!
## transform() : mutate()와 동일하지만.. 2개이상의 파생변수를 한번에 집어넣을 수 없음
data <- hflights
flight_transform <- transform(hflights, gain = ArrDelay - DepDelay)




## summarise() : 기초통계량을 구할 수 있음 (date.frame형태로 반환한다.)
##                기초통계 : min, sd, var, median, mean 구할 수 있다.


## 출발지연시간 평균 및 합계계산을 한다면?

as_tibble(hflights)


sum(is.na(hflights$ArrDelay))

hflights %>% 
  summarise(mean_ArrDelay = mean(ArrDelay, na.rm=T), 
            sum_ArrDelay = sum(ArrDelay, na.rm=T))












## 체인함수 %>% 

## 평균 출발지연 시간이 30분 이상인 데이터 출력
chain01 <- group_by(hflights, Year, Month, DayofMonth)
chain02 <- select(chain01, Year:DayofMonth, ArrDelay, DepDelay)
chain03 <- summarise(chain02,
                     arrival = mean(ArrDelay, na.rm = T),
                     depart = mean(DepDelay, na.rm = T))
result1 <- filter(chain03, arrival >= 30 | depart >= 30)
result1


### 위 과정을 %>% 을 사용하여 보아라

result2<- hflights %>% 
  group_by(Year, Month, DayofMonth) %>% 
  select(Year:DayofMonth, ArrDelay, DepDelay) %>% 
  summarise(arrival = mean(ArrDelay, na.rm = T),
            depart = mean(DepDelay, na.rm = T)) %>% 
  filter(arrival >= 30 | depart >= 30)



####################비교하기!
result1
result2













# hflights 데이터 셋에서 비행편 수 20편 이상
# 평균 비행거리 2,000마일 이상인
# 항공기별 평균 연착시간을 계산한다면?
# TailNum : 항공기 일련번호
#




as_tibble(hflights)


delay <- hflights %>% 
  group_by(TailNum) %>% 
  summarise(n = n(), 
            mean_Distance = mean(Distance),
            mean_ArrDelay = mean(ArrDelay, na.rm=T)) %>% 
  filter((n >= 20) & (mean_Distance >= 2000))


View(data)









## adply() > array를 받아서 data.frame 리턴
##          하지만 꼭 array를 넣지 않아도 된다

#### 다음과 같은 함수들을 한번에 적용해주는 함수!
## split
## apply
## combine

?adply

iris

## Sepal.Length가 5.0이상이고,
## species가 setosa인지 여부를 확인한 다음
## 그 결과를 새로운 컬럼 V1에 기록한다면??


# 방법1
OnlyIrisData <- function(data){
  ifelse(((data$Sepal.Length) >= 5 & (data$Species == "setosa")),
         TRUE, 
         FALSE)
}

adply(iris, 1, OnlyIrisData)



# 방법2

iris$V1 <- c()
iris$V1 <- ifelse( (iris$Sepal.Length >= 5) & (iris$Species == "setosa"), TRUE, FALSE 



                   
                   
                   
                   
                   
################ ggplot2
library(ggplot2)


ggplot(delay, aes(mean_Distance, mean_ArrDelay)) + 
  geom_point(aes(size = n), alpha = 1/2)

