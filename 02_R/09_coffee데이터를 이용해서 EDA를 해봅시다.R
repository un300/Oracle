

library(readxl)
library(dplyr)

coffee <- read_xlsx(file.choose())


temp_coffee <- coffee




str(temp_coffee)
as_tibble(temp_coffee)
View(temp_coffee)



# 1. 주소지가 서울 특별시인 데이터만 추출하여 확인해보자
# 번호, 사업장명, 소재지전체주소, 업태구분명, 시설총규모, 인허가일자, 폐업일자,
# 소재지 면적, 상에염업상태명, 영업상태구분코드


str(temp_coffee)
data <- temp_coffee %>% select('번호', '사업장명', '소재지전체주소', '업태구분명', '시설총규모', 
                               '인허가일자', '폐업일자', '소재지면적','상세영업상태명', '영업상태구분코드') %>% 
  filter(substr(temp_coffee$소재지전체주소, 1, 5) == '서울특별시')



str(data)
as_tibble(data)


#########################################################
## str_detect(벡터, "찾고자하는 문자열 or 정규표현식")
library(stringr)

fVector <- c("tomato", "pear", "apple", "banana",  "mato")
str_detect(fVector, 'mato')
str_detect(fVector, '^t')
str_detect(fVector, 'o$')
str_detect(fVector, '[pe]')

letters
str_detect(letters, '[abc]')
########################################################


str(data)


data$업태구분명 %>% table()



# 커피숍 업태만 선택하기

str(data)

coffeeShop <- data %>% 
  filter(업태구분명 == "커피숍")


str(coffeeShop)
View(coffeeShop)





# 폐업하지 않고 현재 영업 중인 카페 찾기

str(coffeeShop)
coffeeShop$상세영업상태명 <- as.factor(coffeeShop$상세영업상태명)

coffeeShopOpen <- coffeeShop[coffeeShop$상세영업상태명 == "영업", ]

str(coffeeShopOpen)




# 지역구 별로 데이터 나누기(서대문, 영등포, 동대문) 3개의 구만 추출 (시각화로 사용할꺼)

str(coffeeShopOpen)
threeCoffeeDong <- coffeeShopOpen[str_detect(coffeeShopOpen$소재지전체주소, '서대문구|영등포구|동대문구'), ]
View(threeCoffeeDong$소재지전체주소)

threeCoffeeDong$지역구 <- str_extract(threeCoffeeDong$소재지전체주소, '서대문구|영등포구|동대문구')

str(threeCoffeeDong)
View(threeCoffeeDong)


# 인허가 일자와 폐업일자의 데이터 형식이 chr와 logic으로 되어 있는 것을 확인할 수있다.
# ymd 함수를 통해 chr와 logi 형식으로 되어있는 데이터형식을 Date로 바꾼다.
threeCoffeeDong$인허가일자 <- as.POSIXct(threeCoffeeDong$인허가일자, format = '%Y%m%d')



# 데이터 타입 date형식 바꾸기
install.packages("anytime")
library(anytime)
install.packages("lubridate")
library(lubridate)


str(threeCoffeeDong$인허가일자)
str(threeCoffeeDong$폐업일자)


threeCoffeeDong$인허가일자 <- ymd(threeCoffeeDong$인허가일자)
str(threeCoffeeDong$인허가일자)

threeCoffeeDong$폐업일자 <- ymd(threeCoffeeDong$폐업일자)
str(threeCoffeeDong$폐업일자)



# 아래 코드 실행결과 폐업일자는 모두 NA입니다
threeCoffeeDong$폐업일자 %>% is.na() %>% sum() == nrow(threeCoffeeDong)
str(threeCoffeeDong)





# Date로 바꾼 인허가 일자 데이터를 바탕으로 인허가
# year, month, day를 각각 추출해 가변수를 만들어보자

threeCoffeeDong$허가연도 <- year(threeCoffeeDong$인허가일자)
threeCoffeeDong$허가월 <- month(threeCoffeeDong$인허가일자)
threeCoffeeDong$허가일 <- day(threeCoffeeDong$인허가일자)

str(threeCoffeeDong)






# 데이터 형식 전처리
# 시설총규모 타입 확인 후 문자형 -> 수치형
# 시설총규모에 따라 이를 구분지어
# 초소형, 초형, 중형, 대형, 초대형으로 구분지어 보려 한다면
# 구분은 다음 코드와 같이 임의로 지정
# 3제곱 미터 이하는 초소형.
# 30제곱미터 이하는 소형,
# 70제곱미터 이하는 중형,
# 300제곱미터 이하는 대형 나머지 초대형

str(threeCoffeeDong)

threeCoffeeDong$시설총규모 <- as.numeric(threeCoffeeDong$시설총규모) 

str(threeCoffeeDong)

# 시설총규모 범주화 > 시설규모
{
threeCoffeeDong$시설규모 <- ''
threeCoffeeDong[threeCoffeeDong$시설총규모 > 300, ]$시설규모 <- '초대형'
threeCoffeeDong[threeCoffeeDong$시설총규모 > 70 & threeCoffeeDong$시설총규모 <= 300, ]$시설규모 <- '대형'
threeCoffeeDong[threeCoffeeDong$시설총규모 > 30 & threeCoffeeDong$시설총규모 <= 70, ]$시설규모 <- '중형'
threeCoffeeDong[threeCoffeeDong$시설총규모 > 3 & threeCoffeeDong$시설총규모 <= 30, ]$시설규모 <- '소형'
threeCoffeeDong[threeCoffeeDong$시설총규모 <= 3, ]$시설규모 <- '초소형'
}

str(threeCoffeeDong)

threeCoffeeDong$시설규모 <- as.factor(threeCoffeeDong$시설규모)

str(threeCoffeeDong)




data <- threeCoffeeDong %>% 
  group_by(지역구, 시설규모) %>% 
  summarise(count = n())

data$시설규모 <- factor(data$시설규모, levels = c('초소형', '소형', '중형', '대형', '초대형'))

# 지역구별 시설규모 수
ggplot(data,
       aes(x = 지역구,
           y = count,
           fill = 시설규모)) +
  geom_bar(stat = 'identity', 
           width = 0.5, 
           position = "dodge",
           col = 'black') +
  labs(title = '지역구별 시설규모 수') +
  theme_bw()


# 지역구별 시설규모 비율
ggplot(data,
       aes(x = 지역구,
           y = count,
           fill = 시설규모)) +
  geom_bar(stat = 'identity', 
           width = 0.5, 
           position = "fill",
           col = 'black') +
  labs(title = '지역구별 시설규모 비율') +
  ylab(label = '비율') +
  xlab(label = '지역구') + 
  theme_bw()




# 규모별 커피숍 수 확인하기
# 영업중이면서 인허가일자가 2000년 이후 인 커피숍 수를 규모별로 확인해 본다면?



str(threeCoffeeDong)
threeCoffeeDong$인허가일자 > ymd('20000101')

data2 <- threeCoffeeDong %>% 
  filter(인허가일자 >= ymd('20000101')) %>% 
  group_by(지역구, 시설규모) %>% 
  summarise(count = n())

threeCoffeeDong_2000 <- threeCoffeeDong %>% 
  filter(인허가일자 >= ymd('20000101'))

str(threeCoffeeDong_2000)

# 인허가 일자가 2000이후인 지역구별 시설규모 수
ggplot(data2,
       aes(x = 지역구,
           y = count,
           fill = 시설규모)) +
  geom_bar(stat = 'identity', 
           width = 0.5, 
           position = "dodge",
           col = 'black') +
  labs(title = '지역구별 시설규모 수') +
  theme_bw()







## data2


cafe2000 <- data2 %>% arrange(desc(count))

cafe2000




# 가장 큰 규모의 카페는 어디일까요?


str(threeCoffeeDong_2000)
threeCoffeeDong_2000$시설총규모 <- as.numeric(threeCoffeeDong_2000$시설총규모)
Most_big_cafe <- threeCoffeeDong_2000 %>% arrange(desc(시설총규모))
Most_big_cafe <- Most_big_cafe[1, ] 
View(Most_big_cafe)
t(Most_big_cafe)




# 시설 총규모를 히스토그램으로 시각화 한다면?

threeCoffeeDong_2000
ggplot(data = threeCoffeeDong_2000,
       aes(x = 시설총규모,
           fill = 'red')) +
  geom_histogram(col = 'black',
                 binwidth = 30) +
  theme(legend.position = 'none') +
  scale_x_continuous(breaks = c(100, 200, 300, 400, 500, 600)) ### -> 규모가 100이내에 카페가 밀집되어 있다






# 영업중인 카페의 인허가연도 히스토그램
str(threeCoffeeDong_2000)


str(threeCoffeeDong_2000)

open_data <- threeCoffeeDong_2000 %>% filter(상세영업상태명 == '영업', 인허가일자 >= ymd('2000-01-01'))

str(open_data)
open_data$인허가연도 <- year(open_data$인허가일자)
open_data$인허가연도 <- as.factor(open_data$인허가연도)

ggplot(data = open_data,
       aes(x = 인허가연도,
           fill = 시설규모)) +
  geom_histogram(stat = 'count', col = 'black', width = 0.5) +
  coord_flip()







str(temp_coffee)
select_temp_coffee <- temp_coffee[, c('번호', '사업장명', '소재지전체주소', '업태구분명', '시설총규모', 
                                     '인허가일자', '폐업일자', '소재지면적','상세영업상태명', '영업상태구분코드')]


str(select_temp_coffee)

seoul_coffee <- select_temp_coffee %>% 
  filter(substr(소재지전체주소, 1, 2) == '서울')


str(seoul_coffee)
three_dong_coffee <- seoul_coffee[str_detect(seoul_coffee$소재지전체주소, '동대문구|서대문구|영등포구'), ]
str(three_dong_coffee)

seoul_coffee$구 <- ''
three_dong_coffee$구 <- str_extract(three_dong_coffee$소재지전체주소, '동대문구|서대문구|영등포구')
str(three_dong_coffee)

three_dong_coffee$허가연도 <- year(three_dong_coffee$인허가일자)
str(three_dong_coffee)

three_dong_coffee$인허가일자 <- ymd(three_dong_coffee$인허가일자)
three_dong_coffee$시설총규모 <- as.numeric(three_dong_coffee$시설총규모)
three_dong_coffee$업태구분명 <- as.factor(three_dong_coffee$업태구분명)
three_dong_coffee$소재지면적 <- as.numeric(three_dong_coffee$소재지면적)
three_dong_coffee$구 <- as.factor(three_dong_coffee$구)  
str(three_dong_coffee)





# 서울 소재 커피숍의 2000년 이후의 데이터를 확인하고 데이터 프레임으로 만들어라

str(three_dong_coffee)
three_dong_coffee2000 <- three_dong_coffee %>% 
  filter(인허가일자 >= ymd('2000-01-01'))


# 위에 만든 데이터프레임에서 영업중인 커피숍의 데이터를 확인하고 데이터 프레임으로 만들어라

str(three_dong_coffee2000)
open_three_dong_coffee2000 <- three_dong_coffee2000 %>% 
  filter(상세영업상태명 == '영업')


# 위의 데이터를 이용하여 연도별 폐업하거나 영업중인 전체 커피숍수의 추이와
# 영업중인 커피숍수 추이를 시간의 흐름에 따라 그래프로 그려라

three_dong_coffee2000
open_three_dong_coffee2000

str(three_dong_coffee2000)
year_count2000 <- three_dong_coffee2000 %>% 
  group_by(허가연도) %>% 
  summarise(count_all = n())
str(year_count2000)


year_count2000_open <- open_three_dong_coffee2000 %>% 
  group_by(허가연도) %>% 
  summarise(count_open = n())


?merge

year_change <- merge(year_count2000, year_count2000_open, by.y ='허가연도')
year_change


library(reshape2)
melt(year_change, id = c('허가연도'))


ggplot(data = melt(year_change, id = c('허가연도')),
       aes(x = 허가연도,
           y = value,
           col = variable)) +
  geom_line()





## 2001년도 시설 총규모에 따른 영업구분을 히스토그램으로 시각화



str(select_temp_coffee)

select_temp_coffee$시설총규모 <- as.numeric(select_temp_coffee$시설총규모) 
str(select_temp_coffee)



ggplot(data = three_dong_coffee2000[three_dong_coffee2000$허가연도 == 2001, ],
       aes(x = 시설총규모, 
           fill = 상세영업상태명)) +
  geom_histogram(bins = 20, col = 'black')


#################################################################################
#############################데이터 너무 중구난방....#############################
#####################첨부터 다시 정리해보자#######################################


seoul_coffee <- temp_coffee %>% select('번호', '사업장명', '소재지전체주소', '업태구분명', '시설총규모', 
                               '인허가일자', '폐업일자', '소재지면적','상세영업상태명', '영업상태구분코드') %>% 
  filter(substr(temp_coffee$소재지전체주소, 1, 5) == '서울특별시')

str(seoul_coffee)
seoul_coffee$시설총규모 <- as.numeric(seoul_coffee$시설총규모)
seoul_coffee$인허가일자 <- ymd(seoul_coffee$인허가일자)
seoul_coffee$상세영업상태명 <- as.factor(seoul_coffee$상세영업상태명)



# 구 추가

seoul_coffee$구 <- ''
seoul_coffee$구 <- str_extract(seoul_coffee$소재지전체주소, '[가-힇]{2,3}구')
seoul_coffee$구 <- as.factor(seoul_coffee$구)

str(seoul_coffee)



# 허가연도 추가

seoul_coffee$허가연도 <- ''
seoul_coffee$허가연도 <- year(seoul_coffee$인허가일자)



# 2010년도 ~
# 지역구에 따른 년도별 커피숍 추이를 만들어보자


str(seoul_coffee)


seoul_coffee_2010 <- seoul_coffee[seoul_coffee$인허가일자 >= ymd('2010-01-01'), ]

str(seoul_coffee_2010)

data <- seoul_coffee_2010 %>% group_by(구, 허가연도) %>% 
  summarise(count = n())


ggplot(data, 
       aes(x = 허가연도,
           y = count,
           col = 구)) +
  geom_line(cex = 0.8)



