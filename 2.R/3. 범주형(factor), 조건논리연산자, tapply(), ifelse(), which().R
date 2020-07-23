## lapply()
## sapply()



iris


iris$Sepal.Length

class(lapply(iris[ , 1:4], mean))
class(sapply(iris[ , 1:4], mean))

irisVec <- sapply(iris[ , 1:4], mean)
irisVec


class(as.data.frame(irisVec))


### 인위적으로 결측치(NA) 만들기
iris[1, 1] = NA


head(iris)


## split()  :  자주쓰게 될꺼에요. 잘배워 보세요
#  split(feature, 분류기준(범주))

irisSepalLengthMedian <- sapply(split(iris$Sepal.Length, iris$Species), 
       median,
       na.rm=T)

irisSepalLengthMedian
class(irisSepalLengthMedian)
irisSepalLengthMedian[iris$Species]



median(iris$Sepal.Length, na.rm = T)


### iris[1, 1]은 결측치(NA)이다. 이값을 중위수로 대채하라

iris <- within(
  iris,
  {
    Sepal.Length <- ifelse(is.na(Sepal.Length), 
                           irisSepalLengthMedian[iris$Species], 
                           Sepal.Length)
  }
)

iris








### subset()  :  이것도 많이 씀
### 부분집합  :  데이터 프레임에서 원하는 데이터만 뽑아서 사용하겠다

x <- 1:5
y <- 6:10

?letters

z <- letters[1:5]
z



temp_Frame <- data.frame(x, y, z)
temp_Frame
str(temp_Frame)

## x의 값이 3이상인 결과를 새로운 데이터 프레임으로 만들어 보자.
sub_temp_Frame1 <- subset(temp_Frame, x>=3)

## y의 값이 8이하인 결과를 새로운 데이터 프레임으로 만들어 보자.
sub_temp_Frame2 <- subset(temp_Frame, y<=8)

## x의 값이 2이상이고 y의 값이 8이하인 결과를 새로운 데이터 프레임으로 만들어 보자.






### subset() 칼럼선택 가능
subDF <- subset(temp_Frame, x>=3,  select=c(x, y))
subDF




iris
str(iris)
names(iris)

# Petal.Length의 평균을 구해보세요

PLmean <- mean(iris$Petal.Length)

names(iris)


## 새로생성한 프레임의 조건으로 Petal.Length가 평균이상인 데이터만 조회 
iris_df <- subset(iris, iris$Petal.Length > PLmean, select=c(Sepal.Length, Petal.Length, Species))

iris_df


####################
####################
####################
####################
### Factor(범주형 변수)


gender <- factor("m", c("m", "f"))
gender

?factor



levels(gender)
blood.type <- factor(c("A", "A", "AB", "O", "B"))

levels(blood.type)
is.factor(blood.type)

blood.type[6] <- "D"





lettersVec <- c("a", "b", "b", "c", "a", "c", "a", "a", "a")
lettersVec
class(lettersVec)


lettersVec.fac <- as.factor(lettersVec)
lettersVec.fac
class(lettersVec.fac)





lettersVec.fac <- factor(lettersVec,
                         levels = c("a", "b", "c"),
                         labels = c("best", "middle", "low"))    ### -> "a", "b", "c"로 구성된 범주형 데이터를
                                                                 ### -> "best", "middle", "low"로 구성된 범주형 데이터로 변환!

lettersVec.fac
levels(lettersVec.fac)  # -> "best", "middle", "low"로 바뀜을 볼 수 있다.





id <- c(1, 2, 3, 4, 5)
gender <- c("F", "M", "F", "M", "F")



data <- data.frame(idx = id, gender = gender)
data
str(data)


## 범주형 데이터 지정
data$gender <- as.factor(data$gender)
data
str(data)

## 범주의 이름을 바꾸고 싶어요!
levels(data$gender) <- c("female", "male")
data
str(data)




x <- c(15, 18, 2, 36, 12, 78, 5, 6, 8)
x

mean(x)


### group by를 통해서 산술평균 구하기

height <- c(180, 165, 172, 165, 177, 162, 181, 175, 190)
gender <- c("M", "F", "M", "F", "M", "F", "M", "F", "M")

height_gender_frm <- data.frame(height, gender)
height_gender_frm$gender <- as.factor(height_gender_frm$gender)
height_gender_frm
str(height_gender_frm)

# 1. aggregate() 사용하기
?aggregate

tmp <- aggregate(height_gender_frm$height, 
          list(height_gender_frm$gender), 
          FUN=mean)





# 2. dplyr 사용하기
install.packages("dplyr")
library(dplyr)

data<- height_gender_frm %>% 
  group_by(gender) %>% 
  summarise(height_mean = mean(height))

as.data.frame(data)






##### aggregate() 연습 : 예제 mtcars

mtcars
str(mtcars)
head(mtcars)

## cyl 칼럼을 기준으로 나머지 칼럼의 평균값 구하기
aggregate(mtcars,
          list(cyl = mtcars$cyl),
          FUN = mean
          )

mtcars %>% 
  group_by(cyl) %>% 
  




## disp 칼럼이 120 이상인 조건 추가
aggregate(mtcars[(mtcars$disp >= 120), ],
          list(cyl = mtcars$cyl[(mtcars$disp >= 120)]),
          FUN = mean
          )


## cyl 칼럼을 기준으로 wt 칼럼의 평균만 구하기
aggregate(mtcars$wt,
          list(mtcars$cyl),
          FUN = mean)

aggregate(wt ~ cyl, data = mtcars, mean)  ## wt가 구하고자 하는 값 / cyl이 기준



## crab, gear 칼럼 두 가지를 기준으로 wt구하기
aggregate(wt ~ carb + gear, data = mtcars, mean)


## gear 기준으로 disp, wt평균 구하기
aggregate(cbind(wt, disp) ~ gear, data = mtcars, mean)
aggregate(wt + disp ~ gear, data = mtcars, mean)



## carb, gear 칼럼 기준으로 disp, wt 평균 구하기
aggregate(cbind(disp, wt) ~ gear + carb, data = mtcars, mean )


## cyl제외한 다른 모든 칼럼을 기준으로 cyl의 평균을 구하기
aggregate(cyl ~ ., data = mtcars, mean)








## tapply(데이터, 색인, 함수)
## 색인 : 범주형(factor)

tapply(1:10, rep(1, 10), sum)
tapply(1:10, 1:10 %% 2 ==0, sum)


## iris에서 종별로 Sepal.Length 평균
## tapply

iris
Species_mean <- tapply(iris$Sepal.Length, iris$Species, mean)
Species_mean
class(Species_mean)





## 반기별 남성 셀의 값의 합과 여성셀의 합을 구해보자
## 버리세요~

m <- matrix(1:8,
            ncol=2,
            dimnames=list(c("spring", "summer", "fall", "winter"),
                          c("male", "female")))
m
rownames(m)




tapply(m,
       list(c(1, 1, 2, 2, 1, 1, 2, 2), 
            c(1, 1, 1, 1, 2, 2, 2, 2)), 
       sum)





## 타입별 고속도로 연비 평균을 구한다면..?


Cars93
library(MASS)
head(Cars93)
str(Cars93)

levels(Cars93$Type)

?tapply
tapply(Cars93$MPG.highway, Cars93$Type, mean)





###################ggplot2 : 시각화 패키지
### ggplot2 맛보기

install.packages("ggplot2")
library(ggplot2)

qplot(MPG.highway, 
      data = Cars93,
      facets = Type ~. ,
      binwidth = 2)






### 프로그램 흐름을 제어하는 제어문, 연산자, 함수

## + - * /
## %%(나머지), %(몫)
## ^(제곱)


## 관계연산자 
## ==, !=, <=, >=

## 논리연산자
## &(AND), |(OR)
## TRUE, FALSE | T, F

## 제어문
## if, sitch

if(F) {
  print("TRUE")  
} else {
  print("FALSE")
}


score <- 55
if(score >= 60) {
  print("pass")
} else {
  print("fail")
}











## 스캔함수를 이용하여 키보드로부터 점수를 입력받고
## 점수에 따른 학점등급을 출력하라!!
## cat() 함수를 이용하여 한줄로 출력

score <- scan()
score

grade <- ""


if(score > 90) {
  grade <- "A"
} else if(score > 80) {
  grade <- "B"
} else if(score > 70) {
  grade <- "C"
} else if(score > 60) {
  grade <- "D"
} else {
  grade <- "F"
}


cat("당신의 점수는 ", score, "점이고, 당신의 학점은 ", grade, "이다.")




### 주민번호 14자리(-포함)를 scan()을 통해 입력받아, 남자/여자를 구별하는
### if else를 구현하라

ssn <- scan(what="")  ### 문자를 입력받는 방법
gender <- (substr(ssn, 8, 8))


if ( gender == 1 | gender == 3 ) {
  print("남자")
} else if( gender==2 | gender==4 ) {
  print("여자")
} else {
  print("사람이 아닙니다.")
}




### if ~~ else 한번에 적용하는 방법 : ifelse(조건식, TRUE, FALSE)

x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
result <- c()


## 기존의 if ~~~ else 방식 : for문을 사용해서 원소 하나하나를 비교해야함!!
for(i in 1:length(x)){
  if(x[i] %% 2 == 0) {
    result <- c(result, "ever")
  } else {
    result <- c(result, "odd")
  }
}
print(result)


## ifelse()
x
ifelse(x %%2 == 0, "even", "odd") ## -> for문 없이 한줄로 실행 가능!!(대박좋네)

naVec <- c(80, 65, 90, NA, 95, 80, NA, 100)
mean(naVec, na.rm=T)
is.na(naVec)

ifelse(is.na(naVec) == TRUE, mean(naVec, na.rm=T), naVec)






#### CSV파일 불러오기

testCSV <- read.csv(file.choose())
testCSV


### 이것저것 해보자...
num5 <- testCSV$q5
num6 <- ifelse(num5 >= 3, "bigger", "smaller")
num6


testCSV$q6 <- num6

table(testCSV$q6)
str(testCSV)


# q6 를 범주형 변수로변환하라
testCSV$q6 <- as.factor(testCSV$q6)
str(testCSV)
levels(testCSV$q6)




testCSV$q5
testCSV$q6
###  q6 별 q5의 합은??

#1. 
tapply(testCSV$q5, testCSV$q6, sum)

#2.
tmp_data<- testCSV %>% 
  group_by(q6) %>% 
  summarise(q5_sum = sum(q5))
as.data.frame(tmp_data)







################################################################################
########################## 너무 유용해 #########################################
#### which(벡터 == [찾고자 하는 값]) > 조건에 만족하는 index를 반환
x <- c(2, 3, 4, 5, 6, 7)
x

which(x==6)




# service_date_html_cont.csv

SD_data <- read.csv(file.choose())
SD_data
str(SD_data)
head(SD_data)


## Hawaii 주에 대한 행만 출력
SD_data[which(SD_data$State == "Hawaii"), ]





# for, if
# for(조건) {
# 
#
# } 

i <- 1:10

length(i)

for(idx in i) {
  if(idx %% 2 ==1){
    cat("idx ->", idx, "\n")
    }
}



### 문) 1 ~ 100까지 홀수 / 짝수 의 합을 출력하라.


# for, if 사용
even <- 0
odd <- 0
for(i in 1:100){
  if(i %% 2 ==0){
    even <- even + i
  } else {
    odd <- odd + i
  }
}

cat("짝수는 ", even, "홀수는 ", odd)


# for, if 사용 X
a <- 1:100
sum(a[a%%2==0])
sum(a[a%%2!=0])




##########################################문제
#############################################################################
### 다음 데이터를 이용하여 프레임을 만들어 serviceStu에 저장하라

subject.kor <- c(81, 95, 70)
subject.eng <- c(75, 88, 78)
subject.mat <- c(78, 99, 99)
name <- c("임정섭", "김정수", "최호진")

serviceStu <- data.frame(name, subject.kor, subject.eng, subject.mat)
serviceStu
str(serviceStu)


## 총점과 평균을 구해서 suvject.sum, subject.avg에 저장

serviceStu


# 1. 방법(1)
?apply
serviceStu_1 <- cbind(serviceStu, subject.sum = apply(serviceStu[2:4], 1, sum))
serviceStu_1 <- cbind(serviceStu_1, subject.avg = apply(serviceStu[2:4], 1, mean))
serviceStu_1
str(serviceStu)



# 2. 방법(2)

install.packages("dplyr")
library(dplyr)

serviceStu

tmp_serviceStu <- serviceStu %>% 
  mutate(subject.sum = subject.kor + subject.eng + subject.mat,
         subject.mean = (subject.kor + subject.eng + subject.mat)/3)

serviceStu_2 <- as.data.frame(tmp_serviceStu)



# 3. 방법(3)


serviceStu_3 <- within(serviceStu,
                       {
                         subject.avg <- (subject.kor + subject.eng + subject.mat) / 3
                         subject.sum <- subject.kor + subject.eng + subject.mat
                       }
                      )

serviceStu_3$subject.avg <- round(serviceStu_3$subject.avg, 2)


### 비교하기

serviceStu_1
serviceStu_2
serviceStu_3




####################################################
### 위문제에서 만든 serviceStu_3 테이블을 이용하여 subject.grade 칼럼을 추가하라


# 방법1

subject.grade <- c()

for(idx in 1:nrow(serviceStu_3)){
  if(serviceStu_3$subject.avg[idx] > 90) {
    subject.grade <- c(subject.grade, "A")
  } else if(serviceStu_3$subject.avg[idx] > 80) {
    subject.grade <- c(subject.grade, "B")
  } else if(serviceStu_3$subject.avg[idx] > 70) {
    subject.grade <- c(subject.grade, "C")
  } else if(serviceStu_3$subject.avg[idx] > 60) {
    subject.grade <- c(subject.grade, "D")
  } else {
    subject.grade <- c(subject.grade, "F")
  }
}

subject.grade

serviceStu_4 <- serviceStu_3
serviceStu_4$subject.grade <- subject.grade
serviceStu_4




# 방법2
serviceStu_5 <- serviceStu_3

serviceStu_5$subject.grade <- NA
serviceStu_5[which(serviceStu_5$subject.avg>90), ]$subject.grade <- "A" 
serviceStu_5[which(serviceStu_5$subject.avg<90 & serviceStu_5$subject.avg>80), ]$subject.grade <- "B" 
serviceStu_5[which(serviceStu_5$subject.avg<80 & serviceStu_5$subject.avg>70), ]$subject.grade <- "C" 
serviceStu_5[which(serviceStu_5$subject.avg<70 & serviceStu_5$subject.avg>60), ]$subject.grade <- "D" 
serviceStu_5[which(serviceStu_5$subject.avg<=60), ]$subject.grade <- "F" 



#### 비교하기
serviceStu_4
serviceStu_5














