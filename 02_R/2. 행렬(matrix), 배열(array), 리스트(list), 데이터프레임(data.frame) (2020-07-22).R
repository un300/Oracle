

#######
#######
#######
#######    행렬

## 행렬(matrix)
## row와 column에 상관 없이 단일유형의 데이터 타입만을 넣어야함
## matrix(), rnind(), cbind()

## apply(data, margin, function)




x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
mat <- matrix(x)
class(mat)


matrix(x, nrow=3)   ## row가 3인 매트릭스를 만들어라
matrix(x, ncol=3)   ## col이 3인 매트릭스를 만들어라
### >>> 데이터가 들어가는 기준은 열방향으로 차례대로 넣습니다.

###  데이터를 행방향으로 넣고 싶다면??
matrix(x, nrow=3, ncol=3, byrow=T)    ### byrow=T 옵션을 넣습니다!!








###  데이터 원소가 0인 행렬을 만들고 싶을때!
matrix(0, nrow=2, ncol=3)

matD <- diag(0, 3)
matD

class(matD)









x <- matrix(c(1, 2, 3, 4, 5, 6), 2, 3)
x

## 전치행렬 : 행과 열을 바꿉니다.
t(x)


## 데이터 접근 (   행렬이름[행 인덱스, 열 인덱스]   )
x <- matrix(x, 3, 3)    ### 행렬을 만들다가 들어갈 요소가 부족하다면??
                        ### 다시 맨처음 데이터부터 넣기 시작한다

row(x)   ##  ->   데이터 값들이 row의 인덱스로 변경된다.
col(x)   ##  ->   데이터 값들이 col의 인덱스로 변경된다.



x[1, 1]
x[3, 3]

## 1행 2행 그리고 2열에 있는 모든 데이터를 출력하라.
x[1:2, 2]
tmp <- x[c(1, 2), 2]
tmp
class(tmp)



## 1행과 2행에 있는 모든 데이터를 출력하라
x[1:2, ]
tmp <- x[-3, ]
class(tmp)




## 1행을 제외하고 1열과 3열에 있는 데이터를 출력하라 (논리벡터를 이용하라)
x[c(FALSE, TRUE, TRUE), c(TRUE, FALSE, TRUE)]


## 1열과 3열을 제외한 행렬을 인덱싱 해보자
x
x[ , 2]

tmp <- x[ , -c(1, 3)]
class(tmp)





#### 벡터를 사용하여 행렬만들기 rbind() / cbind()


x1 <- c(1, 2, 3)
x2 <- c(4, 5, 6)

# rbind()  :  행을 기준으로 데이터를 입력
tmpMatrix <- rbind(x1, x2)
tmpMatrix

tmpMatrix3 <- rbind(1:3, c(4, 5, 6), 7:9)
tmpMatrix3



# cbind()  :  열을 기준으로 데이터를 입력
tmpMatrix2 <- cbind(x1, x2)
tmpMatrix2









## matrix() 함수에 dimnames 옵션을 활용하면 행이름, 열이름을 지정할 수 있고
## 이를 활용하여 인덱싱이 가능하다.

## dimnames = (c(행이름1, 행이름2, ...),
##             c(열이름1, 열이름2, ....)
##             )


nameMatrix <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9),
                     nrow = 3, 
                     dimnames = list(c("idx1", "idx2", "idx3"),
                                     c("feature1", "feature2", "feature3")
                                     )
                     )

nameMatrix

nameMatrix["idx1", "feature3"]
nameMatrix["idx3", "feature2"]
nameMatrix["idx2", "feature2"]
nameMatrix[-2, -2]









## 행렬 연산!  :  아주 가능합니다 ㅎ

nameMatrix * 2
nameMatrix / 2
nameMatrix + 2
nameMatrix - 2
nameMatrix ^ 2



## apply(data, margin(함수가적용될 방향 : 열이냐 행이냐), function)
##             margin = 1    >    row
##             margin = 2    >    col
##             margin = c(1, 2)   >   3차원 이상의 배열일때 각 면의 같은 행 같은 열에 있는 데이터들에 
##                                    function을 적용하라

x <- matrix(1:4, nrow=2, dimnames=list(c("r1", "r2"), c("f1", "f2")))
x


# 열의 합
apply(x, 2, sum)
apply(x, 2, mean)
apply(x, 2, max)
apply(x, 2, min)

# 행의 합
apply(x, 1, sum)
apply(x, 1, mean)
apply(x, 1, max)
apply(x, 1, min)



################################################################################
install.packages("dplyr")
library(dplyr)

### iris 불러오기
iris
str(iris)
head(iris)
tail(iris)



sum(is.na(iris$Sepal.Length))
sum(is.na(iris$Sepal.Width))
sum(is.na(iris$Petal.Length))
sum(is.na(iris$Petal.Width))
sum(is.na(iris$Species))



## apply() 함수를 적용해서 칼럼의 요약정보를 확인해보세요
apply(iris[ , -5], 2, summary)
apply(iris[ , -5], 2, sum)
apply(iris[ , -5], 2, mean)



## 특정 행 또는 열을 기준으로 정렬
## oreder()

(x <- matrix(runif(4), 2, 2))
order(x[,2])   #### x 행렬의 2번째 열을 오름차순으로 정렬한 인덱스를 반환해준다.
x[order(x[,2]), ]


(x <- matrix(runif(4)))
x[order(x[,1], decreasing = T), ]





### dplyr
Species_summary <- iris %>% 
  group_by(Species) %>% 
  summarise(mean_Sepal.Length = mean(Sepal.Length), 
            mean_Sepal.Width = mean(Sepal.Width),
            mean_Petal.Lenth = mean(Petal.Length),
            mean_Petal.Width = mean(Petal.Width),
            n = n()
            )

Species_summary








#######
#######
#######
#######     배열


## 베열(Array)
## array(), dim()

m <- matrix(1:12, ncol = 4)
m
class(m)

arr_tmp <- array(1:12, dim = c(3, 4))
arr_tmp
class(arr_tmp)             ### -> 2차원으로 Array를 만들면 "matrix" 데이터타입임

arr <- array(1:12, dim = c(3, 4, 3))   ### -> 3차원으로 Array를 만들면 확실하게 "Array" 데이터 타입임
arr
class(arr)


# 배열에 대한 접근
# 행렬과 유사한 방식으로 각 요소에 접근할 수 있다.

arr
arr[1, 2, 3]
arr[3, 3, 3]
arr[3, 4, 3]



## 배열 apply()
arrD <- array(1:16, dim = c(2, 4, 2))
arrD

arrD
apply(arrD, c(1, 2), mean)   ## c(1, 2) -> 3차원 이상의 배열에서 각각의 면에 같은 행열에 있는 데이터들을 기준으로 한다.



apply(iris3, 1, mean)
apply(iris3, 2, mean)
apply(iris3, 3, mean)

apply(iris3, c(1, 2), mean)






#######
#######
#######
#######     리스트(List)


## 리스트(list)
## (키, 값)형태의 데이터를 담는 연관배열이다.


## unlist()  :  리스트를 벡터로 반환하는 함수
## lapply()  :  키와 벨류를 같이 반환하는 apply함수 
## sapply()  :  키는 제외하고 벨류만 반환하는 apply함수

exList <- list(name = "jslim", height = 177)
exList$name
exList$height


exList2 <- list(name = "jslim", height = c(1, 3, 5))
exList2$name
exList2$height

 
simpleList <- list(1:4, rep(3:5), "cat")      ## 필요에 따라서는 키값을 생략할 수 있다.
simpleList


newlist <- c(list(1, 2, simpleList), c(3, 4))
newlist


### 리스트 안에 리스트 중첩

List1 <- list(a = list( c(1, 2, 3) ),
              b = list( c(1, 2, 3, 4) )
              )

# 문) 리스트 List1 안의 리스트인 a와 b가 있을때, a의 2와 b의 3을 출력하라

List1
List1$a[[1]][2]
List1$b[[1]][3]

List1[[1]][[1]][2]
List1[[2]][[1]][3]





member <- list(
  name    = "jslim",
  address = "seoul",
  tel     = "010-4603-2283",
  age     = 48,
  married = T
)

member$name
class(member$name)

member$addres
class(member$address)

member$tel
class(member$tel)

member$age
class(member$age)

member$married
class(member$married)






member2 <- list(
  name    = c("섭섭해", "임섭순"),
  address = c("seoul", "gwangju"),
  age     = c(48, 29),
  gender  = c("남자", "여자")
)


member2$name
member2$address
member2$age
member2$gender
member2$id <- c("lan4148", "un300")

member2$age[1] <- 38
member2$age

member2$address[2] <- "deagu"
member2$address

member2




## 서로다른 자료구조(vector, matrix, array)

multiList <- list(
  one      = c("one", "two", "three"),
  second   = matrix(1:9, nrow=3),
  third    = array(1:12, dim=c(2, 3, 2))
)



multiList$one
multiList$one[1]
multiList$one[3]
multiList$second[1, 2]
multiList$third[1, 2, 2]
multiList$third[ , , 2]

multiList$third


#### unlist : list -> vector
x <- list(1:5)
x
class(x)

vec <- unlist(x)
vec
str(vec)

matrixList <- list(
  row1 = list(1, 2, 3),
  row2 = list(10, 20, 30),
  row3 = list(100, 200, 300)
)

class(matrixList)


# do.call(func, data)
matrixList

row_mat <- do.call(rbind, matrixList)
row_mat

col_mat <- do.call(cbind, matrixList)
col_mat



### list의 길이!! length(list)
listLength <- list(1:5, list("This is Mt First time R", c(T, F, T)))

listLength
length(listLength)

listLength[[1]]
length(listLength[[1]])

listLength[[2]]
length(listLength[[2]])



## 문자열 길이
nchar(listLength[[2]][[1]])

library(stringr)
str_length(listLength[[2]][[1]])



## list 처리함수
## lapply() : list, key=value
## sapply() : list, value

x <- list(1:5)
y <- list(6:10)

lapply(c(x, y), FUN = sum)  ## -> 키와 벨류를 같이 리턴 : list 리턴
sapply(c(x, y), FUN = sum)  ## -> 벨류만 리턴 : vector 리턴


lapply(c(x, y), FUN = max)
lapply(c(x, y), FUN = min)

sapply(c(x, y), FUN = max)
sapply(c(x, y), FUN = min)


###########################################################################
###list를 data.frame으로 만드는법!!
## 1. list를 unlist()를 사용하여 vector로 만들고..
## 2. 만들어진 벡터를 Array로 만든다
## 3. Array를 data.frame으로 변환한 후
## 4. feature이름을 바꾸고 범주이름을 넣는등 조정을 한다.


iris



## iris data.frame 을 list로 만드는 작업
exerciseList <- list("꽃받침 길이" = iris$Sepal.Length, 
                     "꽃받침 넓이" = iris$Sepal.Width, 
                     "꽃잎 길이" = iris$Petal.Length, 
                     "꽃잎 넓이" = iris$Petal.Width, 
                     "꽃의 종류" = iris$Species
                     )
exerciseList



## 문) unlist() 사용하여 리스트를 벡터로 반환
exerciseVector <- unlist(exerciseList)
exerciseVector



## 문) matrix() 사용하여 벡터를 행렬로 변환
exerciseMatrix<- matrix(exerciseVector,
       ncol=5, 
       byrow=F
       )
exerciseMatrix



## 문) as.data.frame() 행렬을 데이터 프레임으로 변환
##      names() 사용해서 리스트로부터 변수명을 얻어와 대이터 프레임의 각 열에 이름 부여
exerciseDataFrame <- as.data.frame(exerciseMatrix)
names(exerciseDataFrame) <- names(exerciseList)
exerciseDataFrame

exerciseDataFrame$`꽃의 종류`[exerciseDataFrame$`꽃의 종류` == "1"] <- "serosa"
exerciseDataFrame$`꽃의 종류`[exerciseDataFrame$`꽃의 종류` == "2"] <- "versicolor"
exerciseDataFrame$`꽃의 종류`[exerciseDataFrame$`꽃의 종류` == "3"] <- "virginica"

exerciseDataFrame$`꽃의 종류` <- as.factor(exerciseDataFrame$`꽃의 종류`)
exerciseDataFrame
str(exerciseDataFrame)




##############################위 과정을 한줄로 할 수 있는 방법..
OneLine <- data.frame(do.call(cbind, exerciseList))
OneLine$꽃의.종류 <- as.factor(OneLine$꽃의.종류)
str(OneLine)











##########
##########
##########
##########    데이터프레임(Data.Frame)



## data.frame
## 행렬과 비슷하다
## 다만, 다양한 변수(관측값이 숫자, 문자, 범주 등)으로 표현된다.
## 각 열에 대한 접든은 $이용하여 접근한다.
## 인덱스를 활용하는 방법도 있다.




x <- c(1, 3, 5, 7, 9)
y <- c(2, 4, 6, 8, 10)

exampleDF <- data.frame(x, y)
exampleDF

str(exampleDF)


exampleDF[1,]
exampleDF[-1, ]
exampleDF[, c('x')]




exampleDF

# colnames(), rownames()
# rownames()는 거의 쓸일이 없을 꺼임
# colnames()

colnames(exampleDF) <- c("val01", "val02")
colist <- names(exampleDF)
colist
class(colist)






###### 문자열 벡터, 숫자형 벡터, 문자열 벡터
###### data.frame

stuName       <- c("조동균", "한소연", "박수진", "최가은")
subject.eng   <- c(100, 100, 100, 70)
subject.math  <- c(80, 75, 100, 100)
subject.kor   <- c(100, 100, 100, 100)
score.grade   <- c("A", "B", "A", "c") 

?data.frame

DataFrame <- data.frame(stuName, subject.eng, subject.math, subject.kor, score.grade)
DataFrame
colnames(DataFrame) <- c("이름", "영어", "수학", "국어", "학점")
DataFrame
str(DataFrame)




### 행의개수
nrow(DataFrame)


##  nrow와 NROW의 차이점!!
##  : 벡터의 경우는 nrow사용하면 NULL 값이 나옴
##    그런 벡터를 위해 NROW 사용
a <- c(1, 2, 3, 4, 5)
nrow(a)
NROW(a)



#### DataFrame 데이터에 "학번"을 추가해 보세요~

##  첫번째 방법 : 원본을 없애는 방법
DataFrame2 <- DataFrame
DataFrame2$"학번" <- c("2014024025", "2014024026", "21311952", "200000000")
DataFrame2
str(DataFrame2)

##  두번째 방법 : 원본을 두는 방법
전화번호 <- c("010-1111-2222", "123456789123", "00524-253156", "05812")
DataFrame3 <- cbind(DataFrame2, 전화번호)
DataFrame3
str(DataFrame3)


###  새롭게 만든 데이터 프레임이 잘못 될 가능성이 농후하기에..
###  원본을 없애지 않는 두번째 방법이 더욱 권장된다!







### 더미 데이터를 이용해서 행 추가!!
DataFrame4 <- rbind(DataFrame3, list('김개똥', 60, 50, 10, 'F', '2805416123',  '010-2905-2833'))
str(DataFrame4)


########## 주의점!!
### data.frame에 rbind를 사용하여 행을 추가할때... list를 사용하자
### vector인 c(..) 를 사용하면 제일 앞에 있는 데이터 타입의 형태로 입력된다.
### 만약 제일 앞에 있는 데이터 타입이 문자열이라면...
### 뒤에 숫자 데이터 타입도 문자 데이터 타입으로 바뀐다!
DataFrame5 <- rbind(DataFrame3, c('김개똥', 60, 50, 10, 'F', '2805416123',  '010-2905-2833'))
str(DataFrame5)  ## <- 숫자타입 데이터가 문자 타입으로 바뀜

#####  위 c() 벡터로 행을 추가한 경우르 가지고 형변환을 해보자
DataFrame5$영어 <- as.numeric(DataFrame5$영어)
DataFrame5$수학 <- as.numeric(DataFrame5$수학)
DataFrame5$국어 <- as.numeric(DataFrame5$국어)
str(DataFrame5)   #### 숫자타입으로 변경된 것을 볼 수 있다.










############# with(),  within()


iris


## with(data, expression) : 값을 확인하는 용도
mean(iris$Sepal.Length)
mean(iris$Sepal.Width)



with(
  iris,
  {
    print(mean(Sepal.Length))
    print(mean(Sepal.Width))
  }
)             ####   -> $기호를 쓰지않고 사용할 수 있음!


 


## widthin(data, expression) : 값을 확인하고 반환하는 용도



x <- data.frame(val = c(1, 2, 3, 4, NA, 5, NA))
within(
  x,
  {
    val <- ifelse(is.na(val), mean(val, na.rm = T), val) 
  }
)








































