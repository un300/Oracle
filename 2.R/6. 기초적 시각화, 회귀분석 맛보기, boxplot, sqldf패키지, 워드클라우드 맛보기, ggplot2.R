



## 시각화 알아보기(기초!)


install.packages("mlbench")
library(mlbench)


data(Ozone)
Ozone

str(Ozone)


## 내장데이터의 경우 ?help 도움받을 수 있음
?Ozone



## 산점도
head(Ozone)

## 숫자형 데이터인 경우 산점도
plot(Ozone$V8, Ozone$V9)


## 축 이름(xlab, ylab)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg Temp", 
     ylab="EI monte Temp")


## 타이틀 추가 : main
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg Temp", 
     ylab="EI monte Temp",
     main="Region Ozone")


## 점의 종류 변경 : pch
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg Temp", 
     ylab="EI monte Temp",
     main="Region Ozone",
     pch=10)


## 점의 크기 : cex
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg Temp", 
     ylab="EI monte Temp",
     main="Region Ozone",
     pch=10,
     cex=0.5)


## 색상 변경 : col
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg Temp", 
     ylab="EI monte Temp",
     main="Region Ozone",
     pch=10,
     cex=0.5,
     col="red")


## 좌표축의 범위 : xlim, ylim
plot(Ozone$V8, Ozone$V9, 
     xlab = "Sandburg Temp", 
     ylab = "EI monte Temp",
     main = "Region Ozone",
     pch  = "+",
     cex  = 0.5,
     col  = 9,
     xlim = range(Ozone$V8, na.rm=T),
     ylim = range(Ozone$V9, na.rm=T))




## jitter : plot에 겹쳐져 있는 데이터(점)들을 겹치지 않게 흐트려뜨림
plot(jitter(Ozone$V6), jitter(Ozone$V7))


plot(jitter(Ozone$V8), jitter(Ozone$V9), 
     xlab = "Sandburg Temp", 
     ylab = "EI monte Temp",
     main = "Region Ozone",
     pch  = "+",
     cex  = 0.5,
     col  = 9,
     xlim = range(Ozone$V8, na.rm=T),
     ylim = range(Ozone$V9, na.rm=T))







## type


data(cars)
str(cars)
head(cars)



plot(cars$speed, cars$dist)
plot(cars, type = 'l')
plot(cars, type = 'o')


## 직선(abline) : plot 옵션이아님 / 이미 그려져있는 plot에 회귀선을 그어주는 것!
## b0 : 절편
## b1 : 기울기
## y = b0 + b1x + e

plot(cars, type = 'o')
abline()

## dist = -5 + 3.5 * speed > 이런 식을 가진 대략적인 근사선을 그리고싶을때
plot(cars, type = 'p')
abline(a = -5, b = 3.5, col = "red")



## 그래프에서 speed와 dist의 평균까지 abline에 표시한다면????
abline(h = mean(cars$dist, na.rm = T), lty = 2, col = "blue")
abline(v = mean(cars$speed, na.rm = T), lty = 2, col = "green")







## 실제 회귀분석을 이용하여 회귀선을 그어보자!!


## 선형회귀 : lm
## 종속변수 : 예측하는 값
## 독립변수 : 예측하기 위해 사용하는 값


car_model <- lm(cars$dist ~ cars$speed)
summary(car_model)
car_model$coefficients[1]


head(cars)


plot(cars, type = 'p')
abline(a = car_model$coefficients[1], b = car_model$coefficients[2], col = "red")
## abline(car_model) : 회귀 분석 식을 대입하여도 회귀선이 그려짐!
abline(h = mean(cars$dist, na.rm = T), lty = 2, col = "blue")
abline(v = mean(cars$speed, na.rm = T), lty = 2, col = "green")


## 점(points)
## iris  >>  Sepal.Width, Sepal.Length를 이용하여 plot그리기

plot(iris$Sepal.Length, iris$Sepal.Width,
     xlab = "꽃잎의 길이",
     ylab = "꽃잎의 넓이",
     main = "꽃잎의 길이와 넓이의 회귀분석",
     pch = "+",
     type = "p",
     col = "skyblue")

points(iris$Petal.Length, iris$Petal.Width,
       cex = .5,
       pch = "+",
       col = "#FF0000")



with(
  iris,
  {
    plot(Sepal.Length, Sepal.Width,
         xlab = "꽃잎의 길이",
         ylab = "꽃잎의 넓이",
         main = "IRIS연습입니다",
         pch  = "+",
         type = "p",
         col  = "skyblue",
         cex  = .5)
    
    points(Petal.Length, Petal.Width,
           cex = .5,
           pch = "+",
           col = "#FF0000")
    
    legend("topright",
           legend = c("Sepal", "Petal"),
           pch    = c(6, 7),
           cex    = 0.8,
           col    = c("black", "red"),
           bg     = "gray")
  }
)













## boxplot

boxplot(iris$Sepal.Width)   ## <- 위한계선과 밑한계선을 넘어가는 데이터는 이상치!



## IQR(3사분위수 - 1사분위수)

summary(iris$Sepal.Width)

## 1사분위수 2.8
## 3사분위수 3.3
## median 3.0
## whisker 값을 계산한다면?
## 중앙값 - 1.5 * IQR  :  lower whisker
summary(iris$Sepal.Width)[3] - 1.5 * (summary(iris$Sepal.Width)[4]-summary(iris$Sepal.Width)[2])
## 중앙값 + 1.5 * IQR  :  upper whisker
summary(iris$Sepal.Width)[3] + 1.5 * (summary(iris$Sepal.Width)[4]-summary(iris$Sepal.Width)[2])


## boxplot을 눕혀서 보고싶다?? : horizontal = T
boxplotStats <- boxplot(iris$Sepal.Width,
                        horizontal = T)



boxplotStats
text(boxplotStats$out,
     rep(1, NROW(boxplotStats$out)),
     pos = 1, cex = .5)




## iris의 setosa종과 versicolor종의 Sepal.Width에 대한 상자그림을 그려보자


iris2 <- iris[iris$Species == "setosa" | iris$Species == "versicolor", ]
iris2$Species <- factor(iris2$Species)


boxplot(Sepal.Width ~ Species, 
        data = iris2, 
        horizontal = T)






## hist() : 빈도 수 기반, 밀도 기반
## service_data_visualization_region_weather.csv


library(dplyr)
data <- read.csv(file.choose())
as_tibble(data)

data$지점 <- as.factor(data$지점)
as_tibble(data)



avgTemp <- data$평균기온
hist(avgTemp, 30)

















## ggplot  :  잘 알아 두세요!!!!
## ggplot은 4가지로 함수로 나누어 진다.
## - ggplot()                   >    틀을그리고
## - geom_그래프()              >    틀에 그래프를 그리고
## - geom_도형()                >    도형을 추가하고..
## - coord_계열(), labs()


library(ggplot2)
library(dplyr)

# ggplot() : 필수함수이다! 데이터와 축을 지정할때 사용한다.
# geom_point() : 산포도
# geom_line() : 선
# geom_boxplot() : 박스플랏
# geom_histogram() : 히스토그램
# geom_bar() : 막대그래프
iris





## geom_point()
ggplot(data = iris,
       aes(x = Sepal.Length, 
           y = Sepal.Width)) +
  geom_point(pch  = 2,
             size = .8,
             col  = "red")


ggplot(data = iris,
       aes(x = Sepal.Length, 
           y = Sepal.Width, 
           shape = Species,
           color = Species)) +
  geom_point(size = 2)





## 위 결과를 이용하여 종에따라 그래프에 나타나는 모양과 크기를 다르게 하려면??
ggplot(data = iris,
       aes(x = Sepal.Length, 
           y = Sepal.Width)) +
  geom_point(pch  = c(2, 4, 6)[iris$Species],
             size = c(.8, 1, 1.2)[iris$Species],
             col  = c("red", "blue", "black")[iris$Species])








## geom_도형()
## Species 별 Sepal.Length와 Sepal.Width의 최대 최소값을 구하라 


irisG <- ggplot(data = iris, 
                aes(x = Sepal.Length, 
                y = Sepal.Width, 
                shape = Species,
                color = Species)) +
        geom_point(size = 2)

irisG  



aesXY <- iris %>% 
  group_by(Species) %>% 
  summarise(max_x = max(Sepal.Length),
            min_x = min(Sepal.Length),
            max_y = max(Sepal.Width),
            min_y = min(Sepal.Width))

aesXY <- as.data.frame(aesXY)
aesXY


aesX_start <- max(aesXY$min_x)
aesX_start
aesX_end <- min(aesXY$max_x)
aesX_end

aesY_start <- max(aesXY$min_y)
aesY_start
aesY_end <- min(aesXY$max_y)
aesY_end







## annotate()
## 위에서 ggplot()함수를 통해 만든 irisG를 annotate()함수를 통해 그려보자

irisG + annotate(geom  = "rect",
                 xmin  = aesX_start,
                 xmax  = aesX_end,
                 ymin  = aesY_start,
                 ymax  = aesY_end,
                 fill  = "red",
                 alpha = .1,
                 col   = "black",
                 lty   = 2)






## 외부옵션을 활용한 - coord 계열, labs 계열
## 축변환 - coord_flip() : x축과 y축의 변수를 바꿔준다.
## 축범위 - coord_cartesian() : 


irisG
irisG + coord_flip()




## 라벨링 - labs() : 제목과 x축 y축 라벨을 지정해준다.
irisG + labs(title = "제목",
             x = "x 이름",
             y = "y 이름")



















## ggplot
## ggplot옵션은 알아서 공부하기 ㅎ

sampleDF <- data.frame(
  years = c(2015, 2016, 2017, 2018, 2019, 2020),
  gdp   = c(300, 350, 400, 450, 500, 550)
)

sampleDF


## 1. 틀 생성
ggplot(data = sampleDF,
       aes(x = years, y = gdp)) +
  geom_line(linetype = "dashed") +
  geom_point()




install.packages("gcookbook")
library(gcookbook)


data(uspopage)
str(uspopage)
as_tibble(uspopage)
tail(uspopage)
View(uspopage)



## year, thousands 가지고 기본적 ggplot() 만들어 보세요 ㅎㅎ

ggplot(data = uspopage,
       aes(x = Year, 
           y = Thousands, 
           shape = AgeGroup, 
           colour = AgeGroup)) +
  geom_line(size = 1)



## geom_area() : 누적그래프를 그려줌
ggplot(data = uspopage,
       aes(x = Year, 
           y = Thousands, 
           fill = AgeGroup)) +
  geom_area(alpha = .8, col = "black")




korMovies <- c('강철비2', '반도', '그놈이그놈이다', '킹덤', '살아있다')
korMovies

cntMovies <- c(5, 11, 3, 34, 23)

movieDF <- data.frame(moviesName = korMovies, moviesCnt = cntMovies)
movieDF

movieDF




## geom_col() : x축 y축을 지정해줄때 쓰는 바 그래프
ggplot(data = movieDF, 
       aes(x = moviesName, 
           y = moviesCnt,
           fill = moviesName)) +
  geom_col(width = .4)




## geon_bar() : x축 y축 두개의 축이 아니라 하나의 축을 지정할때 쓰는 그래프
## MASS패키지의 Cars93을 이용하여 geom_bar를 실습하시오
install.packages("cars")
library(MASS)

data(Cars93)
as_tibble(Cars93)



ggplot(data = Cars93,
       aes(x = Type, 
           fill = Type)) +
  geom_bar() +
  ggtitle("Bar Chart by Type")










## 자동차의 유형별로 집계(count())해서 막대그래프를 표현한다면?
## sqldf 패키지를 사용하시오
## sqldf : R에서 sql구문을 사용하게 만들어줌


install.packages("sqldf")
library(sqldf)


type_cnt <- sqldf('SELECT     type, count(*) as cnt
                   FROM       Cars93
                   GROUP BY   Type
                   ORDER BY   Type')

type_cnt



# geom_col
ggplot(data = type_cnt,
       aes(x = Type,
           y = cnt,
           fill = Type)) +
  geom_col() + 
  labs(title = 'geom_col 실습입니다^^')



# geom_bar
ggplot(data = type_cnt,
       aes(x = Type,
           y = cnt,
           fill = Type)) +
  geom_bar(stat = 'identity') +
  labs(title = "geom_bar()는 x축 y축 두개일때 stat = 'identity!") +
  xlab('자동차 종류') + 
  ylab("개수")










## 비율이 들어간 막대그래프!
## melt()를 사용해보자 ㅎ


maleStu <- c(20, 35, 30, 35, 27, 25)
femaleStu <- c(25, 30, 32, 29, 32, 29)
classNum <- c(1, 2, 3, 4, 5, 6)

stuDF <- data.frame(maleStu, femaleStu, classNum)
stuDF


library(reshape2)

stuMelt <- melt(stuDF, id = "classNum")

ggplot(data = stuMelt,
       aes(x = classNum,
           y = value, 
           fill = variable)) + 
  geom_bar(stat = 'identity', width = 0.2)



## 한 범주에 바가 두개인 막대그래프!!
## 위 결과에서 position = position_dodge(width = 숫자!) 옵션을 추가하면된다

ggplot(data = stuMelt,
       aes(x = classNum,
           y = value, 
           fill = variable)) + 
  geom_bar(stat = 'identity',
           width = 1, 
           position = position_dodge(width = .5))






## Cars93 데이터를 이용하여, 차종(Type)별 제조국(Origin)별 자동차 수를 가지고
## 막대그래프를 그려보아라


data(Cars93)
as_tibble(Cars93)

temp_data <- Cars93[, c('Type', 'Origin')]

ggplot_data <- temp_data %>% 
  group_by(Type, Origin) %>% 
  summarise(cnt = n())



## 1. 비율막대 그래프
ggplot(data = ggplot_data, 
       aes(x = Type,
           y = cnt,
           fill = Origin)) +
  geom_bar(stat = 'identity', width = 0.5, col = 'black') +
  labs(title = 'Cars93 데이터를 이용한 비율막대그래프 실습입니다.')



## 2. 비율이 아닌 막대그래프
ggplot(data = ggplot_data, 
       aes(x = Type,
           y = cnt,
           fill = Origin)) +
  geom_bar(stat = 'identity', 
           width = 0.5, 
           col = 'black',
           position = position_dodge(width = 0.2))+
  labs(title = 'position = position_dodge(width = 0.2)')









########################
### 워드 클라우드 맛보기


install.packages("wordcloud2")
library(wordcloud2)

head(demoFreq, 10)

# 워드클라우드 그리기

wordcloud2(demoFreq,
           color = 'random-light',
           backgroundColor = 'black')




# 워드클라우드 내보내기

install.packages("webshot")
install.packages("htmlwidgets")
library(webshot)
library(htmlwidgets)


wImg <- wordcloud2(demoFreq,
           color = 'random-light',
           backgroundColor = 'black')



saveWidget(wImg, "wImg.html",
           selfcontained = F)



webshot::install_phantomjs()

webshot("wImg.html",
        "wImg.pdf",
        vwidth  = 480,
        vheight = 480,
        delay   = 5)














###############################################################
###################시각화 실습#################################

# data : airquality

data(airquality)
airquality


library(dplyr)
as_tibble(airquality)

airquality <- as.data.frame(airquality)


### 변수명을 소문자로 만들어라
# names(), renames()
names(airquality) <- c('ozone', 'solar.r', 'wind', 'temp', 'month', 'day')
as_tibble(airquality)



## 1. x축 day, y축 temp 틀만들기
as_tibble(airquality)



library(ggplot2)
ggplot_frame <- ggplot(data = airquality,
       aes(x = day, 
           y = temp)) 



## 2. 만들어진 틀에 산점도 그리기.
ggplot_frame + geom_point()


## 3. 크기를 3, 색상을 빨강으로한 산점도 그리기
ggplot_frame + 
  geom_point(col = 'red',
             cex = 3)
  


## 4. 만들어진 틀에 꺽은선 그래프와 산점도 그리기
ggplot_frame + 
  geom_point(col = 'red',
             cex = 3) +
  geom_line()
  




## 5. 꺽은선 그래프 색상을 빨강으로 산점도 크기를 3으로 변경하고, 겹쳐서 그리기
ggplot_frame + 
  geom_point(col = 'red',
             cex = 3) +
  geom_line(col = 'red')



## 6. day열을 그룹지어, 날짜별 온도 상자그림(boxplot)그리기
as_tibble(airquality)


boxplot(temp ~ day, data = airquality)

ggplot(data = airquality, 
       aes(x = factor(day),
           y = temp, 
           fill = factor(day))) +
  geom_boxplot(outlier.colour = 'red') +
  labs(title = '날짜별 온도 히스토그램')
?geom_boxplot

## 7. temp 히스토그램 그리기

as_tibble(airquality)

ggplot(data = airquality,
       aes(x = temp)) + 
  geom_histogram(col = 'black', fill = 'skyblue')






## 아래부터는 mtcar 데이터 사용
## 1. cyl 종류별 빈도수 확인 geom_bar

data(mtcars)
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$gear <- as.factor(mtcars$gear)

as_tibble(mtcars)

temp_data <- mtcars %>% 
  group_by(cyl) %>% 
  summarise(cnt = n())

temp_data


## 2. cyl 종류별 빈도수 확인

sum(is.na(mtcars))

as_tibble(mtcars)

temp_data <- mtcars %>%
  group_by(cyl) %>% 
  summarise(cnt = n())

temp_data

ggplot(data = temp_data,
       aes(x = cyl,
           y = cnt,
           fill = cyl)) +
  geom_bar(stat = 'identity')

## 3. cyl 종류별 빈도수를 이용해 선버스트(coord_polar()) 차트 그리기


ggplot(data = temp_data,
       aes(x = cyl,
           y = cnt,
           fill = cyl)) +
  geom_bar(stat = 'identity') +
  coord_polar(theta = "y")
?coord_polar

## 4. cyl 종류별 빈도수를 이용해 원 그래프 그리기

ggplot(data = temp_data,
       aes(x = cyl,
           y = cnt,
           fill = cyl))+
  geom_bar(stat = 'identity') +
  coord_polar()

?coord_polar

## 5. cly 종류별 gear 빈도 누적 막대그래프
as_tibble(mtcars)
data <- mtcars %>% 
  select(cyl, gear) %>% 
  group_by(cyl, gear) %>% 
  summarise(cnt = n())

data


ggplot(data = data,
       aes(x = cyl,
           y = cnt,
           fill = gear)) +
  geom_bar(stat = 'identity', width = 0.5)


## 6. cyl 종류별 gear 비율 누적 막대그래프

ggplot(data = data,
       aes(x = cyl,
           fill = gear)) + 
  geom_bar(stat ='count', position = 'fill')

?geom_bar

ggplot(data = data,
       aes(x = cyl,
           y = cnt,
           fill = gear)) + 
  geom_col()


## 7. cyl열을 x축으로 지정하여 cyl별 gear 빈도 파악 선버스트 차트 그리기

as_tibble(mtcars)

data <- mtcars %>%
  select(cyl, gear) %>% 
  group_by(cyl, gear) %>% 
  summarise(cnt = n())


as_tibble(data)

ggplot(data = data,
       aes(x = cyl,
           y = cnt,
           fill = gear)) +
  geom_col() +
  coord_polar(theta = 'x')


## 8. cly열을 x축으로 지정하여 cly별 gear 빈도 파악 원그래프 그리기

ggplot(data = data,
       aes(x = cyl,
           y = cnt,
           fill = gear)) +
  geom_col() +
  coord_polar(theta = 'y')

??labs
??coord_polar





























