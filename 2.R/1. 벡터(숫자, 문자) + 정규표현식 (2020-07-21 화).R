
#패키지란? : 함수(function) + 데이터셋(dataset)

install.packages("car")
library(car)
install.packages("stringr")
library(stringr)

# 패키지가 설치된 경로를 볼때
# 만약 패키지 끼리 충돌이 일어날때
# 밑의 함수를 실행하면 경로가 나타나는데 
# 그 경로로 가서 충돌 되는 패키지를 삭제 ㄱㄱ
.libPaths()
### 또, 설치된 패키지 삭제하는 법
remove.packages("패키지이름!")



## 설치된 라이브러리를 확인할 때
library()


## 어떤 변수가 있는지 보고싶을때?
?letters



## 포함된 변수들의 이름이 무엇이 있는지 보고싶을때?
## ex : letters
print(letters)
letters
month.abb
month.name



######################################################################








# 디버깅용도함수 : print(), paste(), sprintf(), cat()
print("섭이와 함께하는 기초 R 실습")

#1. sprintf() : 자바나 C언어에서 사용하는 print와 같은방식
# %d : 정수값 출력
# %f : 실수값 츨력
# %s : 문자값 출력

sprintf("%d", 123)
sprintf("Number : %d", 100)
sprintf("Number : %d, String : %s", 100, 'jwlee')

sprintf("%.2f", 123/456)
sprintf("%5d", 123)
sprintf("%5d", 12345)
sprintf("%5d", 123456)   ## --> R에서는 자리수가 넘어가도 허용하더라 




#2. cat(), print()
# cat()은 '\n' 포함되어 있지 않음, print()는 '\n' 포함되어 있음
print('섭섭이')
print('네 이놈')

cat('섭섭이')
cat('네 이놈')

name <- 'jwlee'
name


## cat() 실습! 줄바꿈이 일어나지 않는다
myFunc_cat <- function() {
  total <- 0
  cat('append ... ')
  for(i in 1:10) {
    total <- total + i
    cat(i, '...')
  }
  cat('End!!', '\n')
  return(total)
}

myFunc_cat()


## print() 실습! 줄바꿈이 일어난다
myFunc_print <- function() {
  total <- 0
  print('append ... ')
  for(i in 1:10) {
    total <- total + i
    print(i)
  }
  print('End!!')
  return(total)
}

myFunc_print()






#############################################################################




##### 변수 >> 변수의 이름은 [알파벳, 숫자, _ , .]로 구성
#####         (단, 첫 글자는 반드시 문자 혹은 .로 시작해야한다.)

# 단일형 : vector, matrix, array > 데이터 타입이 동일한 것들만 포함
# >>> 숫자면 숫자만, 문자면 문자만!!
# 복수형 : list, data.frame > 여러형태의 데이터 타입을 포함!
# >>> 숫자, 문자, 범주,.. 등등 여러 형태의 데이터 타입이 포함


## vector > python에서는 vector를 list 타입으로 취급한다.
# c() : c함수 사용해서 벡터 만들기
# 1:10 : 열거식 사용해서 벡터 만들기


sample_vec <- c(1, 2, 3, 4, 5)
sample_vec

sum(sample_vec) / length(sample_vec)
mean(sample_vec)

## 변수의 데이터 타입을 확인할 수 있는 방법들...
class(sample_vec)
typeof(sample_vec)
mode(sample_vec)
str(sample_vec)  ## <- 이거 잘 알아 두세요! data.frame다룰때 많이사용

x <- 1:10
x
y <- x^2
y

plot(x, y)






boolean_vec <- c(TRUE, FALSE, TRUE, FALSE)
boolean_vec

str(boolean_vec)
class(boolean_vec)
typeof(boolean_vec)
mode(boolean_vec)





string_vec <- c('임정섭', '박수진', '임은결', '임재원')
string_vec


sample_NA <- NA   ## R에서는 결측값은 NA이다. NULL은 데이터로 취급해버림
sample_NA
is.na(sample_NA)


sample_NULL <- NULL
sample_NULL
is.null(sample_NULL)



over_vec <- c(1, 2, 3, c(4, 5, 6))
over_vec

## start : end
seq_vec <- 1:10
seq_vec


### rep() : 반복
rep(1:10, 5)  ## ->1:10을 5번 반복한다.
rep(1:10, each=5)   ## -> 각각 원소를 5번씩 반복한다.


### seq(from, to, by)
seq(1, 10)
seq(1, 10, 2)
seq(2 ,10, 2)
seq(1, 10, length.out = 3)    ## -> 1~10 사이의 값들 중에서 일정한 폭으로 3개의 값을 출력하라. 
seq(1, 10, length.out = 5)



seq_vec02 <- seq(1, 100, by=3)
seq_vec02
length(seq_vec02)

# indexing []
# 인덱싱에 조건식을 활용할 수 있다.(AND  &  =  ,  OR  |)



seq_vec02[5]
seq_vec02[length(seq_vec02)-4]


# 인덱스 번지가 30이하인 데이터만 출력하려면?
seq_vec02[1:30]

# 인덱스 번지가 10이상 30이하인 데이터만 출력 하려먼?
seq_vec02[10:30]


# 인덱스 번지가 10이상 이거나 30이하인 데이터만 출력하려면?
seq_vec02[10:length(seq_vec02) || 1:30]

# 인덱스 번지가 홀수인 데이터만 출력하려면?
seq_vec02[seq(1, length(seq_vec02), 2)]



# 데이터가 30이하인 데이터만 출력
seq_vec02[seq_vec02 <= 30]

# 데이터가 10이상이고 30이하인 데이터만 출력
seq_vec02[seq_vec02 >= 10 & seq_vec02 <=30]

# 데이터가 10이상이거나 30이하인 데이터만 출력
seq_vec02[seq_vec02 >= 10 | seq_vec02 <= 30]

# 데이터가 홀수인 데이터만 출력
# 나누기 : /
# 몫 : %/%
# 나머지 : %%
seq_vec02[seq_vec02%%2==1]





## round()
round_vc <- c(10.234, 11.3467)
round(round_vc)
round(round_vc, 2)
round(round_vc, -1)


round_vc02 <- 123.234
round(round_vc02, -1)


data_x <- c(1, 2, 3)
cols <- c('lim', 'park', 'cho')



## names() : 벡터의 각각의 셀에 이름을 할당하는 방법 
##            혹은, 각각 셀의 이름을확인하는 방법
names(data_x) <- cols
data_x

names(data_x)
data_x['lim']
data_x['lim', 'park']    ## -> 하나이상의 칼럼을 찾으려면 c() 사용해야함 안쓰면 오류!

data_x[c('lim', 'park')]
data_x[c('lim')]             ##그래서 하나의 칼럼을 찾아도 c()로 묶는것을 추천



# Vector Indexing : 다른언어와 다르게 인덱싱이 1부터 시작 함
# 벡터내의 데이터 접근 방법

index_vec <- c(1, 3, 5, 7, 9)
index_vec
index_vec[1]
index_vec[2]
index_vec[3]
index_vec[4]
index_vec[5]
index_vec[5:3]   ### -> 상황에 따라서는 뒤에서부터 찾아오는 경우도 있음
index_vec[length(index_vec):3]
index_vec[c(1, 3)]     ### -> 내가 원하는 인덱스의 값을 출력 c()꼭쓰자 잊지말라



### 특정요소만을 제외한다면..?
index_vec
index_vec[-1]

## 첫번째와 다섯번째를 제외하고 싶다
index_vec[c(-1, -5)]


# 길이
length(index_vec)
nrow(index_vec) 
NROW(index_vec)


## nrow, NROW의 차이는 무엇?





## %in% 연산자 : 벡터안에 값이 있나요?
bool <- 'a' %in% c('a', 'b', 'c')
bool




## R은 벡터를 집합으로 취급할 수 있음
## setdiff() : 차집합
## union() : 합집합
## intersect() : 교집합
setdiff(c('a', 'b', 'c'), c('a', 'b'))
union(c('a', 'b', 'c'), c('a', 'b'))
intersect(c('a', 'b', 'c'), c('a', 'b'))




## 집합간의 비교
## setequal() : 두집합이 같은지 비교하세요!

setequal(c('a', 'b', 'c'), c('a', 'b'))
setequal(c('a', 'b', 'c'), c('a', 'b', 'c'))



########################## 강사님 문제1)

# 100에서 200으로 구성된 벡터 sampleVec를 만든다음
# 각문제를 수행하는 코드를 작성하고 답을 구하시오!

sampleVec <- c(100:200)

# 문1) 10번째 값을 출력하시오
sampleVec[10]


# 문2) 끝에서 10개의 값을 잘라내어 출력하세요
sampleVec[ (length(sampleVec)-10):length(sampleVec) ]


# 문3) 홀수만 출력하세요
sampleVec[sampleVec%%2==1]


# 문4) 3의 배수만 출력하시오
sampleVec[sampleVec%%3==0]


# 문5) 앞에서 20개의 값을 잘라내고 sampleVec.head 변수에 저장하고 출력하세요
sampleVec.head <- sampleVec[1:20]


# 문6) sampleVec.head 변수에서 5번째 값을 출력
sampleVec.head[5]


# 문7) sampleVec.head 변수에서 5, 7, 9 번째 값을 제외하고 출력
sampleVec.head[c(-5, -7, -9)]





####################################강사님 문제2)


# 월별 결석생 수 통계가 다음과 같을때
# 이 자료를 absent 벡터에 저장하시오
# (결석생 수를 값으로 하고, 월 이름을 값의 이름으로 한다)


?month.name
month.name
absent <- c(10, 8, 14, 15, 9, 10, 15, 12, 9, 7, 8, 7)

names(absent) <- month.name
absent


# 문1) 5월(MAY)의 결석생 수를 출력하시오
absent['May']

# 문2) 7월(JUL), 9월(SEP)의 결석생 수를 출력하시오.
absent[c('July', 'September')]

# 문3) 상반기(1~6월)의 결석생 수의 합계를 출력하시오
sum(absent[c("January", "February", "March", "April", "May", "June")])

# 문4) 하반기(7~12월)의 결석생 수의 평균을 출력하시오.
mean(absent[c("July", "August", "September", "October", "November", "December")])









### 논리형벡터

c(T,F,TRUE, FALSE)

c(T,F,T) | c(TRUE,FALSE,TRUE)

!c(T, F, T)



xor( c(T, F, T, T), c(T, F, T, F) )  ## xor : 같으면 FALSE, 다르면 TRUE

randomNum <- runif(3, 0, 1)  ## runif : 0~1사이의 값을 랜덤하게 3개 뽑아내겠다
(0.25 <= randomNum) & (randomNum <= 0.75)


any(randomNum > 0.8)
all(randomNum < 0.8)

## 문자형벡터
c('a', 'b', 'c', 'd', 'e')
strVec <- c('H', 'S', 'T', 'N', 'O')

strVec[1] > strVec[5]
strVec[3] > strVec[5]


# V #
## paste()   :   여러문자들을 결합해서 리턴해주는 함수
paste("May I", "help you ?")
month.abb
paste(month.abb, 1:12)   # 오 개신기 ㅎㅎ
paste(month.abb, 1:12, c('st', 'nd', 'rd', rep('th', 9)))  ## 오 신기 ㅎㅎㅎㅎ

## paste() >> 중간중간 구분자 넣기 옵션 'sep='
paste("/usr", "local", "bin", sep ="/")
paste("/usr", "local", "bin", sep =" ")
paste("/usr", "local", "bin", sep ="")
paste("/usr", "local", "bin", sep ="^")
paste("/usr", "local", "bin", sep ="(구분자)")
paste("/usr", "local", "bin", sep ="(SEPERATED)")

(seqVec <- paste(1:4))
class(seqVec)


## paste() >> 만약 출력값이 하나의 문자열이 아니라 여러 문자열이라면?
##            'collapse='옵션을 이용하여 하나의 문자열로 합쳐 리턴할 수 있음
paste(seqVec)
paste(seqVec, collapse="")




#########중요해요############################################################
#############################################################################

## 정규표현식 함수
## grep(pattern, date, ignore.case, value)
?grep

grepValue <- c("gender", "name", "age", "height", "weight", "tall", "eight")
grepValue2 <- c("gender", "name", "age", "hEIght", "wEIght", "tall", "EIght")

# 문1) 'ei'로 시작되는 요소가 있는지

grep('^ei', grepValue)


# 문2) 'ei'문자열을 포함하는 요소가 있는지

grep('ei', grepValue)               # -> 조건을 만족하는 인덱스 출력!
grep('ei', grepValue, value=TRUE)   # -> 조건을 만족하는 값을 출력!


## 대소문자는 구분하나요..??

grep('ei', grepValue)
grep('ei', grepValue2)
grep('ei', grepValue, ignore.case=TRUE)  # ignore.case=T > 대소문자는 구분하지 않는 옵션입니다.




grepTxt <- c("Bigdata", "Bigdata", "bigdata", "Data", "dataMining", "textMining", "campus6", "campus5")
grepTxt



# 문3) b로 시작하는 하나이상의 문자 패턴을 확인하고 싶다면?
grep('^b+', grepTxt, value=TRUE)
grep('^b+', grepTxt, value=TRUE, ignore.case=TRUE)

##### gsub(pattern, replacement, data, ignore.case)
# 문자열에서 문자를 바꾸는 기능

# 문4) big라는 단어를 bigger 라는 단어로 바꾸고자 한다면??
grepTxt
gsub('big', 'bigger', grepTxt)
gsub('big', 'bigger', grepTxt, ignore.case=T)


# 문5) grepTxt에서 숫자를 제거하고자 한다면??

grep('[a-zA-Z]+', grepTxt, value=T, ignore.case=T)

gsub("[[:digit:]]", "", grepTxt)
gsub('[0-9]+', '', grepTxt)


gsub("[[:digit:]]", "", grepTxt)

##### sub() : gsub()이랑 동일한 인덱스이기때문에 똑같음
sub("[[:digit:]]+", "", grepTxt)
sub('[0-9]+', '', grepTxt)




##### nchar : 벡터의 각요소의 문자열 길이를 반환해준다.
grepTxt
nchar(grepTxt)
str_length(grepTxt)



################# 정규식 표현은 아니지만.. 한번 말씀드릴께요!
##### strsplit(data, split) : 문자열을 쪼개는 함수이다.

greetingMsg <- "Hi, Bigdata is very important"
strsplit(greetingMsg, ",")
strsplit(greetingMsg, " ")


class(greetingMsg)
class(strsplit(greetingMsg, " ")) ## -> 문자를 넣었지만... list가 반환됨!
                                  ## 그러므로 데이터분석시에는
                                  ## 습관적으로 데이터의 타입을 수시로 확인해야함!



##### substr(data, start, stop) : 원하는 문자열을 뽑아내는 함수

substr(greetingMsg, 5, 11)



##### str_extract("abc123def456", )


str_extract("abc123def456", "[0-9]{3}")
str_extract_all("abc123def456", "[0-9]{3}")

str_extract("abc123def456", "[a-z]{3}")
str_extract_all("abc123def456", "[a-zA-Z]{3}")













stringDumy <- "임정섭jslim48섭섭해seop34유관순임꺽정홍길동30"
stringDumy



str_extract_all(stringDumy, "[a-z]{3}")  ### 3자리만 뽑아줘!
str_extract_all(stringDumy, "[a-z]{3,}") ### 3자리 이상 뽑아줘!
str_extract_all(stringDumy, "[a-z]{3,5}")


# 문) 연속된 한글 3자이상 추출
seqName <- str_extract_all(stringDumy, "[가-힣]{3}")
seqName
str(seqName)


# 문) 나이추출
seqAge <- str_extract_all(stringDumy, "[0-9]{2}")
seqAge
str(seqAge)


# 문) 숫제를 제외
escapeNum <- str_extract_all(stringDumy, "[^0-9]{3,}+")
escapeNum
str(escapeNum)


# 문) 한글이름 추출 (영문자제외)
name <- str_extract_all(escapeNum[[1]], "[가-힣]+")
name[[1]]


name_temp <- str_extract_all(name[[3]], "[가-힣]{3}")
name_list <- c(name[[1]], name[[2]], name_temp[[1]])
name_list
paste(name_list, sep=T)





#### 단어와 숫자에 관련된 메타문자
#### 단어(work) : \\w   >>>   영문자, 숫자, 한글, 특수문자 전부 포함!!!
#### 숫자(digit) : \\d
#### 엔터키, 탭키 : \n, \t


ssn <- "730910-1234567"
ssn

str_extract_all(ssn, "[0-9]{6}-[0-9][0-9]{6}")
str_extract_all(ssn, "\\d{6}-[1-4]\\d{6}")  # -> 위 정규식을 이렇게 표현할 수도 있음




ssn2 <- "730910-123456x"
ssn2

str_extract_all(ssn2, "[0-9]{6}-[0-9][0-9]{6}")  # -> 정규표헌식중 하나만 안맞아도..!
                                                #    추출할 수 없음!





email <- "lan4148@naver.com"

str_extract_all(email, "\\w{7,}@[a-z]{3,}.[a-z]{2,}")


email2 <- "lan4148@naver"
str_extract_all(email2, "\\w{7,}@[a-z]{3,}.[a-z]{2,}")  ## -> 조건에 만족하지 않으니 출력되지 않는다!



############ 문자열의 길이!!
## 그냥 length쓰면 안댄다!!!  >>  length는 데이터의 개수를 반환함
## str_length 써야한다!!


stringLength <- "우리는 달려간다~ 이상한 나라로~ 섭섭이가 잡혀있는 마왕의 소굴로"
length(stringLength)
str_length(stringLength)



# 문자열 위치
str_l <- str_locate_all(stringLength, '섭섭')
class(str_l)




#### 특수문자 제외
num <- "$123,466"
temp <- str_replace_all(num, "\\$|\\," , "")
class(temp)



### 형변환
# as.numeric(변수이름)
as.numeric(temp) + 2

# as.character(변수이름)


