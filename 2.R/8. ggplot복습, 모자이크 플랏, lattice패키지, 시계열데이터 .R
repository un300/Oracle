

dataset <- read.csv(file.choose())

View(dataset)

str(dataset)
library(dplyr)

as_tibble(dataset)





### 범주형 vs 범주형을 가지고 데이터의 분포를 확인한다면?

# 1. resident2, gender >  범주형으로 변환

dataset$resident2 <- as.factor(dataset$resident2)
dataset$gender <- factor(dataset$gender)
as_tibble(dataset)


# 2. 두 변수를 table()함수에 적용하여 분포를 확인해보자
?table

table(dataset$resident2)
table(dataset$gender)

resident_gender <- table(dataset$resident2, 
      dataset$gender)
resident_gender



## barplot 사용

barplot(resident_gender, 
        horiz = T,
        beside = T,
        legend = row.names(resident_gender),
        col = rainbow(5))


library(ggplot2)


## ggplot 사용

ggplot(data = data.frame(resident_gender),
       aes(x = Freq,
           y = Var2,
           fill = Var1)) + 
  geom_bar(stat = 'identity', 
           position = 'dodge',
           colour = 'black',
           width = 0.7) +
  scale_fill_brewer(palette = 7) +
  labs(title = '성별, 주거지역별 인구 분포도') + 
  xlab(label = '빈도 수') +
  ylab(label = '성별')


## 모자이크 플랏

mosaicplot(resident_gender, col = rainbow(2))













## 직업유형(job2) vs 나이(age2)


as_tibble(dataset)

dataset$job2 <- as.factor(dataset$job2)
dataset$age2 <- as.factor(dataset$age2)

job2_age2 <- table(dataset$job2, dataset$age2)

job2_age2





barplot(job2_age2,
        beside = T,
        col = rainbow(3),
        legend = row.names(job2_age2))





ggplot(data = data.frame(job2_age2), 
       aes(x = Var2,
           y = Freq,
           fill = Var1)) + 
  geom_bar(stat = 'identity', 
           position = 'dodge', 
           width = 0.8,
           colour = 'black')






## 숫자형 vs 범주형
## 직업 유형에 따른 나이 비율?

## 카테고리 유형별 시각화 : lattice package > densityplot
install.packages('lattice')
library(lattice)

str(dataset)
densityplot(dataset$age, 
            dataset, 
            group = dataset$job2,
            auto.key = T)


str(dataset$age)

temp <- dataset %>% 
  group_by(job2, age) %>% 
  dplyr::summarise(cnt = n())


dataset


as_tibble(temp)




ggplot(data = temp,
       aes(x = job2,
           y = cnt,
           fill = factor(age))) +
  geom_bar(stat = 'identity', position = 'dodge')













### 시계열 (time series)
### 변수간의 상관성

### iris data를 활용하여 시계열 데이터 만들기
data(iris)
iris

seq <- as.integer(rownames(iris))

irisDF <- cbind(iris, seq)
irisDF


# x축은 seq
# y축은 Species를 제외한 모든 변수

## 색지정

str(irisDF)
colsColor <- topo.colors(4, alpha = .4)
names(colsColor) <- names(irisDF)[1:4]
colsColor





library(reshape2)
## melt 함수를 이용해서 기준 seq, species
## 나머지 칼럼을 variable 해서 wide -> long

iris_melt <-melt(irisDF, id = c('seq', 'Species'))
iris_melt$seq


View(iris_melt)
str(iris_melt)

g <- ggplot(iris_melt,
       aes(x = seq,
           y = value,
           col = variable)) +
  geom_line(cex = 0.8, show.legend = T)
              


# 추가적으로 선의 색상과 범례 라벨링
g <- g + scale_color_manual(
  name = '',
  values = colsColor,
  labels = c('꽃받침 길이', '꽃받침 넓이', '꽃잎 길이', '꽃잎 넓이')
)









# 날짜
# 문자변수를 날짜변수로 변환
# R의 날짜 데이터 타입 "POSIXct"
# as.POSIXct()

str_date <- "200730 13:40"
as.POSIXct(str_date, format = '%y%m%d %H:%M')

str_date <- "2020-09-30 13:40:01"
as.POSIXct(str_date, format = "%Y-%m-%d %H:%M:%S")

str_date <- "07/30/20 13:40:01"
as.POSIXct(str_date, format = "%m/%d/%y %H:%M:%S")





### cospi data 시계열 실습
cospi <- read.csv(file.choose())
str(cospi)


cospi$Date <- as.POSIXct(cospi$Date, format = "%Y-%m-%d")
str(cospi)


cospi_temp <- melt(cospi, id=c('Date'))
str(cospi_temp)


### 시간에 따른 각 변수별 변화
ggplot(data = cospi_temp,
       aes(x = Date,
           y = value,
           col = variable)) + 
  geom_line(cex = 0.5) +
  labs(title = '코스피 지수') +
  xlab(label = '월') +
  ylab(label = '주가(원)')



## volume을 제외 : 시간에 따른 각 변수별 변화


cospi_not_volume <- melt(cospi[, 1:5], id=c('Date'))
cospi_not_volume

ggplot(data = cospi_not_volume,
       aes(x = Date,
           y = value,
           col = variable)) + 
  geom_line(cex = 0.5) +
  labs(title = '코스피 지수') +
  xlab(label = '월') +
  ylab(label = '주가(원)')


data(mtcars)
mtcars
















library(ggplot2)
library(dplyr)
library(reshape2)


### 시계열 data 다루기

spanish_data <- read.csv(file.choose())
temp_data <- spanish_data


str(temp_data)
as_tibble(temp_data)

temp_data$origin <- as.factor(temp_data$origin)
temp_data$destination <- as.factor(temp_data$destination)
temp_data$train_type  <- as.factor(temp_data$train_type )
temp_data$train_class <- as.factor(temp_data$train_class)
temp_data$fare <- as.factor(temp_data$fare)


str(temp_data)
as_tibble(temp_data)


# 1.
# 데이터 내에 결측치 여부를 확인한다. 
# NA값이 310681개 있는 것을 확인할 수 있다.


apply(is.na(temp_data), 2, sum)


################################################################################
# 강사님 팁
# 결측치를 확인하는 방법
spanish_data[!complete.cases(spanish_data), ]
# 결측치를 제거하는 방법
spanish_data2 <- spanish_data[complete.cases(spanish_data), ]
################################################################################


# 2.
# filter와 !is.na함수를 통해 결측치를 모두 제거했다.

as_tibble(temp_data)
no_NA <- temp_data %>% 
  filter(!is.na(price) & !is.na(id))

as_tibble(no_NA)


# 3.
# 마드리드 출발
# 마드리드에서 출발하는 열차 데이터만을 떼어내 madrid_origin이라는 변수로 저장하고 
# 우선, 마드리드에서 출발하는 열차 데이터만을 이용해 비교해보기로 한다.


madrid_orgin <- no_NA %>% filter(origin == 'MADRID')
madrid_orgin <- madrid_orgin[, -2]
str(madrid_orgin)





# 4.
# summary함수를 통해 일반적 데이터 정보를 다시 확인한다.

summary(madrid_orgin)





# 5.
# 마드리드 출발 열차의 빈도 수
# 마드리드를 출발하는 기차의 도착 도시별 운행빈도 수를 바형태로 나타내보자

str(madrid_orgin)


depart_madrid <- madrid_orgin %>% 
  group_by(destination) %>% 
  dplyr::summarise(count = n())

str(depart_madrid)



ggplot(data = depart_madrid, 
       aes(x = destination,
           y = count,
           fill = destination)) +
  geom_bar(stat = 'identity') +
  coord_flip() +
  theme(legend.position = 'none')


# 6.
# 마드리발 도착지별 가격 박스플롯으로
# 티켓가격의 높은 순을 확인해보자

str(madrid_orgin)

ggplot(data = madrid_orgin,
       aes(x = destination,
           y = price,
           fill = destination)) +
  geom_boxplot() + 
  coord_flip() + 
  theme(legend.position = 'none')



# 7.
# AVE의좌석 등급별 가격박스플롯이 시각화 
# 똑같은 열차와 똑같은 좌석등급, 똑같은 도착지라 하더라도 가격이 차이가 나는 것을 확인할 수 있다.

str(madrid_orgin)
as_tibble(madrid_orgin)

AVE_madrid_orgin <- madrid_orgin %>% 
  filter(train_type == 'AVE')

factor(AVE_madrid_orgin$train_type)

str(AVE_madrid_orgin)
AVE_madrid_orgin <- AVE_madrid_orgin[, -5]


str(AVE_madrid_orgin)


ggplot(data = AVE_madrid_orgin,
       aes(x = train_class,
           y = price,
           fill = train_class)) +
  geom_boxplot() +
  coord_flip() +
  theme(legend.position = 'none')
























































