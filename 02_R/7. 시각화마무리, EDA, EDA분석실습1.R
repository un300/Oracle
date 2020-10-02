



## 시각화 마무리 & EDA 도입

## 파워비아이? > R에서 사용하는(library가 아닌) 시각화 도구래

library(dplyr)
library(ggplot2)



seoul_subway <- read.csv(file.choose())
as_tibble(seoul_subway)
str(seoul_subway)





## x축을 평균일 승차 인원으로 설정하고
## y축을 각 노선의 운행횟수로 설정하여서
## 평균 혼잡도로 산점도를 그려보자



seoul_subway[2, 'AVG_ONEDAY'] <- 1461
seoul_subway$AVG_ONEDAY <- as.numeric(seoul_subway$AVG_ONEDAY)
seoul_subway$LINE <- as.factor(seoul_subway$LINE)



as_tibble(seoul_subway)
ggplot(data = seoul_subway,
       aes(x = AVG_ONEDAY,
           y = RUNNINGTIMES_WEEKDAYS,
           color = LINE,
           size = AVG_CROWDEDNESS)) + 
  geom_point()






## x축을 각 노선(LINE)으로 일평균 막대그래프를 만들어보자

as_tibble(seoul_subway)


ggplot(data = seoul_subway,
       aes(x = LINE,
           y = AVG_ONEDAY,
           fill = LINE)) +
  geom_bar(stat = 'identity', color = 'black')





## mtcars
## 차량별 연비를 가지고 시각화 할려고 한다.
## 차량별 이름이 데이터에 존재하지 않음!
## 데이터 열이름이 차량이름으로 존재하기에
## rownames() 함수 사용하면 됨



as_tibble(mtcars)
mtcars$type <- rownames(mtcars)
as_tibble(mtcars)


## 차량이름 문제는 해결!
## 이제 차량별 연비를 이용하여 막대그래프를 그려라

as_tibble(mtcars)
mtcars$type <- as.factor(mtcars$type)


ggplot(data = mtcars,
       aes(x = type,
           y = mpg,
           fill = type)) +
  geom_bar(stat = 'identity', colour = 'black')


## 위결과의 x축 y축을 변경하여라

ggplot(data = mtcars,
       aes(x = type,
           y = mpg,
           fill = type)) +
  geom_bar(stat = 'identity', colour = 'black')+
  coord_flip()


ggplot(data = mtcars,
       aes(y = type,
           x = mpg,
           fill = type)) +
  geom_bar(stat = 'identity', colour = 'black')






## reorder(정렬하고 싶은것, 기준)

# 오름차순 정렬
ggplot(data = mtcars,
       aes(x = reorder(type, mpg),
           y = mpg,
           fill = type)) +
  geom_bar(stat = 'identity', colour = 'black')



# 내림차순 정렬
ggplot(data = mtcars,
       aes(x = reorder(type, -mpg),
           y = mpg,
           fill = type)) +
  geom_bar(stat = 'identity', colour = 'black')


# theme

ggplot(data = mtcars,
       aes(x = reorder(type, -mpg),
           y = mpg,
           fill = type)) +
  geom_bar(stat = 'identity', colour = 'black') +
  theme(axis.text.x = element_text(angle = 90))


# labs() : 타이틀과 x, y의 이름 지정

ggplot(data = mtcars,
       aes(x = reorder(type, -mpg),
           y = mpg,
           fill = type)) +
  geom_bar(stat = 'identity', colour = 'black') +
  coord_flip() +
  labs(title = '범주가 너무 많아', x = '연비', y = '차종')


#################################시각화 마무리 할께오##############################
#########################중간중간 필요한거는 강사님이 말씀해 주신데################











## EDA (Exploratory Data Analysis) : 탐색적 데이터 분석

## 1. 데이터 탐색
## 2. 결측치(NA) 처리
## 3. 이상치(outlier) 발견 처리
## 4. 리코딩(코딩변경)
## 5. 파생변수, 가변수 추가
## 6. 시각화
## 7. 의사결정(예측, 분류)


# service_data_dataset_eda.csv

eda_data <- read.csv(file.choose())
eda_data

dim(eda_data)
nrow(eda_data)
ncol(eda_data)
names(eda_data)
as_tibble(eda_data)
is.na(eda_data)
summary(eda_data)
View(eda_data)



summary(eda_data$price)
table(is.na(eda_data$price))


## 결측치 처리하는 방법
## 'caret' package : na.omit()
##                        >> 결측치가 포함된 모든 행을 제거합니다
dataset_new <- na.omit(eda_data)
table(is.na(dataset_new))
table(is.na(eda_data))
as_tibble(dataset_new)



############ 결측치 대체 실습
price <- eda_data$price
price

# 1. 0으로 대체
price[is.na(price)] <- 0
is.na(price)

# 2. 평균으로 대체
price[is.na(price)] <- mean(price, na.rm = T)
is.na(price)

# 3. 통계적 방법으로 대체
#     >> 가변수를 사용한다. price 가격대 별로 등급을 나누어 가변수를 만들어 주는 것을 의미함


# type(고객의 유형)이라는 변수는 원래 없었지만... 있었다고 치자.. ㅎ

priceAvg <- mean(eda_data$price, na.rm = T)
eda_data$type <- rep(1:3, 100)
eda_data$type
eda_data

# eda_data$type : 1(고급), 2(중급), 3(하급) 으로 고객의 유형이 나누어져있다.
# 그래서 각각의 price를 고급에는 1.15배, 중급에는 1.10배, 하급에는 1.05배를 적용하여 파생변수를 만들고 싶다
# type과 price를 이용하여 priceSta 파생변수를 만들어보자


as_tibble(eda_data)

eda_data$priceSta <- NA
eda_data[eda_data$type == 1, ]$priceSta <- priceAvg * 1.15
eda_data[eda_data$type == 2, ]$priceSta <- priceAvg * 1.10
eda_data[eda_data$type == 3, ]$priceSta <- priceAvg * 1.05

eda_data$priceSta <- as.numeric(eda_data$priceSta)

as_tibble(eda_data)






str(eda_data)
gender <- eda_data$gender
gender

table(gender)


## subset을 활용하여 이상치를 제거한 후,
## gender를 범주형으로 변환 해보자
## 


eda_data_gender <- eda_data[eda_data$gender == 1 | eda_data$gender == 2, ]
eda_data_gender$gender <- as.factor(eda_data_gender$gender)
eda_data_gender$gender



## 변수의 유형이 연속변수라면
## 어떻게 이상치를 제거 할까요?

seqPrice <- eda_data_gender$price
summary(seqPrice)


## IQR (Q3 - Q1) 6.2 - 4.6 = 1.6
## 

outlier <- boxplot(seqPrice)
outlier$stats[1, 1]

dataset <- seqPrice[seqPrice>=outlier$stats[1, 1] & seqPrice <= outlier$stats[5, 1]]
dataset

boxplot(dataset)




## age체크
summary(eda_data$age)


## 결측치 제거 후 시각화
age <- eda_data$age[!is.na(eda_data$age)]
boxplot(age, horizontal = T)






head(eda_data)






# 리코딩 - 데이터의 가독성을 위해서
# 연속형 -> 범주형

# 형식 ) dataset$컬럼[조건식] <- 추가할 값
# 1 : 서울, 2 : 부산, 3 : 광주, 4 : 대전, 5 : 대구



eda_data$resident_new[eda_data$resident==1] <- "서울"
eda_data$resident_new[eda_data$resident==2] <- "부산"
eda_data$resident_new[eda_data$resident==3] <- "광주"
eda_data$resident_new[eda_data$resident==4] <- "대전"
eda_data$resident_new[eda_data$resident==5] <- "대구"


eda_data$resident_new

as_tibble(eda_data)






# 주거지의 NA값을 행정수도인 대전으로 대체
eda_data[is.na(eda_data$resident_new),]$resident_new <- "대전"
as_tibble(eda_data)
eda_data$resident_new <- as.factor(eda_data$resident_new)
levels(eda_data$resident_new)





# job
# 1 : 분석가, 2 : 데이터과학자, 3 : 개발자

as_tibble(eda_data)

eda_data$job_new <- 1
eda_data[is.na(eda_data$job), ]$job_new <- "취업준비생"
eda_data[eda_data$job == 1 & !is.na(eda_data$job), ]$job_new <- "분석가"
eda_data[eda_data$job == 2 & !is.na(eda_data$job), ]$job_new <- "데이터과학자"
eda_data[eda_data$job == 3 & !is.na(eda_data$job), ]$job_new <- "개발자"

eda_data$resident_new <- as.factor(eda_data$resident_new)
as_tibble(eda_data)








####### 간단분석
url <- "https://www.dropbox.com/s/0djexymb42zd1e2/example_salary.csv?dl=1"
salary_data_eda <- read.csv(url, na = '-')

head(salary_data_eda)
str(salary_data_eda)
as_tibble(salary_data_eda)

salary_data_eda$age <- as.factor(salary_data_eda$age)
salary_data_eda$career <- as.factor(salary_data_eda$career)
salary_data_eda$gender <- as.factor(salary_data_eda$gender)


## 1. 칼럼명을 영문으로 변경
as_tibble(salary_data_eda)

colnames(salary_data_eda) <- list("age", "month_salary", "year_salary", "work_time", "woker_num",  "career", "gender")


## 2. 각 피쳐별 결측값 확인
sum(is.na(salary_data_eda))
apply(is.na(salary_data_eda), 2, sum)


## 3. 임금 평균 확인
mean(salary_data_eda$month_salary, na.rm = T) # 월임금
mean(salary_data_eda$year_salary, na.rm = T) # 연임금


## 4. 임금 중앙값 확인
median(salary_data_eda$month_salary, na.rm = T) # 월임금
median(salary_data_eda$year_salary, na.rm = T) # 연임금




## 5. 임금 범위 구해보기(최저, 최고)
quantile(salary_data_eda$month_salary, na.rm = T)
quantile(salary_data_eda$year_salary, na.rm = T)


## 6. 임금에 대한 사분위수(quantile()) 구하기
quantile(salary_data_eda$month_salary, na.rm = T)
quantile(salary_data_eda$year_salary, na.rm = T)



## 7. 성별에 따른 임금 격차 확인해보기
gender_salary <- salary_data_eda %>% 
  group_by(gender) %>%
  summarise(mean_month_salary = mean(month_salary, na.rm = T),
            mean_year_salary = mean(year_salary, na.rm = T))

gender_salary_minus <- gender_salary[1, 2:3] - gender_salary[2, 2:3]
gender_salary_minus

## 8. 분석된 데이터를 가지고 원하는 시각화 진행

# -19세는 임금이 없기에 임금란이 결측치임
salary_data_eda
adult_data <- salary_data_eda[salary_data_eda$age != "-19" ,]

as_tibble(adult_data)

# 결측치 제거 : adult_data
apply(is.na(adult_data), 2, sum)

as_tibble(adult_data)


## 나이별, 성별로 나눈 평균월급여
data1 <- adult_data %>% 
  group_by(age, gender) %>% 
  summarise(mean_year_salary = mean(year_salary),
            mean_month_salary = mean(month_salary),
            mean_work_time = mean(work_time))


ggplot(data = data1,
       aes(x = age,
           y = mean_month_salary,
           fill = gender)) +
  geom_bar(stat = 'identity', colour = 'black',
           position = position_dodge(width = 0.5))



## 나이별, 성별로 나눈 평균연급여
ggplot(data = data1,
       aes(x = age,
           y = mean_year_salary,
           fill = gender)) +
  geom_bar(stat = 'identity', colour = 'black',
           position = position_dodge(width = 0.5))





## 나이별, 성별로 나눈 노동시간
as_tibble(data1)

ggplot(data = data1,
       aes(x = age,
           y = mean_work_time,
           fill = gender)) +
  geom_bar(stat = 'identity', position = "dodge", colour = 'black', width = 0.5)


## 나이별, 성별로 나눈 노동시간비율
ggplot(data = data1,
       aes(x = age,
           y = mean_work_time,
           fill = gender)) +
  geom_bar(stat = 'identity', position = 'fill', colour = 'black', width=0.5) +
  scale_fill_brewer(palette = 10)

?scale_fill_brewer




#### 9. 성별에 따른 표준편차 구하기




## 10. 경력별 임금 평균치
## 11. 경력별 임금 평균치 시각화


data2 <- adult_data %>% 
  group_by(career, age) %>% 
  summarise(mean_month_salary = mean(month_salary),
            mean_year_salary = mean(year_salary))


## 막대그래프
ggplot(data = data2, 
       aes(x = career,
           y = mean_month_salary,
           fill = age)) +
  geom_bar(stat = 'identity', position = 'dodge', colour = 'black') +
  scale_fill_brewer(palette = 8) +
  scale_x_discrete(limits = c('1년미만', '1~3년미만', '3~5년미만', '5~10년미만', '10년이상'))




as_tibble(adult_data)

## 박스그래프
ggplot(data = adult_data,
       aes(x = career,
           y = month_salary,
           fill = career)) +
  geom_boxplot() +
  scale_x_discrete(limits = c('1년미만', '1~3년미만', '3~5년미만', '5~10년미만', '10년이상')) +
  scale_fill_brewer(palette = 1)








































