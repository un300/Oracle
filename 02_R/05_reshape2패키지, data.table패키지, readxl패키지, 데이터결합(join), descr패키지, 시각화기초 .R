
library(plyr)
library(dplyr)


## ddply(데이터, .(그룹지을 변수명 or 처리조건), 처리함수) : 데이터 프레임을 입력받고 데이터프레임을 반환하는 함수




## iris 데이터에서 종별 Sepal.Length 평균을 계산한다면?

ddply(iris, 
      .(Species), 
      function(x){
        data.frame(Sepal.Length.mean = mean(x$Sepal.Length))
      })





## 위 결과에서 Sepal.Length >= 5.0인 처리조건을 추가한다면?

ddply(iris, 
      .(Species, Sepal.Length >= 5.0),  
      function(x){
        data.frame(Sepal.Length.mean = mean(x$Sepal.Length))
      })






data(baseball)
head(baseball)
str(baseball)
as_tibble(baseball)
names(baseball)

## id가 ansonca01인 선수의 데이터만 확인하고 싶다면?

# 방법 1
baseball[baseball$id == "ansonca01", ]

# 방법 2
subset(baseball, baseball$id == "ansonca01")

# 방법 3
baseball %>% 
  filter(id == "ansonca01")

# ddply() 함수를 이용화여 각 선수별 출전한 게임수의 평균을 구하라

ddply(baseball, 
      .(id),
      function(data){
        data.frame(game_mean = mean(data$g))
      })


# 각 선수별 최대 게임을 플레이한 해의 기록을 구한다면?

as_tibble(baseball)
ddply(baseball,
      .(id),
      subset,
      g == max(g)
      )






# reshape2 패키지
# 변환
# melt() : 가로로 긴 데이터 프레임을 세로로 길게 만들어줌 
#cast(dcast, acast) : melt()로 만들어진 데이터 프레임의 원본을 만들어줌


install.packages("reshape2")
library(reshape2)


# melt(데이터를 구분하는 식별자, 측정대상변수, 측정치)
?reshape2::melt


data(french_fries)
head(french_fries)
as_tibble(french_fries)


fries_melt <- melt(id = 1:4, french_fries)
fries_melt

french_fries
head(french_fries)
head(fries_melt)




fries_d <- dcast(fries_melt, time + treatment + subject + rep ~ ...)
fries_d






## data.table 패키지

install.packages("data.table")
library(data.table)


iris_table <- data.table(iris)
iris_table[iris_table$Species == "setosa", ]


#임의의 2개의 피쳐만 출력한다면?
str(iris)


# 인덱스를 벡터로 하느냐? 리스트로 하느냐?
iris_table[1, c(Sepal.Length, Species)] # > 벡터는 피쳐이름 x 팩터변수 숫자로 반환!
iris_table[1, list(Sepal.Length, Species)] # > 리스트는 피쳐이름 ㅇ 팩터변수 문자로 반환!
                                          # 왼만하면 리스트로 인덱스 지정하자



## iris데이터에서 Sepal.Length의 평균값을 종별로 구분한다면
iris_table[, mean(Sepal.Length), Species]







## --- 외부파일 읽어 들이는 패키지 readxl

library(readxl)



## read_excel() : 엑셀파일 불러들이기 
## read.tabel() : txt파일 불러들이기
## read.csv() : csv파일 불러들이기

excel_data_sample <- read_excel(file.choose())
View(excel_data_sample)

# header옵션 : 첫번째 행이 피쳐의 이름인가? 그렇다면 TRUE!!
# skip옵션 : 데이터 스킵할께요
# nrows옵션 : 몇개 행만 가져올께요
# sep옵션 : 데이터를 구분(, / " ")하는 옵션을 지정할께요
# col.names = c(컬럼이름) : 컬럼이름을 지정할께요


#파일명 : service_data_tap_ex
txt_data_sample01 <- read.table(file.choose(), header = T)
txt_data_sample01

#파일명 : service_data_tap_ex1.txt
txt_data_sample02 <- read.table(file.choose(), header = T, sep = ",")
txt_data_sample02

#파일명 : service_data_tap_ex2.txt
txt_data_sample03 <- read.table(file.choose(), header = T, sep = ",", col.names = c("ID", "SEX", "AGE", "AREA"))
str(txt_data_sample03)

#파일명 : service_data_excel_sample.xlsx
excel_data_sample01 <- read_excel(file.choose())
str(excel_data_sample01)
class(excel_data_sample01)


## 불러들인 파일은 범주형데이터를 인식하지 못함
## 그래서 범주형으로 만들어 주어야함
excel_data_sample01$SEX <- as.factor(excel_data_sample01$SEX)
excel_data_sample01$AREA <- as.factor(excel_data_sample01$AREA)
str(excel_data_sample01)
levels(excel_data_sample01$SEX)
levels(excel_data_sample01$AREA)


# 성별에 따른 17_AMT 평균이용 금액을 확인하고 싶다면??

excel_data_sample01 %>%
  group_by(SEX) %>% 
  dplyr::summarise(m = mean(AMT17))


ddply(excel_data_sample01, 
      .(SEX), 
      function(data){
        data.frame(mean(data$AMT17))
      })


sapply(split(excel_data_sample01$AMT17, excel_data_sample01$SEX),
       mean,
       na.rm = T)

# 지역에 따른 Y17_CNT 이용건수의 합을 확인하고 싶다면?

excel_data_sample01 %>% 
  group_by(AREA) %>% 
  dplyr::summarise(sum(Y17_CNT))








## 칼럼이름 따오는법
names(excel_data_sample01) # > 칼럼 순서 그대로 가져옴
ls(excel_data_sample01) # > 칼럼 순서 상관없이 가져옴




## 변수명 변경하기
## dplyr::rename()

str(excel_data_sample01)
colRename <- dplyr::rename(excel_data_sample01, Y17_AMT = AMT17, Y16_AMT = AMT16)  ## > (바꾸고자하는 변수명) = (원래있던 변수명)
colRename








## 파생변수 


colRename$Total_AMT <- c()
colRename$Total_CNT <- c()
colRename$Total_AMT <- colRename$Y17_AMT + colRename$Y16_AMT
colRename$Total_CNT <- colRename$Y17_CNT + colRename$Y16_CNT
colRename
colRename <- dplyr::rename(colRename, AMT = Total_AMT, CNT = Total_CNT)
colRename








# 1. colRename 데이터 세트에서 ID 변수만 추출
str(colRename)
colRename[, "ID"]


# 2. colRename 데이터 세트에서 ID, AREA, Y17_CNT 변수 추출
colRename[, c("ID", "AREA", "Y17_CNT")]


# 3. colRename 데이터 세트에서 AREA 변수만 제외하고 추출
str(colRename)
colRename[, -c(4)]

# 4. colRename 데이터 세트에서 AREA, Y17_CNT 변수를 제외하고 추출
as_tibble(colRename)
colRename[,-c(4, 6)]



# 5. colRename 데이터 세트에 AREA(지역)가 서울인 경우만 추출
colRename[colRename$AREA == "서울", ]


# 6. colRename 데이터 세트에서 AREA(지역)가 서울이면서 Y17_CNT(17년 이용 건수)가 10건 이상인 경우만 추출 
colRename[colRename$AREA == "서울" & colRename$Y17_CNT >= 10, ]


# 7. colRename 데이터 세트의 AGE 변수를 오름차순 정렬
colRename %>% arrange(AGE)


# 8. colRename 데이터 세트의 Y17_AMT 변수를 내림차순 정렬
colRename %>%  arrange(desc(Y17_AMT))



# 정렬 중첩 
# 9. colRename 데이터 세트의 AGE 변수는 오름차순, Y17_AMT 변수는 내림차순 정렬
colRename %>% arrange(AGE, desc(Y17_AMT))

# 데이터 요약하기
# 10. colRename 데이터 세트의 Y17_AMT(17년 이용 금액) 변수 값 합계를
# TOT_Y17_AMT 변수로 도출
TOT_Y17_AMT <- sum(colRename$Y17_AMT)
TOT_Y17_AMT



# 11. colRename 데이터 세트의 AREA(지역) 변수 값별로 
# Y17_AMT(17년 이용 금액)를 더해 SUM_Y17_AMT 변수로 도출

colRename %>%
  group_by(AREA) %>% 
  dplyr::summarise(SUM_Y17_AMT = sum(Y17_AMT))



# 12. colRename 데이터 세트의 AMT를 CNT로 나눈 값을 
# colRename 데이터 세트의 AVG_AMT로 생성
colRename$AVG_AMT <- colRename$AMT/colRename$CNT
str(colRename)



# 13. colRename 데이터 세트에서 AGE 변수 값이 50 이상이면 “Y”
# 50 미만이면 “N” 값으로 colRename 데이터 세트에 AGE50_YN 변수 생성 

colRename <- colRename %>% 
  mutate(AGE50_YN = ifelse(AGE >= 50, "Y", "N"))
colRename$AGE50_YN <- as.factor(colRename$AGE50_YN)

as_tibble(colRename)



# ::나이분류
# 14. colRename 데이터 세트의 
# AGE 값이 50 이상이면 “50++”, 
# 40 이상이면 “4049”
# 30 이상이면 “3039”, 
# 20 이상이면 "2029”, 
# 나머지는 “0019”를 값으로 하는 AGE_GR10 변수 생성 



colRename <- colRename %>% 
  mutate(AGE_GE10 = ifelse(AGE >= 50, "50++",
                           ifelse(AGE >= 40, "4049", 
                                  ifelse(AGE >= 30, "3039", 
                                         ifelse(AGE >= 20, "2029", "0019")))))
colRename$AGE_GE10 <- as.factor(colRename$AGE_GE10)
as_tibble(colRename)






## 데이터 결합

library(readxl)

# service_data_excel_m_history.xlsx
male_hist <- read_excel(file.choose())


# service_data_excel_f_history.xlsx
female_hist <- read_excel(file.choose())



male_hist
female_hist

## 세로결합 : 두 데이터 프레임의 피쳐(feature)가 동일해야만 join이 가능함
## > 변수명을 기준으로 결합함
## rbind(), cbind()는 벡터들을 결합해주는 함수임
## bind_rows()


m_f_bind_join <- bind_rows(male_hist, female_hist)
m_f_bind_join




## 가로결합
## left_join : 지정한 변수와 데이터세트1을 기준으로 데이터세트2에 있는 
##              나머지 변수 결합  (차집합과 비슷)

## inner_join : 데이터세트1과 데이터세트2에서 기준으로 지정한 변수값이
##              동일할 때만 결합이 된다.  (교집합과 비슷)
## full_join : 전체를 결합  (합집합과 비슷)



## service_data_jeju_y17_history.xlsx
## service_data_jeju_y16_history.xlsx
## 위 두개 파일을 읽어보자



jeju_17 <- read_excel(file.choose())
jeju_16 <- read_excel(file.choose())


as_tibble(jeju_17)
as_tibble(jeju_16)


## ID를 기준으로 jeju_17 데이터 세트를 기준으로 결합
bind_left <- left_join(jeju_17, jeju_16, by = "ID")
bind_left

bind_inner <- inner_join(jeju_17, jeju_16, by = "ID")
bind_inner

bind_full <- full_join(jeju_17, jeju_16, by = "ID")
bind_full









## 특정 값이 얼마나 반복되는지 분석(빈도 분석)하고 싶다면?

install.packages("descr")
library(descr)

freqArea <- freq(colRename$AREA, plot = TRUE, main = "지역별 빈도")
freqArea 


## 성별에 따른 빈도분석을 할려고 하면??

freq(colRename$SEX, plot = T)

colRename %>% 
  group_by(SEX) %>% 
  dplyr::summarise(n = n(), percent = n()/nrow(colRename)*100)










##############
##############
##############
##############
## 시각화

# 변수를 구분할 수 있어야함(이산 vs 연속)
# 이산형 변수 : 가질 수 있는 값이 끊어져 있는 변수
#                 명목변수, 순위변수    >   막대, 점, 파이

char_data <- c(380, 520, 330, 390, 320, 460, 300, 405)
char_data

names(char_data) <- c("2018 1Q", "2019 1Q", "2018 2Q", "2019 2Q", "2018 3Q", "2019 3Q", "2018 4Q", "2019 4Q")
char_data

range(char_data)
max(char_data)
length(char_data)


## 막대차트 : barplot()
barplot(char_data)

barplot(char_data, ylim = c(0, 600))

barplot(char_data, xlim = c(0, 600),
        col = rainbow(2),
        main = "2018 VS 2019 분기매출",
        horiz = T,
        ylab = "년도별 분기",
        xlab = "2018 VS 2019 분기매출 현황")

?barplot




## dot chart
?dotchart
dotchart(char_data,
         color = c("green", "red"),
         xlab = "매출액",
         ylab = "연도별 분기",
         pch = 1:2,
         cex = 0.8,
         lcolor = "blue")




## pie chart

par(mfrow=c(2, 2))
pie(char_data)

pie(char_data,
    border = 'blue',
    col = rainbow(8),
    labels = names(char_data))

data(iris)
pie(table(iris$Species))






## 연속변수 (상자그래프, 히스토그램, 산점도)
## > 변수가 연속된 구간을 갖는다는 뜻
## = 간격변수 or 비율변수
## boxplot(), hist(), plot()

## 시각화
## 내장데이터 사용 VADeaths

data(VADeaths)
VADeaths

str(VADeaths)
summary(VADeaths)

boxplot(VADeaths)  ## 보통 boxplot은 이상치를 확인하기위해 사용한다.
### 데이터에 따라 평균과 분산이 다르기에 
### 정규화를 통해 평균 분산을 같은 기준으로 맞추고
### 비교할 수 있다.





## attach(), detach()
mean(iris$Sepal.Length)
attach(iris)
detach(iris)


## 히스토그램
data(iris)
iris

summary(iris)
hist(iris$Sepal.Length)
hist(iris$Sepal.Length,
     xlab = "꽃받침 길이", 
     col = "green",
     main = "iris Sepal_Length",
     xlim = c(4.0, 8.0))




?hist
hist(iris$Sepal.Width,
     main = "iris Sepal_width",
     xlim = c(2.0, 4.5),
     col = "green",
     freq = F)
lines(density(iris$Sepal.Width), col = "red")





## 산점도(plot())

iris
x <- runif(1000, min = 0, max = 1)
y <- x^2
plot(x, y)


price <- runif(10, min = 2, max = 8)
plot(price, type = "l")
plot(price, type = 'o')
plot(price, type = "h")
plot(price, type = "s")

plot(price, type = 'o', pch = 25)


# iris - scatter matrix(산점도 매트릭스)
# pairs()

iris
pairs(iris[1:4])








## 3차원 산점도


install.packages("scatterplot3d")
library(scatterplot3d)


# 종별로 분류해서 변수에 담아 보세요


library(dplyr)
data(iris)

iris$Species

iris_setosa <- iris %>% 
  filter(Species == "setosa")

iris_versicolor <- iris %>% 
  filter(Species == "versicolor")

iris_virginica <- iris %>% 
  filter(Species == "virginica")




?scatterplot3d

iris3D <- scatterplot3d(iris$Petal.Length,
                        iris$Sepal.Length,
                        iris$Sepal.Width, type = 'n')




iris3D$points3d(iris_setosa$Petal.Length,
                iris_setosa$Sepal.Length,
                iris_setosa$Sepal.Width,
                bg = "green",
                pch = 21)


iris3D$points3d(iris_versicolor$Petal.Length,
                iris_versicolor$Sepal.Length,
                iris_versicolor$Sepal.Width,
                bg = "red",
                pch = 25)


iris3D$points3d(iris_virginica$Petal.Length,
                iris_virginica$Sepal.Length,
                iris_virginica$Sepal.Width,
                bg = "blue",
                pch = 12)












