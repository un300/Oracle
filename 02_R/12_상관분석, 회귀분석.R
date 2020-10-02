




# 학습은 3가지로 나뉜다
# 지도학습, 비지도학습, 강화학습



# 지도학습: 학습하는 과정에서 예측하고자 하는 변수가 주어질때
# 예측하고자하는 변수가 범주형이다? > 분류 (classification)
#     대표알고리즘 : KNN, SVM, Decision Tree, RandomForest, Logistic Regression etc

# 예측하고자하는 변수가 연속형이다? > 예측 (prediction, estimation)
#     대표알고리즘 : Regression




# 비지도학습 : 학습하는 과정에서 예측하고자 하는 변수가 주어지지 않을때
# 군집분석(Clustering) 
# 연관규칙(Association Rule)
# 연속규칙(Sequemce rule)








# 1. 단순회귀분석
# 회귀분석을 하기전에!!.. 
# 상관분석 vs 회귀분석

# 상관분석 : 하나의 변수와 다른 변수와의 밀접한 관련성을 분석하는 기법
# cor()

height <- c(100, 120, 130, 140, 150, 160, 170, 180, 190)
foot <- c(200, 205, 210, 220, 230, 240, 250, 270, 290)

plot(height, foot,
     xlab = '키',
     ylab = '발크기기')

cor(height, foot)
abline(h = mean(foot), lty = 2)
abline(v = mean(height), lty = 2)



# 회귀분석 : 두 변수간에 원인과 결과의 인과관계가 있는지를 분석하는 기법\
# lm()


airquality
str(airquality)


air01 <- airquality[, c(1:4)]
air01


pairs.panels(air01)

install.packages('psych')
library(psych)


plot(air01$Ozone, air01$Temp)


# 결측치가 있어 상관계수가 나오지 않음
cor(air01$Ozone, air01$Temp)
cor(air01)



summary(air01)


# NA가 있는 행 찾고 제거하기
air01[!complete.cases(air01), ]
air02 <- air01[complete.cases(air01), ]
air02



# NA가 있는 행 찾고 제거하기 2 : na.omit(air01)
na.omit(air01)





# NA도 제거했으니 상관계수를 보자
cor(air02)






# cor()말고 조금더 시각화해서 보여주는 corrplot packages

install.packages("corrplot")
library(corrplot)


air.cor <- cor(air02)


corrplot(air.cor, method = 'number')
corrplot(air.cor, method = 'square')
corrplot(air.cor, method = 'circle')
corrplot(air.cor, method = 'ellipse')
corrplot(air.cor, method = 'shade')
corrplot(air.cor, method = 'color')
corrplot(air.cor, method = 'pie')
?corrplot






## 실습

df <- read.csv("http://goo.gl/HKnl74")
str(df)

# 각 feature별 NA수의 합
colSums(is.na(df))



# 놀이기구 만족도가 높으면 전체 만족도 또한 높지 않을까? 예상을 해보고 그림으로 그려보자
plot(df$overall ~ df$rides)
cor(df$overall , df$rides) # 상관계수가 약 0.585로 양의 선형관계를 가지고 있다


# peraon 방식 상관분석
cor.test(df$overall, df$rides)







# 가설 : 꽃받침의 길이가 길 수록 꽃잎의 넓이도 크다.
# Sepal : 꽃받침
# Petal : 꽃잎



cor(iris[, 1:4])
cor(iris$Sepal.Length, iris$Petal.Width)

cor.test(iris$Sepal.Length, iris$Petal.Width)


symnum(cor(iris[, 1:4]))





# corrgram packages : corrplot이랑 비슷한 패키지

install.packages('corrgram')
library(corrgram)

corrgram(cor(iris[, 1:4]), type = 'corr',
         upper.panel = panel.conf)









## 선형회귀분석
## 예측모델에서 사용하는 알고리즘

## 인과 관계를 분석하는 방법
# 조건1
# x가 변할때, y도 변한다.

# 조건2
# 시간적으로 선행 되어야 한다.

# 조건3
# 외생변수를 통제(다른 요인을 통제하고 인과관계를 분석)



# 종속변수 혹은 목표변수
# 영향을 받는 변수

# 독립변수, 설명변수
# 영향을 주는 변수

# model <- lm()
# plot(model)
# summary()
# abline()
# abline(intercept, slope)
# y = b0 + b1x + e
# b0 : 절편
# b1 : 기울기
# e(epsilon) : 오차



women
str(women)
# women 데이터에서 height의 단위는 inch임  :  1inch = 2.54cm

# inch를 cm로
women$height <- women$height * 2.54
women$weight <- women$weight * 0.453592
str(women)


cor(women)


# 위 데이터를 아용하여 회귀분석을 진행해보자
fit_model <- lm(weight ~ height, data = women)
summary(fit_model)

par(mfrow = c(2, 2))
plot(fit_model)


# 상관 플랏을 그려보고, 회귀선을 그어보자
par(mfrow = c(1, 1))
plot(x = women$height, y = women$weight)

abline(v = mean(women$height), col = 'blue', lty = 2)
abline(h = mean(women$weight), col = 'blue', lty = 2)
abline(fit_model, col = 'red', , lty = 2)
# 회귀선이 x축 y축의 평균을 지나감을 확인할 수 있다.




# 오차확인하기
fitted(fit_model)
residuals(fit_model)[1]


# 회귀분석 summary
summary(fit_model)







# 예측하기 : predict(회귀모델, 예측하고자하는 데이터)
predict(fit_model, newdata = data.frame(height = 180))




















# 예측모델 평가지표

# ME(Mean of Errors)
# MSE(Mean Squared Error)
# RMSE(Root Mean of Squared Error)  :  MSE의 제곱근!
# 보편적으로 RMSE를 모델의 성능평가 지표로 사용하는 경우가 많음
# MAE(Mean of Absolute Error)
# MPE(Mean of Percentage Error)
# 


## 위에 나열한 예측모델 평가지표를 사용할 수 있는 library
install.packages('forecast')
library(forecast)




swiss
str(swiss)


model01 <- lm(Fertility ~ . , data = swiss)
summary(model01)

model02 <- lm(Fertility ~ Agriculture , data = swiss)
summary(model02)



plot(swiss$Fertility)
lines(model01$fitted.values, col = 'red')
lines(model02$fitted.values, col = 'blue')



## 여러가지 평가지표 확인하기
accuracy(model01)
accuracy(model02)

# 첫번째 모댈(model01)의 평가지표들이 적은 수치를 가진다
# 그러므로 model01의 성능이 model02의 성능보다 좋다고 할 수 있다.






## 선형회귀분석 실습
# service_datasets_product_regresson.csv

product <- read.csv(file.choose())
str(product)

str(product)

cor.plot(product)
#### > corplot결과 만족도와 적절성의 상관계수가 0.77,
####   만족도와 친밀도의 상관계수가 0.47으로
####   만족도와 적절성으로 만든 회귀모델이 더욱 성능이 좋은 모델일거 같다

# 만족도 ~ 적절성 선형회귀
reg_model01 <- lm(제품_만족도 ~ 제품_적절성, data = product)
summary(reg_model01)

# 만족도 ~ 친밀도 선형회귀
reg_model02 <- lm(제품_만족도 ~ 제품_친밀도, data = product)
summary(reg_model02)




par(mfrow = c(1, 2))

# 만족도 ~ 적절성
plot(x = product$제품_적절성, y = product$제품_만족도, main = '만족도 ~ 적절성')
lines(reg_model01$fitted.values, col = 'red')


# 만족도 ~ 친밀도
plot(x = product$제품_친밀도, y = product$제품_만족도, main = '만족도 ~ 친밀도')
lines(reg_model02$fitted.values, col = 'red')



# 평가지표 비교하기
accuracy(reg_model01)
accuracy(reg_model02)


par(mfrow = c(2, 2))
plot(reg_model01)


## 중요! : 회귀분석은 정규성, 등분산성, 독립성 세 가지 가정을 만족하여야 진행할 수 있다.
## 하지만, 오늘 수업은 대략적으로 알아보는 과정이기에.. 세가지 과정을 생략하였습니다






## 선형회귀분석 kaggle DATA SET을 활용한 실습
# Linear Regression


train_set <- read.csv(file.choose())
test_set <- read.csv(file.choose())

str(train_set)
str(test_set)
summary(train_set)


# 1. 결측치 확인 및 제거
colSums(train_set)
train_set <- train_set[!is.na(train_set$y),]
plot(train_set$x, train_set$y)



# 2. 상관분석

cor.plot(train_set)





# 3. boxplot


par(mfrow = c(1, 2))
boxplot(train_set$x,
        main = 'x')

boxplot(train_set$y,
        main = 'y')
# > 이상치가 없어보여요 ㅎ




# 4. 회귀 적합모델 생성

reg_model <- lm(y ~ x, data = train_set)
summary(reg_model)

library(ggplot2)
ggplot(data = train_set,
       aes(x = x,
           y = y)) +
  geom_point(col = 'gray') +
  stat_smooth(method = 'lm') +
  geom_vline(xintercept = mean(train_set$x), col = 'red') +
  geom_hline(yintercept = mean(train_set$y), col = 'red')

?geom_vline


# 오차구하는법1
fitted(reg_model) - train_set$y

# 오차구하는법2
residuals(reg_model)
summary(reg_model)




# 5. 분석결과를 시각화

library(ggplot2)


ggplot(data = train_set,
       aes(x = x,
           y = y)) +
  geom_point(col = 'gray') +
  stat_smooth(method = 'lm', level = 0.95) +
  geom_vline(xintercept = mean(train_set$x), col = 'red') +
  geom_hline(yintercept = mean(train_set$y), col = 'red')




# 6. 학습된 모델을 이용하여 예측하기
y_predict <- predict(reg_model, newdata = test_set)

head(test_set, 1)
y_predict[1]



ggplot(data = test_set,
       aes(x = x,
           y = y)) +
  geom_point(col = 'gray') +
  geom_line(aes(x = test_set$x,
                y = predict(reg_model, newdata = test_set),
                col = 'red'))

compare <- cbind(actual = test_set$x, y_predict)
compare


# 모델 성능 지표
accuracy(reg_model)












iris
# Sepal.Length 예측하고 싶다 <- 종속변수


iris_model <- lm(Sepal.Length ~. -Species, data = iris)
iris_model
summary(iris_model)








### 회귀직선을 그려보려 한다.(abline)
### abline() 첫번째 인자는 절편, 두번쨰 인자는 기울기, 선스타일


# service_datasets_insurance_ml.csv
insu_train <- read.csv(file.choose())
str(iris_model)



# 종속변수 : charges
# 독립변수 : age, gender, bmi, children

insu_train2 <- insu_train[, c('age', 'bmi', 'children', 'charges')]
str(insu_train)



corrplot(cor(insu_train), method = 'circle')

reg_model <- lm(charges ~ ., data = insu_train)
summary(reg_model)
reg_model

age <- reg_model$coefficients[2]
bmi <- reg_model$coefficients[3]
children <- reg_model$coefficients[4]




## 범주형 변수를 회귀분석에 입력한다면..??
## 함수내에서 알아서 처리해준다
lm(charges ~ age + bmi + children + smoker + region, data = insu_train)







### 회귀분석 실습 prestige
install.packages("car")
library(car)

data(Prestige)

Prestige
str(Prestige)



# 종속변수 : income
# 독립변수 : education, women, prestige

# 상관분석

data_set <- Prestige[,c('income', 'education', 'women', 'prestige')]


cor(data_set)
corrplot(cor(data_set))




prestige_model <- lm(income ~. , data = data_set)
summary(prestige_model)




## education 변수가 유의하지 않으니 제거하자
prestige_model02 <- lm(income ~. -education , data = data_set)
summary(prestige_model02)   # > 결정계수가 조금.. 올랏따^^;
















