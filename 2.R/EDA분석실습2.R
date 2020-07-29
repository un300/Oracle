## EDA 분석 실습02
# -----------------------------------------------(실습)

# 통닭집이 가장 많은 지역 찾기
# 서대문구에 통닭집이 많은 동을 시각화 해보자
install.packages("readxl")
library(readxl)
# data load : service_data_chicken_store_eda_visualization
ck <- read_xlsx(file.choose())
colnames(ck) <- c('address', 'name')


head(ck)
as_tibble(ck)

str(ck)


View(ck)

ck[,1]
#
install.packages("dplyr")
library(dplyr)
install.packages("stringr")
library(stringr)



# substr() 함수를 이용하여 소재지전체주소에 동만 가져오기
# 실행결과 동 이름이 3글자인 경우와 4글자인 경우가 있으므로 지정한 자리만큼
# 글자를 추출하면 3글자인 동은 숫자가 포함된다.
# 공백과 숫자를 제거하자
ck[933,1]

temp1 <- substr(ck$address, 12, 15)
dong <- str_extract(temp1, '[가-힇]+동')
dong[is.na(dong)] <- 'X'

ck$dong <- dong




as_tibble(ck)








# 동별 도수분포표 만들어보기
# table() 함수를 이용해서 숫자 세기, 변수가 한개일때 도수분표표를 만들어줌
# 도수분포표란 항목별 개수를 나타낸 것이다

table(dong)

ck_dong <- ck %>% 
  group_by(dong) %>% 
  summarise(cnt = n())

ck_dong





# 트리맵은 옵션으로 데이터 프레임을 입력받는다.
# treemap(데이터, index=구분 열 , vSize=분포 열 , vColor=컬러, title=제목)


install.packages("treemap")
library(treemap)

?treemap
treemap(data.frame(ck_dong), 
        index = "dong", 
        vSize = "cnt", 
        vColor = 'GNI',
        type = 'index',
        title = "배달 가즈아")






















