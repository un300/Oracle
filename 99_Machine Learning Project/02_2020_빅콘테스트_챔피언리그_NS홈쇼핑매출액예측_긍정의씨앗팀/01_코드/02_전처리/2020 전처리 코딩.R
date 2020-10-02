{
  if(!require(readxl)){install.packages("readxl"); library(readxl)}
  if(!require(dplyr)){install.packages("dplyr"); library(dplyr)}
  if(!require(ggplot2)){install.packages("ggplot2"); library(ggplot2)}
  if(!require(stringr)){install.packages("stringr"); library(stringr)}
  if(!require(tm)){install.packages("tm"); library(tm)}
  if(!require(lubridate)){install.packages("lubridate"); library(lubridate)}
  if(!require(rcompanion)){install.packages("rcompanion"); library(rcompanion)}
  if(!require(MASS)){install.packages("MASS"); library(MASS)}
  if(!require(reshape2)){install.packages("reshape2"); library(reshape2)}
} 

# 원본 train
train_rawdata <- read_xlsx('C:\\Users\\lan41\\Desktop\\2020빅콘테스트\\2020-09-26 전처리정리\\raw_data\\01_제공데이터\\homeShopping.xlsx',skip=1)
# 원본 test
test_rawdata <- read_xlsx('C:\\Users\\lan41\\Desktop\\2020빅콘테스트\\2020-09-26 전처리정리\\raw_data\\02_평가데이터\\2020 빅콘테스트 데이터분석분야-챔피언리그_2020년 6월 판매실적예측데이터(평가데이터).XLSX',skip=1)
str(train_rawdata) #(38309,8)
str(test_rawdata) #(2891,8)


#### train과 test셋 합치기
rawdata <- as.data.frame(rbind(train_rawdata, test_rawdata)); str(rawdata) #(41200,8)
d1 <- rawdata


#### train과 test셋 합쳐서 전처리

#### 원데이터 탐색으로 인한 변수 탐색 및 생성 

# 1. 노출(분)

# 노출(분) 결측치 17895개
table(is.na(d1$'노출(분)'))
# 노출(분) 결측치 처리
for (i in 2:nrow(d1)) {
  if (is.na(d1$`노출(분)`[i])) {
    d1$`노출(분)`[i] = d1$`노출(분)`[i-1]
  }
}
d1$`노출(분)` <- round(d1$`노출(분)`,3)


# 2. 방송일시

# 월, 일, 요일 변수 생성
d1$월 <- month(d1$방송일시)
d1$일 <- day(d1$방송일시)
d1$요일 <- weekdays(d1$방송일시)

# 상/하반기, 분기, 365일별, 53주차 단위 변수 생성
d1$반기 <- semester(d1$방송일시)
d1$분기 <- quarters(d1$방송일시)
d1$'365일' <- yday(d1$방송일시)
d1$'53주차' <- week(d1$방송일시)


# 날짜시간, 시간, 계절, 일주일을 168시간 변수 생성
방송일시_split <- strsplit(as.character(d1$방송일시),' ')
for (i in 1:nrow(d1)) {
  
  d1$년월일[i] <- 방송일시_split[[i]][1]
  d1$시간[i] <- 방송일시_split[[i]][2]
  d1$시간hour[i] <- substr(d1$시간[i],1,2) 
  d1$날짜[i] <- str_replace_all(방송일시_split[[i]][1],'-','')
  d1$날짜시간[i] = str_c(d1$날짜[i],d1$시간hour[i])
  
  if (d1$월[i]==3 | d1$월[i]==4 | d1$월[i]==5) {
    d1$계절[i] <- '봄'
  } else if (d1$월[i]==6 | d1$월[i]==7 | d1$월[i]==8) {
    d1$계절[i] <- '여름'
  } else if (d1$월[i]==9 | d1$월[i]==10 | d1$월[i]==11) {
    d1$계절[i] <- '가을'
  } else {
    d1$계절[i] <- '겨울'
  }
  
  if (d1$요일[i]=='월요일') {
    d1$`168시간`[i] <- (0*24)+as.integer(d1$시간hour[i])+1
  } else if (d1$요일[i]=='화요일') {
    d1$`168시간`[i] <- (1*24)+as.integer(d1$시간hour[i])+1
  } else if(d1$요일[i]=='수요일') {
    d1$`168시간`[i] <- (2*24)+as.integer(d1$시간hour[i])+1
  } else if(d1$요일[i]=='목요일') {
    d1$`168시간`[i] <- (3*24)+as.integer(d1$시간hour[i])+1
  } else if(d1$요일[i]=='금요일') {
    d1$`168시간`[i] <- (4*24)+as.integer(d1$시간hour[i])+1
  } else if(d1$요일[i]=='토요일') {
    d1$`168시간`[i] <- (5*24)+as.integer(d1$시간hour[i])+1
  } else {
    d1$`168시간`[i] <- (6*24)+as.integer(d1$시간hour[i])+1
  }
}

# 휴일 변수 생성
species1 <- c('0101','0301','0505','0512','0606','0815','1003','1009','1225')
for (i in 1:nrow(d1)) {
  if (d1$요일[i]=='토요일' | d1$요일[i] == '일요일' | substr(d1$날짜시간[i],5,8) %in% species1) {
    d1$휴일[i] <- 1
  } else {
    d1$휴일[i] <- 0
  }
}


# 방송시간 변수 전처리, 매진 변수 생성
d2 <- d1
for (i in 1:nrow(d2)) {
  d2$방송시간[i] = round(difftime(d2$방송일시[i+1],d2$방송일시[i]),3)
}
for (i in (nrow(d2)-1):1) {
  if (d2$방송시간[i]==0) {
    d2$방송시간[i] = d2$방송시간[i+1]
  }
}
table(d2$방송시간) #15type

# 방송시간 이상치 처리
# 1) 방송시간 1:30:00~02:10:00 노출을 따르게한다
d2[d2$시간 == '01:30:00',]$방송시간 <- d2[d2$시간 == '01:30:00',]$'노출(분)'
d2[d2$시간 == '01:40:00',]$방송시간 <- d2[d2$시간 == '01:40:00',]$'노출(분)'
d2[d2$시간 == '01:50:00',]$방송시간 <- d2[d2$시간 == '01:50:00',]$'노출(분)'
d2[d2$시간 == '02:00:00',]$방송시간 <- d2[d2$시간 == '02:00:00',]$'노출(분)'
d2[d2$시간 == '02:10:00',]$방송시간 <- d2[d2$시간 == '02:10:00',]$'노출(분)'
# 2) 방송시간 1 => 60
index2 <- d2[d2$방송시간==1,] %>% na.omit() %>% rownames(); index2 <- as.integer(index2)
d2[index2,]$방송시간<- 20
# 3) 방송시간 1.333 => 20
index3 <- d2[d2$방송시간==1.333,] %>% na.omit() %>% rownames(); index3 <- as.integer(index3)
d2[index3,]$방송시간<- 20
# 4) 방송시간 40,50 이면서 토요일 노출을 따르게한다
d2[d2$방송시간==40 & d2$요일=='토요일',]$방송시간 <- d2[d2$방송시간==40 & d2$요일=='토요일',]$'노출(분)'
d2[d2$방송시간==50 & d2$요일=='토요일',]$방송시간 <- d2[d2$방송시간==50 & d2$요일=='토요일',]$'노출(분)'

# 매진변수 생성 (방송시간>노출)
table(d2[d2$방송시간 > d2$'노출(분)',]$방송시간)
d2$매진여부 <- ifelse(d2$방송시간 > d2$'노출(분)', 1, 0)

# 방송끝나는시간변수 생성
d2$방송끝나는시간 <- d2$방송일시 + dminutes(d2$방송시간)


# 3. 상품명

d3 <- d2

# 상품명 브랜드 변수 생성
d3$브랜드 <- str_extract(d3$상품명,
                      paste(c(
                        #가구
                        '삼익가구','한샘','보루네오','이누스바스','장수','이조농방','벨라홈','레스토닉','유캐슬',
                        #가전
                        '딤채','LG','대우전자','삼성','캐리어',
                        #건강기능
                        '광동','뉴트리원','닥터','종근당','블랙모어스','안국','경남제약','네페르티티','티젠','한삼인','베지밀','제주농장','이롬','이경제',
                        #생활용품
                        '한솔','일월','월시스','중외신약','보국','센티멘탈','스윙','LG생활건강','엔웰스','세렌셉템버','벨라홈','굿프렌드','바로톡',
                        '김병만의 정글피싱','까사마루','노비타','노송가구','대웅모닝컴','도루코','모리츠','자미코코','타이거','니봇','밀레','숀리','메디쉴드',
                        '메디컬드림','밸런스파워','브람스','선일','코지마','바두기','바로바로','발렌티노루','뚜러킹','블루콤','사운드룩','센스톰','수련',
                        '스위스밀리터리','스칸디나비아','스팀큐','스피드랙','씨엔지코리아','엑사이더','올바로','이지스','센스하우스','히팅맘','캐치온','코이모',
                        '코튼데이','퀸메이드','크린조이','킹스스파','테팔','트라이','파로마','페르소나','한일','신일','에브리밍','아룬싸왓','에레키반','에브리빙','프리모',
                        #속옷
                        '크로커다일','헤드','푸마','라쉬반','오모떼','LSX','댄스킨','란체티','레이프릴','로베르타','루시헨느','리복','몬테밀라노','발레리',
                        '벨레즈온','남영비비안','헤스떼벨','뷰티플렉스','실크트리','실크플러스','아키','에버라스트','오가닉뷰티','오렐리안','저스트마이사이즈',
                        '카파','컬럼비아','코몽트','쿠미투니카','히트융','자연감성',
                        #의류
                        'EXR','K-SWISS','디즈니','유리진','페플럼제이','헤스티지','USPA','마리노블','CERINI by PAT','NNF','그렉노먼','대동모피','더블유베일',
                        '도네이','디베이지','라라쎄','레드캠프','로이몬스터','르까프','릴리젼','마담팰리스','마르엘라로사티','뱅뱅','보코','스텔라테일러',
                        '스튜디오럭스','아리스토우','아문센','아주아','어반시크릿','에르나벨','엔셀라두스','이동수골프','임페리얼','젠트웰','코몽트','코펜하겐럭스',
                        '타운젠트','팜스프링스','헤비추얼','디키즈','알렉스하운드','크리스티나앤코','테이트','오렐리안','마모트',
                        #이미용
                        '엘렌실라','보닌','AHC','TS샴푸','네오젠','뉴웨이','달바','더블모','라라츄','마리끌레르','메디앤서','미바','바바코코','블링썸',
                        '비버리힐스폴로클럽','스칼프솔루션','스포메틱스','시크릿 라메종','시크릿뮤즈','실크테라피','아미니','아이앤아이','에이온에이',
                        '에이유플러스','엘로엘','자올','참존','컨시크','코튼플러스','파시노',
                        #잡화
                        '안드레아바나','DIOR','RYN','가이거','루이띠에','생쥴랑','플로쥬','기라로쉬','로베르타 디 까메리노','엘리자베스아덴','AAA','AAD','갈란테',
                        '골드파일','구찌','도스문도스','레노마','레코바','마스케라','마이클코어스','메디아글램','메이듀','바치','버버리','삭루츠','세인트스코트',
                        '스프리스','시스마르스','썸덱스','아가타','아르테사노','알비에로 마르티니','에버라스트 제니스','에트로','에펨','오델로','월드컵','제옥스',
                        '칼리베이직','코치','트레스패스','프라다','엘르',
                        #주방
                        '쿠쿠','쿠첸','라니 퍼니쿡','올리고','세라맥스','글라스락','am마카롱','오슬로','구스터','노와','클레린','뉴욕맘','델첸','두꺼비','락앤락',
                        '램프쿡','로벤탈','린나이','모즈','PN풍년','도깨비','리큅','마이베비','매직쉐프','센스락','홈쿠','비앙코','스위스밀리터리','실리만','쓰임',
                        '아이넥스','아이오','에버홈','에지리','에코라믹','에코바이런','오스터','드럼쿡','쿠진','클란츠','키친플라워','파뷔에','테팔','프로피쿡',
                        '하우홈','휴롬','세균싹','셀렉프로','멀티핸즈','실바트','안타고','에델코첸','옥샘쿡','이지엔','해피콜','키친아트','벨라홈','한샘','한일',
                        '송도순','베스트','PN','믹서를 품은 텀블러',
                        #침구
                        '한샘','리앤','보몽드','안지','한빛','효재',
                        #농수축
                        #1) 유명 농수축 브랜드
                        '농협','바다원','본죽','수협','슬로푸드','영광군수협','삼립','청정수산',
                        '피시원','하림','바다먹자','소들녘','천연담아','현대어찬',
                        #2) 사람이름 들어간 브랜드
                        '팽현숙','전철우','강레오','김선영','김정문','김정배','깐깐송도순','김규흔','이봉원',
                        '오세득','유귀열','이경제','이만기','이보은','이정섭','임성근','천수봉','최인선'),
                        collapse='|'))
d3[grep('클라쎄', d3$상품명), ]$브랜드 <- '대우전자'
d3[grep('모나코사놀', d3$상품명), ]$브랜드 <- '뉴트리원'
d3[grep('BBC', d3$상품명), ]$브랜드 <- '남영비비안'
d3[grep('생줄랑', d3$상품명), ]$브랜드 <- '생쥴랑'
d3$브랜드 <- ifelse(is.na(d3$브랜드), d3$마더코드, d3$브랜드)


# 상품명 sale단어 노출 여부 변수 생성
d3$sale단어 <- ''
d3[grep('초특가|파격가|가격인하|삼성카드|세일|할인' , d3$상품명), ]$sale단어 <- 1
d3[d3$sale단어=='',]$sale단어 <- 0


# 상품명 결제1/결제2_일시불/결제2_무이자 변수 생성
d3$결제수단 <- ''
d3[grep('무)|무이자' , d3$상품명), ]$결제수단 <- '결제2_무이자'
d3[grep('일)|일시불' , d3$상품명), ]$결제수단 <- '결제2_일시불'
d3[d3$결제수단=='',]$결제수단 <- '결제1'

# 상품명 결제수단 무시하고 방송시간별 판매상품수 count 변수 생성
d3$상품명change <- d3$상품명
d3$상품명change <- str_replace_all(d3$상품명change,'무이자','')
d3$상품명change <- str_replace_all(d3$상품명change,'일시불','')
d3$상품명change[grep('무)' , d3$상품명)] <- str_replace_all(d3[grep('무)' , d3$상품명),]$상품명,'무','')
d3$상품명change[grep('일)' , d3$상품명)] <- str_replace_all(d3[grep('일)' , d3$상품명),]$상품명,'일','')

d3_c1 <- d3 %>% dplyr::select(방송일시, 상품명change) %>% unique() %>% group_by(방송일시) %>% summarise(count=n())
d3 <- left_join(d3, d3_c1)


# 4. 중분류,소분류

d4 <- d3
category <- as.data.frame(read_xlsx('C:\\Users\\lan41\\Desktop\\2020빅콘테스트\\2020-09-26 전처리정리\\raw_data\\외부데이터\\대중소_분류_최종.XLSX'))
cg1 <- unique(category[,c(1,3,4)])
d5 <- left_join(d4, cg1)
str(d5)
colSums(is.na(d5))

d5[is.na(d5$`중분류`), ]


#### 외부데이터 탐색으로 인한 변수 정리 

dd1 <- d5
# 1. 기상청 데이터

# 기상청 2019
weather19 <- read.csv('C:\\Users\\lan41\\Desktop\\2020빅콘테스트\\최종제출\\raw_data\\외부데이터\\2019기상청.csv')
# 기상청 2020
weather20 <- read.csv('C:\\Users\\lan41\\Desktop\\2020빅콘테스트\\최종제출\\raw_data\\외부데이터\\2020기상청.csv')
weather <- rbind(weather19, weather20)
colnames(weather) <- c('지점','지점명','방송일시','기온','강수량','풍속','습도','적설','전운량')
colSums(is.na(weather)); colSums(weather==0,na.rm=TRUE);

# 기상청 강수량과 적설 0은 0.02로 결측치는 0으로 처리
weather[!is.na(weather$강수량) & weather$강수량==0,]$강수량  <- 0.02
weather[is.na(weather$강수량),]$강수량 <- 0
weather[!is.na(weather$적설) & weather$적설==0,]$적설  <- 0.02
weather[is.na(weather$적설),]$적설 <- 0
weather$방송일시 <- as.POSIXct(weather$방송일시)

w1 <- weather %>% group_by(방송일시) %>% dplyr::summarise(기온 = mean(기온, na.rm=TRUE),
                                                        강수량 = mean(강수량, na.rm=TRUE),
                                                        풍속 = mean(풍속, na.rm=TRUE),
                                                        습도 = mean(습도, na.rm=TRUE),
                                                        적설 = mean(적설, na.rm=TRUE),
                                                        전운량 = mean(전운량, na.rm=TRUE))
w1$비눈여부 <- as.factor(ifelse(w1$강수량==0 & w1$적설==0, 0, 1))
w1$비눈여부_평균이상 <- as.factor(ifelse(w1$강수량>mean(w1$강수량) | w1$적설>mean(w1$적설), 1, 0))
colSums(is.na(w1)); w1[is.na(w1$전운량),]$전운량 <- 0

dd2 <- left_join(dd1, w1)
str(dd2)
for (i in 2:nrow(dd2)) {
  if (is.na(dd2[i,c('기온','강수량','풍속','습도','적설','전운량','비눈여부','비눈여부_평균이상')])) {
    dd2[i,c('기온','강수량','풍속','습도','적설','전운량','비눈여부','비눈여부_평균이상')] <- dd2[(i-1),c('기온','강수량','풍속','습도','적설','전운량','비눈여부','비눈여부_평균이상')]
  }
}

colSums(is.na(dd2))
# 2. 미세먼지 데이터

dd3 <- dd2

# 미세먼지 2019
dust1 <- read.csv('C:\\Users\\lan41\\Desktop\\2020빅콘테스트\\최종제출\\raw_data\\외부데이터\\2019미세먼지.csv')
colnames(dust1) <- c("날짜시간", "미세먼지", "초미세먼지")
dust1$날짜시간 <- as.character(as.integer(dust1$날짜시간)-1)
# 미세먼지 2020
dust2 <- read.csv('C:\\Users\\lan41\\Desktop\\2020빅콘테스트\\최종제출\\raw_data\\외부데이터\\2020미세먼지.csv')
colnames(dust2) <- c("날짜","미세먼지","초미세먼지")
dust2$날짜 <- as.character(dust2$날짜)

a1 <- dd3[,c('날짜시간','날짜')]
a2 <- left_join(a1, dust1, by='날짜시간')
a3 <- left_join(a1, dust2, by='날짜')

for (i in 1:nrow(dd3)) {
  if (!is.na(a2$미세먼지[i])) {
    dd3$미세먼지[i] <- a2$미세먼지[i]
    dd3$초미세먼지[i] <- a2$초미세먼지[i] 
  } else {
    dd3$미세먼지[i] <- a3$미세먼지[i]
    dd3$초미세먼지[i] <- a3$초미세먼지[i]
  }
}


### 취급액 전처리 및 파생변수 생성

dd4 <- dd3
str(dd4)
colSums(is.na(dd4))

# train데이터 : 2019년 1~12월
train_rawdata1 <- dd4[(dd4$`날짜시간`<'2020010105'), ]
# test데이터 : 2020년 6월
test_rawdata1 <- dd4[(dd4$`날짜시간`>'2020010105'), ]

str(train_rawdata1) #(38309,43)
str(test_rawdata1) #(2891,43)


### train 데이터 전처리

# 취급액 전처리

# 상품군이 "무형" 인 경우 937개
table(train_rawdata1$상품군 == "무형")
# 취급액 결측치 937개
sum(is.na(train_rawdata1$취급액))
# 취급액 50000 이상치 1993개
table(train_rawdata1$취급액 == 50000)

#train_rawdata1 <- train_rawdata1 %>% filter(`상품군` != '무형')
#str(train_rawdata1)

train_rawdata1 = train_rawdata1[(train_rawdata1$상품군!="무형") & (train_rawdata1$취급액!= 50000), ]
str(train_rawdata1) #(35379,43)
rownames(train_rawdata1) <- NULL


### test 데이터 전처리

# 취급액 전처리

# 상품군이 "무형" 인 경우 175개
table(test_rawdata1$상품군 == "무형")
test_rawdata1 = test_rawdata1[(test_rawdata1$상품군!="무형"),]
str(test_rawdata1) #(2716,43)
rownames(test_rawdata1) <- NULL


d6 <- rbind(train_rawdata1, test_rawdata1)
colSums(is.na(d6))

###############################################################


# 판매상품종류수 / 판매상품종류비율

temp_df <- d6 %>% group_by(`방송일시`) %>% summarise(`판매상품종류수` = n())
temp_df$`판매상품종류비율` <- 1/temp_df$`판매상품종류수`
t_df <- left_join(d6, temp_df, by='방송일시')


d7 <- t_df


# 5. 마더코드 + 상품명 => 그룹코드 생성
d7$마더코드 <- as.character(d7$마더코드)

colnames(train_rawdata1)

# 그룹코드 뽑아낼 그룹 dataframe 생성
gdf <- data.frame()
for (i in 1:nrow(train_rawdata1)) {
  if (!(train_rawdata1$상품명[i] %in% gdf$상품명)) {
    gdf <- rbind(gdf, train_rawdata1[i,c("노출(분)","마더코드","상품코드","상품명","판매단가","소분류")])
  }
}
row.names(gdf) <- NULL


for (i in 1:nrow(d7)) {
  if( d7$상품명[i] %in% gdf$상품명 ) {
    d7$그룹코드[i] <- row.names(gdf[d7$상품명[i]==gdf$상품명,])
  } else if ( d7$마더코드[i] %in% gdf$마더코드 ){
    d7$그룹코드[i] <- row.names(gdf[d7$마더코드[i]==gdf$마더코드,])
  }else if( d7$상품코드[i] %in% gdf$상품코드 ) {
    d7$그룹코드[i] <- row.names(gdf[d7$상품코드[i]==gdf$상품코드,])
  } else{
    d7$그룹코드[i] <- NA
  }
}
  
d7[is.na(d7$`그룹코드`), ]

  
gijun <- unique(d7[!is.na(d7$그룹코드), c('마더코드', '상품코드', '그룹코드', '상품명', '상품군', '중분류', '소분류', '판매상품종류수', '판매단가')]) %>% arrange(`판매단가`)
# find_code_df <- unique(d7[is.na(d7$그룹코드), c('마더코드', '상품코드', '그룹코드', '상품명', '상품군', '중분류', '소분류', '판매상품종류수', '판매단가')]) %>% arrange(`판매단가`)


for(k in 1:nrow(d7[is.na(d7$`그룹코드`), ])){
  temp_df <- gijun %>% filter(`소분류`         == d7[is.na(d7$`그룹코드`), ][1, ]$`소분류` &
                              `판매상품종류수` == d7[is.na(d7$`그룹코드`), ][1, ]$`판매상품종류수`)
  
  if( nrow(temp_df)==0 ){
    temp_df <- gijun %>% filter(`중분류`         == d7[is.na(d7$`그룹코드`), ][1, ]$`중분류` &
                                `판매상품종류수` == d7[is.na(d7$`그룹코드`), ][1, ]$`판매상품종류수`)
    if( nrow(temp_df)==0 ){
      temp_df <- gijun %>% filter(`상품군`         == d7[is.na(d7$`그룹코드`), ][1, ]$`상품군` &
                                  `판매상품종류수` == d7[is.na(d7$`그룹코드`), ][1, ]$`판매상품종류수`)
      if( nrow(temp_df)==0 ){
        temp_df <- gijun %>% filter(`판매상품종류수` == d7[is.na(d7$`그룹코드`), ][1, ]$`판매상품종류수`)
        }
      }
    }
  
  temp_df$`diff` <- abs(temp_df$`판매단가` - d7[is.na(d7$`그룹코드`), ][1, ]$`판매단가`)
  arrnage_temp_df <- temp_df %>% arrange(`diff`)
  d7[is.na(d7$`그룹코드`), ][1, ]$`그룹코드` <- arrnage_temp_df[1,]$`그룹코드`
}



d7[is.na(d7$`그룹코드`), ]

d8 <- d7


##############################################################
# 6. 한달 단위(4가지 => PCA)

# 한달 단위 같은 상품군 빈도 변수 생성
d8_c1 <- left_join(d8 %>% group_by(월,상품군) %>% summarise(한달_상품= n()),
                   d8 %>% count(월),
                   by='월')
d8_c2 <- d8_c1 %>% group_by(월,상품군) %>% summarise(한달_상품군빈도 = 한달_상품/n)
d8 <- left_join(d8, d8_c2, by=c('월','상품군'))

# 한달 단위 같은 중분류 빈도 변수 생성
d8_c3 <- left_join(d8 %>% group_by(월,중분류) %>% summarise(한달_상품= n()),
                   d8 %>% count(월),
                   by='월')
d8_c4 <- d8_c3 %>% group_by(월,중분류) %>% summarise(한달_중분류빈도 = 한달_상품/n)
d8 <- left_join(d8, d8_c4, by=c('월','중분류'))

# 한달 단위 같은 소분류 빈도 변수 생성
d8_c5 <- left_join(d8 %>% group_by(월,소분류) %>% summarise(한달_상품= n()),
                   d8 %>% count(월),
                   by='월')
d8_c6 <- d8_c5 %>% group_by(월,소분류) %>% summarise(한달_소분류빈도 = 한달_상품/n)
d8 <- left_join(d8, d8_c6, by=c('월','소분류'))

# 한달 단위 같은 그룹코드 빈도 변수 생성
d8_c7 <- left_join(d8 %>% group_by(월,그룹코드) %>% summarise(한달_상품= n()),
                   d8 %>% count(월),
                   by='월')
d8_c8 <- d8_c7 %>% group_by(월,그룹코드) %>% summarise(한달_그룹코드빈도 = 한달_상품/n)
d8 <- left_join(d8, d8_c8, by=c('월','그룹코드'))



# 7. 판매단가

d9 <- d8
colnames(d9); str(d9)


# 1) 전체 판매단가별 순위형 변수

unique_판매단가_sort <- train_rawdata1 %>% group_by(판매단가) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales)

div_value=floor(nrow(unique_판매단가_sort)/5)
판매단가순위1<-unique_판매단가_sort$판매단가[1:div_value]
판매단가순위2<-unique_판매단가_sort$판매단가[(div_value+1):(div_value*2)]
판매단가순위3<-unique_판매단가_sort$판매단가[(div_value*2+1):(div_value*3)]
판매단가순위4<-unique_판매단가_sort$판매단가[(div_value*3+1):(div_value*4)]
판매단가순위5<-unique_판매단가_sort$판매단가[(div_value*4+1):nrow(unique_판매단가_sort)]

for (i in 1:nrow(d9)) {
  if (d9$판매단가[i] %in% 판매단가순위1) {
    d9$판매단가순위[i] <- 1
  } else if (d9$판매단가[i] %in% 판매단가순위2) {
    d9$판매단가순위[i] <- 2
  } else if (d9$판매단가[i] %in% 판매단가순위3) {
    d9$판매단가순위[i] <- 3
  } else if (d9$판매단가[i] %in% 판매단가순위4) {
    d9$판매단가순위[i] <- 4
  } else if (d9$판매단가[i] %in% 판매단가순위5) {
    d9$판매단가순위[i] <- 5
  } else {
    d9$판매단가순위[i] <-3
  }
}
table(d9$판매단가순위)

# 2) 상품군별 판매단가별 순위형 변수

d9$상품군판매단가순위 <- 0

for (j in 1:length(unique(d9$상품군))) {
  
  a1 <-  train_rawdata1 %>% group_by(상품군,판매단가) %>% filter(상품군==unique(d7$상품군)[j]) %>%
    summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales)
  
  div_value=floor(nrow(a1)/5)
  판매단가순위1<-a1$판매단가[1:div_value]
  판매단가순위2<-a1$판매단가[(div_value+1):(div_value*2)]
  판매단가순위3<-a1$판매단가[(div_value*2+1):(div_value*3)]
  판매단가순위4<-a1$판매단가[(div_value*3+1):(div_value*4)]
  판매단가순위5<-a1$판매단가[(div_value*4+1):nrow(a1)]
  
  for (i in 1:nrow(d7)) {
    if (d9$상품군[i]==unique(d9$상품군)[j]){
      if (d9$판매단가[i] %in% 판매단가순위1) {
        d9$상품군판매단가순위[i] <- 1
      } else if (d9$판매단가[i] %in% 판매단가순위2) {
        d9$상품군판매단가순위[i] <- 2
      } else if (d9$판매단가[i] %in% 판매단가순위3) {
        d9$상품군판매단가순위[i] <- 3
      } else if (d9$판매단가[i] %in% 판매단가순위4) {
        d9$상품군판매단가순위[i] <- 4
      } else if (d9$판매단가[i] %in% 판매단가순위5) {
        d9$상품군판매단가순위[i] <- 5
      } else{
        d9$상품군판매단가순위[i] <- 3
      }
    }
  }
}
table(d9$상품군판매단가순위)


# 8. 취급액 + 프라임 변수

d12 <- d9

### 상품군

# 1) 상품군 요일별 평균 취급액 순위형 DF 생성함수

d12_c1 <- train_rawdata1 %>% group_by(상품군,요일) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales) 
d12_c1 <- acast(data=d12_c1, 상품군~요일, value.var='mean_sales', fill=0)

n = floor(ncol(d12_c1)/5)
for (i in 1:nrow(d12_c1)) {
  d12_c11 <- sort(-d12_c1[i,]) %>% names
  순위1 <- d12_c11[1:n]
  순위2 <- d12_c11[(n+1):(n*2)]
  순위3 <- d12_c11[(n*2+1):(n*3)]
  순위4 <- d12_c11[(n*3+1):(n*4)]
  순위5 <- d12_c11[(n*4+1):ncol(d12_c1)]
  d12_c1[i,순위1] <- 1
  d12_c1[i,순위2] <- 2
  d12_c1[i,순위3] <- 3
  d12_c1[i,순위4] <- 4
  d12_c1[i,순위5] <- 5
}  
table_large_yoill <- d12_c1

# 2) 상품군 24시간별 평균 취급액 순위형 DF 생성함수

d12_c2 <- train_rawdata1 %>% group_by(상품군,시간hour) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales) 
d12_c2 <- acast(data=d12_c2, 상품군~시간hour, value.var='mean_sales', fill=0)

for (i in 1:nrow(d12_c2)) {
  n = floor(sum(d12_c2[i,]!=0)/5)
  d12_c21 <- sort(-d12_c2[i,d12_c2[i,]!=0]) %>% names
  순위1 <- d12_c21[1:n]
  순위2 <- d12_c21[(n+1):(n*2)]
  순위3 <- d12_c21[(n*2+1):(n*3)]
  순위4 <- d12_c21[(n*3+1):(n*4)]
  순위5 <- d12_c21[(n*4+1):sum(d12_c2[i,]!=0)]
  d12_c2[i,순위1] <- 1
  d12_c2[i,순위2] <- 2
  d12_c2[i,순위3] <- 3
  d12_c2[i,순위4] <- 4
  d12_c2[i,순위5] <- 5
  d12_c2[i,d12_c2[i,]==0] <- 6
} 
table_large_hour24 <- d12_c2

# 3) 상품군 168시간별 평균 취급액 순위형 DF 생성함수

d12_c3 <- train_rawdata1 %>% group_by(상품군,`168시간`) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales) 
d12_c3 <- acast(data=d12_c3, 상품군~`168시간`, value.var='mean_sales', fill=0)

for (i in 1:nrow(d12_c3)) {
  n = floor(sum(d12_c3[i,]!=0)/5)
  d12_c31 <- sort(-d12_c3[i,d12_c3[i,]!=0]) %>% names
  순위1 <- d12_c31[1:n]
  순위2 <- d12_c31[(n+1):(n*2)]
  순위3 <- d12_c31[(n*2+1):(n*3)]
  순위4 <- d12_c31[(n*3+1):(n*4)]
  순위5 <- d12_c31[(n*4+1):sum(d12_c3[i,]!=0)]
  d12_c3[i,순위1] <- 1
  d12_c3[i,순위2] <- 2
  d12_c3[i,순위3] <- 3
  d12_c3[i,순위4] <- 4
  d12_c3[i,순위5] <- 5
  d12_c3[i,d12_c3[i,]==0] <- 6
} 
table_large_hour168 <- d12_c3

### 중분류

# 4) 중분류 요일별 평균 취급액 순위형 DF 생성함수

d12_c4 <- train_rawdata1 %>% group_by(중분류,요일) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales) 
d12_c4 <- acast(data=d12_c4, 중분류~요일, value.var='mean_sales', fill=0)

n = floor(ncol(d12_c4)/5)
for (i in 1:nrow(d12_c4)) {
  d12_c41 <- sort(-d12_c4[i,]) %>% names
  순위1 <- d12_c41[1:n]
  순위2 <- d12_c41[(n+1):(n*2)]
  순위3 <- d12_c41[(n*2+1):(n*3)]
  순위4 <- d12_c41[(n*3+1):(n*4)]
  순위5 <- d12_c41[(n*4+1):ncol(d12_c4)]
  d12_c4[i,순위1] <- 1
  d12_c4[i,순위2] <- 2
  d12_c4[i,순위3] <- 3
  d12_c4[i,순위4] <- 4
  d12_c4[i,순위5] <- 5
}  
table_middle_yoill <- d12_c4

# 5) 중분류 24시간별 평균 취급액 순위형 DF 생성함수

d12_c5 <- train_rawdata1 %>% group_by(중분류,시간hour) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales) 
d12_c5 <- acast(data=d12_c5, 중분류~시간hour, value.var='mean_sales', fill=0)

for (i in 1:nrow(d12_c5)) {
  n = floor(sum(d12_c5[i,]!=0)/5)
  d12_c51 <- sort(-d12_c5[i,d12_c5[i,]!=0]) %>% names
  순위1 <- d12_c51[1:n]
  순위2 <- d12_c51[(n+1):(n*2)]
  순위3 <- d12_c51[(n*2+1):(n*3)]
  순위4 <- d12_c51[(n*3+1):(n*4)]
  순위5 <- d12_c51[(n*4+1):sum(d12_c5[i,]!=0)]
  d12_c5[i,순위1] <- 1
  d12_c5[i,순위2] <- 2
  d12_c5[i,순위3] <- 3
  d12_c5[i,순위4] <- 4
  d12_c5[i,순위5] <- 5
  d12_c5[i,d12_c5[i,]==0] <- 6
} 
table_middle_hour24 <- d12_c5

# 6) 중분류 168시간별 평균 취급액 순위형 DF 생성함수

d12_c6 <- train_rawdata1 %>% group_by(중분류,`168시간`) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales) 
d12_c6 <- acast(data=d12_c6, 중분류~`168시간`, value.var='mean_sales', fill=0)

for (i in 1:nrow(d12_c6)) {
  n = floor(sum(d12_c6[i,]!=0)/5)
  d12_c61 <- sort(-d12_c6[i,d12_c6[i,]!=0]) %>% names
  순위1 <- d12_c61[1:n]
  순위2 <- d12_c61[(n+1):(n*2)]
  순위3 <- d12_c61[(n*2+1):(n*3)]
  순위4 <- d12_c61[(n*3+1):(n*4)]
  순위5 <- d12_c61[(n*4+1):sum(d12_c6[i,]!=0)]
  d12_c6[i,순위1] <- 1
  d12_c6[i,순위2] <- 2
  d12_c6[i,순위3] <- 3
  d12_c6[i,순위4] <- 4
  d12_c6[i,순위5] <- 5
  d12_c6[i,d12_c6[i,]==0] <- 6
} 
table_middle_hour168 <- d12_c6


for (i in (1:nrow(d12_c6))) {
  focus_large <- d12$상품군[i]
  focus_middle <- d12$중분류[i]  
  
  focus_yoill <- d12$요일[i]
  focus_hour24 <- d12$시간hour[i]
  focus_hour168 <- d12$`168시간`[i]
  
  
  d12$상품군요일순위[i]    <- table_large_yoill[focus_large,     focus_yoill]
  d12$상품군24시간순위[i]  <- table_large_hour24[focus_large,    focus_hour24]
  #d12$상품군168시간순위[i] <- table_large_hour168[focus_large,   focus_hour168]
  
  d12$중분류요일순위[i]    <- table_middle_yoill[focus_middle,   focus_yoill]
  d12$중분류24시간순위[i]  <- table_middle_hour24[focus_middle,  focus_hour24]
  #d12$중분류168시간순위[i] <- table_middle_hour168[focus_middle, focus_hour168]
}

for (i in (1:nrow(d12_c6))) {
  focus_large <- d12$상품군[i]
  focus_middle <- d12$중분류[i]  
  
  focus_yoill <- d12$요일[i]
  focus_hour24 <- d12$시간hour[i]
  focus_hour168 <- d12$`168시간`[1]
  
  d12$상품군168시간순위[i] <- table_large_hour168[focus_large,   focus_hour168]
  d12$중분류168시간순위[i] <- table_middle_hour168[focus_middle, focus_hour168]
}


# 9. 판매단가 boxplot

d11 <- d12

a <- boxplot(d11$판매단가)$stat
for ( i in 1:nrow(d11)) {
  if(d11$판매단가[i] >= a[5]) {
    d11$판매단가rank[i] <- 1
  } else if(d11$판매단가[i] > a[4] & d11$판매단가[i] < a[5]) {
    d11$판매단가rank[i] <- 2
  } else if(d11$판매단가[i] > a[3] & d11$판매단가[i] < a[4]) {
    d11$판매단가rank[i] <- 3
  } else if(d11$판매단가[i] > a[2] & d11$판매단가[i] < a[3]) {
    d11$판매단가rank[i] <- 4
  } else if(d11$판매단가[i] > a[1] & d11$판매단가[i] < a[2]) {
    d11$판매단가rank[i] <- 5
  } else {
    d11$판매단가rank[i] <- 6
  }
}
table(d11$판매단가rank)


# 10. 범주형 변수 순위형 변수로 재범주화

d12 <- d11

# 1) 시간hour

d12$시간순위 <- 0
unique_시간순위_sort <- train_rawdata1 %>% group_by(시간hour) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales)

div_value=floor(nrow(unique_시간순위_sort)/5)
시간순위1<-unique_시간순위_sort$시간hour[1:div_value]
시간순위2<-unique_시간순위_sort$시간hour[(div_value+1):(div_value*2)]
시간순위3<-unique_시간순위_sort$시간hour[(div_value*2+1):(div_value*3)]
시간순위4<-unique_시간순위_sort$시간hour[(div_value*3+1):(div_value*4)]
시간순위5<-unique_시간순위_sort$시간hour[(div_value*4+1):nrow(unique_시간순위_sort)]

for (i in 1:nrow(d12)) {
  if (d12$시간hour[i] %in% 시간순위1) {
    d12$시간순위[i] <- 1
  } else if (d12$시간hour[i] %in% 시간순위2) {
    d12$시간순위[i] <- 2
  } else if (d12$시간hour[i] %in% 시간순위3) {
    d12$시간순위[i] <- 3
  } else if (d12$시간hour[i] %in% 시간순위4) {
    d12$시간순위[i] <- 4
  } else if (d12$시간hour[i] %in% 시간순위5) {
    d12$시간순위[i] <- 5
  } else {
    d12$시간순위[i] <- 3
  }
}
table(d12$시간순위)

# 2) 168시간

d12$시간순위168 <- 0
unique_시간순위168_sort <- train_rawdata1 %>% group_by(`168시간`) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales)

div_value=floor(nrow(unique_시간순위168_sort)/5)
시간순위1681<-unique_시간순위168_sort$`168시간`[1:div_value]
시간순위1682<-unique_시간순위168_sort$`168시간`[(div_value+1):(div_value*2)]
시간순위1683<-unique_시간순위168_sort$`168시간`[(div_value*2+1):(div_value*3)]
시간순위1684<-unique_시간순위168_sort$`168시간`[(div_value*3+1):(div_value*4)]
시간순위1685<-unique_시간순위168_sort$`168시간`[(div_value*4+1):nrow(unique_시간순위168_sort)]

for (i in 1:nrow(d12)) {
  if (d12$`168시간`[i] %in% 시간순위1681) {
    d12$시간순위168[i] <- 1
  } else if (d12$`168시간`[i] %in% 시간순위1682) {
    d12$시간순위168[i] <- 2
  } else if (d12$`168시간`[i] %in% 시간순위1683) {
    d12$시간순위168[i] <- 3
  } else if (d12$`168시간`[i] %in% 시간순위1684) {
    d12$시간순위168[i] <- 4
  } else if (d12$`168시간`[i] %in% 시간순위1685) {
    d12$시간순위168[i] <- 5
  } else {
    d12$시간순위168[i] <- 3
  }
}
table(d12$시간순위168)

# 3) 브랜드

d12$브랜드순위 <- 0
unique_브랜드순위_sort <- train_rawdata1 %>% group_by(브랜드) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales)

div_value=floor(nrow(unique_브랜드순위_sort)/5)
브랜드순위1<-unique_브랜드순위_sort$브랜드[1:div_value]
브랜드순위2<-unique_브랜드순위_sort$브랜드[(div_value+1):(div_value*2)]
브랜드순위3<-unique_브랜드순위_sort$브랜드[(div_value*2+1):(div_value*3)]
브랜드순위4<-unique_브랜드순위_sort$브랜드[(div_value*3+1):(div_value*4)]
브랜드순위5<-unique_브랜드순위_sort$브랜드[(div_value*4+1):nrow(unique_브랜드순위_sort)]

for (i in 1:nrow(d12)) {
  if (d12$브랜드[i] %in% 브랜드순위1) {
    d12$브랜드순위[i] <- 1
  } else if (d12$브랜드[i] %in% 브랜드순위2) {
    d12$브랜드순위[i] <- 2
  } else if (d12$브랜드[i] %in% 브랜드순위3) {
    d12$브랜드순위[i] <- 3
  } else if (d12$브랜드[i] %in% 브랜드순위4) {
    d12$브랜드순위[i] <- 4
  } else if (d12$브랜드[i] %in% 브랜드순위5) {
    d12$브랜드순위[i] <- 5
  } else {
    d12$브랜드순위[i] <- 3
  }
}
table(d12$브랜드순위)

# 4) 중분류

d12$중분류순위 <- 0
unique_중분류순위_sort <- train_rawdata1 %>% group_by(중분류) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales)

div_value=floor(nrow(unique_중분류순위_sort)/5)
중분류순위1<-unique_중분류순위_sort$중분류[1:div_value]
중분류순위2<-unique_중분류순위_sort$중분류[(div_value+1):(div_value*2)]
중분류순위3<-unique_중분류순위_sort$중분류[(div_value*2+1):(div_value*3)]
중분류순위4<-unique_중분류순위_sort$중분류[(div_value*3+1):(div_value*4)]
중분류순위5<-unique_중분류순위_sort$중분류[(div_value*4+1):nrow(unique_중분류순위_sort)]

for (i in 1:nrow(d12)) {
  if (d12$중분류[i] %in% 중분류순위1) {
    d12$중분류순위[i] <- 1
  } else if (d12$중분류[i] %in% 중분류순위2) {
    d12$중분류순위[i] <- 2
  } else if (d12$중분류[i] %in% 중분류순위3) {
    d12$중분류순위[i] <- 3
  } else if (d12$중분류[i] %in% 중분류순위4) {
    d12$중분류순위[i] <- 4
  } else if (d12$중분류[i] %in% 중분류순위5) {
    d12$중분류순위[i] <- 5
  } else {
    d12$중분류순위[i] <- 3
  }
}
table(d12$중분류순위)

# 5) 소분류

d12$소분류순위 <- 0
unique_소분류순위_sort <- train_rawdata1 %>% group_by(소분류) %>%
  summarize(mean_sales = mean(취급액, na.rm = TRUE)) %>% arrange(-mean_sales)

div_value=floor(nrow(unique_소분류순위_sort)/5)
소분류순위1<-unique_소분류순위_sort$소분류[1:div_value]
소분류순위2<-unique_소분류순위_sort$소분류[(div_value+1):(div_value*2)]
소분류순위3<-unique_소분류순위_sort$소분류[(div_value*2+1):(div_value*3)]
소분류순위4<-unique_소분류순위_sort$소분류[(div_value*3+1):(div_value*4)]
소분류순위5<-unique_소분류순위_sort$소분류[(div_value*4+1):nrow(unique_소분류순위_sort)]

for (i in 1:nrow(d12)) {
  if (d12$소분류[i] %in% 소분류순위1) {
    d12$소분류순위[i] <- 1
  } else if (d12$소분류[i] %in% 소분류순위2) {
    d12$소분류순위[i] <- 2
  } else if (d12$소분류[i] %in% 소분류순위3) {
    d12$소분류순위[i] <- 3
  } else if (d12$소분류[i] %in% 소분류순위4) {
    d12$소분류순위[i] <- 4
  } else if (d12$소분류[i] %in% 소분류순위5) {
    d12$소분류순위[i] <- 5
  } else {
    d12$소분류순위[i] <- 3
  }
}
table(d12$소분류순위)

str(d12)



# 6) 방송내_순서


df1 <- d12 %>% arrange(`그룹코드`, `방송일시`, `시간`)

df1$`방송내_순서` <- 0
df1[1, ]$`방송내_순서` <- 1
rank <- 1
for(i in 1:(nrow(df1)-1) ){
  if( ( df1[i, ]$`상품명` == df1[i+1, ]$`상품명` ) & (  df1[i, ]$`날짜` == df1[i+1, ]$`날짜` )){
    rank <- rank + 1
    df1[i+1, ]$`방송내_순서` <- rank
  }
  else{
    rank <- 1
    df1[i+1, ]$`방송내_순서` <- rank
  }
}

df2 <- df1 %>% arrange(`방송일시`)



levels(factor(df2$`방송내_순서`))

View(df2[df2$`그룹코드` == 1071, c('방송일시', '그룹코드', '상품명', '방송내_순서')])  # 400 / 401 / 619 / 417 / 691 / 692 / 694 / 693 / 1071


str(df2)

# 그룹코드 400 > 한날 방송 3번 함
df2[(df2$`날짜시간` > '2019042110') & (df2$`날짜시간` < '2019042112'), ][1:2, ]$`방송내_순서` <- 1
df2[(df2$`날짜시간` > '2019042110') & (df2$`날짜시간` < '2019042112'), ][3:4, ]$`방송내_순서` <- 2
df2[(df2$`날짜시간` > '2019042110') & (df2$`날짜시간` < '2019042112'), ][5:6, ]$`방송내_순서` <- 3

# 그룹코드 401 > 한날 방송 3번 함
df2[(df2$`날짜시간` > '2019042116') & (df2$`날짜시간` < '2019042118'), ][1:2, ]$`방송내_순서` <- 1
df2[(df2$`날짜시간` > '2019042116') & (df2$`날짜시간` < '2019042118'), ][3:4, ]$`방송내_순서` <- 2
df2[(df2$`날짜시간` > '2019042116') & (df2$`날짜시간` < '2019042118'), ][5:6, ]$`방송내_순서` <- 3

# 그룹코드 619
df2[(df2$`날짜시간` > '2019053119') & (df2$`날짜시간` < '2019053121'), ][1, ]$`방송내_순서` <- 1
df2[(df2$`날짜시간` > '2019053119') & (df2$`날짜시간` < '2019053121'), ][2, ]$`방송내_순서` <- 2
df2[(df2$`날짜시간` > '2019053119') & (df2$`날짜시간` < '2019053121'), ][3, ]$`방송내_순서` <- 3
df2[(df2$`날짜시간` > '2019053119') & (df2$`날짜시간` < '2019053121'), ][4, ]$`방송내_순서` <- 4
df2[(df2$`날짜시간` > '2019053119') & (df2$`날짜시간` < '2019053121'), ][5, ]$`방송내_순서` <- 5
df2[(df2$`날짜시간` > '2019053119') & (df2$`날짜시간` < '2019053121'), ][6, ]$`방송내_순서` <- 6


# 그룹코드 417
df2[(df2$`날짜시간` > '2019033108') & (df2$`날짜시간` < '2019033110'), ][1, ]$`방송내_순서` <- 1
df2[(df2$`날짜시간` > '2019033108') & (df2$`날짜시간` < '2019033110'), ][2, ]$`방송내_순서` <- 2
df2[(df2$`날짜시간` > '2019033108') & (df2$`날짜시간` < '2019033110'), ][3, ]$`방송내_순서` <- 3
df2[(df2$`날짜시간` > '2019033115') & (df2$`날짜시간` < '2019033117'), ][1, ]$`방송내_순서` <- 1
df2[(df2$`날짜시간` > '2019033115') & (df2$`날짜시간` < '2019033117'), ][2, ]$`방송내_순서` <- 2
df2[(df2$`날짜시간` > '2019033115') & (df2$`날짜시간` < '2019033117'), ][3, ]$`방송내_순서` <- 3

# 그룹코드 691
df2[(df2$`날짜시간` > '2019060121') & (df2$`날짜시간` < '2019060124'), ][7:10, ]$`방송내_순서` <- 1
df2[(df2$`날짜시간` > '2019060121') & (df2$`날짜시간` < '2019060125'), ][11:14, ]$`방송내_순서` <- 2
df2[(df2$`날짜시간` > '2019060121') & (df2$`날짜시간` < '2019060125'), ][15, ]$`방송내_순서` <- 3
df2[(df2$`날짜시간` > '2019060122') & (df2$`날짜시간` < '2019060125'), ][1:4, ]$`방송내_순서` <- 3


#그룹코드 692
df2[(as.character(df2$`방송일시`) > '2019-06-01 22:00:00') & (as.character(df2$`방송일시`) < '2019-06-01 23:30:00'), ][1:4,]$`방송내_순서` <- 1
df2[(as.character(df2$`방송일시`) > '2019-06-01 22:00:00') & (as.character(df2$`방송일시`) < '2019-06-01 23:30:00'), ][5:8, ]$`방송내_순서` <- 2
df2[(as.character(df2$`방송일시`) > '2019-06-01 22:00:00') & (as.character(df2$`방송일시`) < '2019-06-01 23:30:00'), ][9:12, ]$`방송내_순서` <- 3
df2[(as.character(df2$`방송일시`) > '2019-06-01 22:00:00') & (as.character(df2$`방송일시`) < '2019-06-01 23:30:00'), ][13:15, ]$`방송내_순서` <- 4


# 그룹코드 694
df2[15023, ]$`방송내_순서` <- 4




# 7. `방송순서`

data <- df2 %>% group_by(`방송일시`) %>% summarise(n = n()) %>%  arrange(`방송일시`)
data <- data[,1]

data$`월` <- as.numeric(substr(data$`방송일시`, 6, 7))
data$`시간` <- substr(data$`방송일시`, 12, 16)

data$`방송순서` <- 999
for(i in 1:(nrow(data)-1)){
  if( data[i,]$`월` < 11 ){
    if( data[i,]$`시간` == '06:00' ){
      rank <- 1
      data[i,]$`방송순서` <- rank
    }
    else{
      rank <- rank + 1
      data[i,]$`방송순서` <- rank
    }
  }
  else{
    if( data[i,]$`시간` == '06:20' ){
      rank <- 1
      data[i,]$`방송순서` <- rank
    }
    else{
      rank <- rank + 1
      data[i,]$`방송순서` <- rank
    }
  }
}

df3 <- left_join(df2, data[, c('방송일시', '방송순서')], by='방송일시')


# 8. 그룹코드 > 전체횟수/ 대박횟수 / 대박확률 / 쪽박횟수 / 쪽박확률

train_rawdata1 <- df3[df3$`날짜시간` < '2020010105',]

str(df3)

product_list <- list()
fac <- levels(factor(train_rawdata1$`상품군`))

for(f in fac){product_list[[f]] <- train_rawdata1 %>% filter(`상품군` == f)}


arrange_train <- train_rawdata1 %>% arrange(`취급액`)
cnt_database_list <- list() 
for(f in fac){
  df <- product_list[[f]]
  
  cnt_df <- df %>% group_by(`그룹코드`) %>% summarise(`그룹코드_전체횟수` = n())
  cnt_down_df <- df %>% filter(`취급액` < arrange_train[ floor(nrow(arrange_train)*0.2), ]$`취급액` ) %>% group_by(`그룹코드`) %>% summarise(`그룹코드_쪽박횟수` = n())
  cnt_up_df <- df %>% filter(`취급액` > arrange_train[ floor(nrow(arrange_train)*0.85), ]$`취급액` ) %>% group_by(`그룹코드`) %>% summarise(`그룹코드_대박횟수` = n())
  
  temp_cnt1 <- left_join(cnt_df, cnt_down_df, by = '그룹코드')
  temp_cnt1[is.na(temp_cnt1$`그룹코드_쪽박횟수`), ]$`그룹코드_쪽박횟수` <- 0
  temp_cnt2 <- left_join(temp_cnt1, cnt_up_df, by = '그룹코드')
  temp_cnt2[is.na(temp_cnt2$`그룹코드_대박횟수`), ]$`그룹코드_대박횟수` <- 0
  
  cnt_database_list[[f]] <- temp_cnt2
}

cnt_database <- cnt_database_list[[1]]
for(i in 2:length(cnt_database_list)){
  cnt_database <- rbind(cnt_database, cnt_database_list[[i]])
}

cnt_database$`그룹코드_쪽박확률` <- cnt_database$`그룹코드_쪽박횟수` / cnt_database$`그룹코드_전체횟수`
cnt_database$`그룹코드_대박확률` <- cnt_database$`그룹코드_대박횟수` / cnt_database$`그룹코드_전체횟수`

df4 <- left_join(df3, cnt_database, by='그룹코드')

colSums(is.na(df4))


# 9. 중분류 > 전체횟수/ 대박횟수 / 대박확률


df <- train_rawdata1
  
cnt_df <- df %>% group_by(`중분류`) %>% summarise(`중분류별_전체횟수` = n())
cnt_down_df <- df %>% filter(`취급액` < arrange_train[ floor(nrow(arrange_train)*0.2), ]$`취급액` ) %>% group_by(`중분류`) %>% summarise(`중분류별_쪽박횟수` = n())
cnt_up_df <- df %>% filter(`취급액` > arrange_train[ floor(nrow(arrange_train)*0.85), ]$`취급액` ) %>% group_by(`중분류`) %>% summarise(`중분류별_대박횟수` = n())
  
temp_cnt1 <- left_join(cnt_df, cnt_down_df, by = '중분류')
temp_cnt1[is.na(temp_cnt1$`중분류별_쪽박횟수`), ]$`중분류별_쪽박횟수` <- 0
temp_cnt2 <- left_join(temp_cnt1, cnt_up_df, by = '중분류')
temp_cnt2[is.na(temp_cnt2$`중분류별_대박횟수`), ]$`중분류별_대박횟수` <- 0
  
temp_cnt2$`중분류별_쪽박확률` <- temp_cnt2$`중분류별_쪽박횟수` / temp_cnt2$`중분류별_전체횟수`
temp_cnt2$`중분류별_대박확률` <- temp_cnt2$`중분류별_대박횟수` / temp_cnt2$`중분류별_전체횟수`

df5 <- left_join(df4, temp_cnt2)

colSums(is.na(df5))


# test set에만 존재하는 중분류 존재


df5[is.na(df5$`중분류별_전체횟수`),]$`중분류별_전체횟수` <- median(df5$`중분류별_전체횟수`, na.rm =T)
df5[is.na(df5$`중분류별_쪽박횟수`),]$`중분류별_쪽박횟수` <- median(df5$`중분류별_쪽박횟수`, na.rm =T)
df5[is.na(df5$`중분류별_대박횟수`),]$`중분류별_대박횟수` <- median(df5$`중분류별_대박횟수`, na.rm =T)
df5[is.na(df5$`중분류별_쪽박확률`),]$`중분류별_쪽박확률` <- median(df5$`중분류별_쪽박확률`, na.rm =T)
df5[is.na(df5$`중분류별_대박확률`),]$`중분류별_대박확률` <- median(df5$`중분류별_대박확률`, na.rm =T)



# 10. 소분류

df <- train_rawdata1

cnt_df <- df %>% group_by(`소분류`) %>% summarise(`소분류별_전체횟수` = n())
cnt_down_df <- df %>% filter(`취급액` < arrange_train[ floor(nrow(arrange_train)*0.2), ]$`취급액` ) %>% group_by(`소분류`) %>% summarise(`소분류별_쪽박횟수` = n())
cnt_up_df <- df %>% filter(`취급액` > arrange_train[ floor(nrow(arrange_train)*0.85), ]$`취급액` ) %>% group_by(`소분류`) %>% summarise(`소분류별_대박횟수` = n())

temp_cnt1 <- left_join(cnt_df, cnt_down_df, by = '소분류')
temp_cnt1[is.na(temp_cnt1$`소분류별_쪽박횟수`), ]$`소분류별_쪽박횟수` <- 0
temp_cnt2 <- left_join(temp_cnt1, cnt_up_df, by = '소분류')
temp_cnt2[is.na(temp_cnt2$`소분류별_대박횟수`), ]$`소분류별_대박횟수` <- 0

temp_cnt2$`소분류별_쪽박확률` <- temp_cnt2$`소분류별_쪽박횟수` / temp_cnt2$`소분류별_전체횟수`
temp_cnt2$`소분류별_대박확률` <- temp_cnt2$`소분류별_대박횟수` / temp_cnt2$`소분류별_전체횟수`

df6 <- left_join(df5, temp_cnt2)

colSums(is.na(df6))


# test set에만 존재하는 소분류 존재
df6[is.na(df6$`소분류별_전체횟수`),]$`소분류별_전체횟수` <- median(df6$`소분류별_전체횟수`, na.rm=T)
df6[is.na(df6$`소분류별_쪽박횟수`),]$`소분류별_쪽박횟수` <- median(df6$`소분류별_쪽박횟수`, na.rm=T)
df6[is.na(df6$`소분류별_대박횟수`),]$`소분류별_대박횟수` <- median(df6$`소분류별_대박횟수`, na.rm=T)
df6[is.na(df6$`소분류별_쪽박확률`),]$`소분류별_쪽박확률` <- median(df6$`소분류별_쪽박확률`, na.rm=T)
df6[is.na(df6$`소분류별_대박확률`),]$`소분류별_대박확률` <- median(df6$`소분류별_대박확률`, na.rm=T)

colSums(is.na(df6))

# 11. 주기를 고려한 변수 COS / SIN

df6$`분` <- substr(df6$`시간`, 4, 5)


# 월
df6$`월_COS` <- cos(( 2*pi*as.numeric(df6$`월`) ) / 12)
df6$`월_SIN` <- sin(( 2*pi*as.numeric(df6$`월`) ) / 12)


# 168시간 : 일주일
df6$`168시간_COS` <- cos(( 2*pi*as.numeric(df6$`168시간`) ) / 168) + cos(( 2*pi*as.numeric(df6$`분`) ) / 60)
df6$`168시간_SIN` <- sin(( 2*pi*as.numeric(df6$`168시간`) ) / 168) + sin(( 2*pi*as.numeric(df6$`분`) ) / 60)

# 24시간 : 하루
df6$`24시간_COS` <- cos(( 2*pi*as.numeric(df6$`시간hour`) ) / 24) + cos(( 2*pi*as.numeric(df6$`분`) ) / 60)
df6$`24시간_SIN` <- sin(( 2*pi*as.numeric(df6$`시간hour`) ) / 24) + sin(( 2*pi*as.numeric(df6$`분`) ) / 60)

df6$`분` <- NULL


df7 <- df6


colSums(is.na(df7))

# 12. 방송내_상품종류별점수

d <- train_rawdata1 %>% 
  group_by(`마더코드`, `그룹코드`) %>% 
  summarise(`취급액평균` = mean(`취급액`)) %>% 
  arrange(`그룹코드`, `취급액평균`)

b <- boxplot(d$`취급액평균`)


d$방송내_상품종류별_점수 <- 1
d[d$`취급액평균` > b$stats[1,], ]$방송내_상품종류별_점수 <- 2
d[d$`취급액평균` > b$stats[2,], ]$방송내_상품종류별_점수 <- 3
d[d$`취급액평균` > b$stats[3,], ]$방송내_상품종류별_점수 <- 4
d[d$`취급액평균` > b$stats[4,], ]$방송내_상품종류별_점수 <- 5
d[d$`취급액평균` > b$stats[5,], ]$방송내_상품종류별_점수 <- 6
str(d)
d$`그룹코드` <- as.character(d$`그룹코드`)

df8 <- left_join(df7, d[, c('그룹코드', '마더코드', '방송내_상품종류별_점수')], by = c('마더코드', '그룹코드'))
for (i in 1:nrow(df8)) {
  if(is.na(df8$방송내_상품종류별_점수[i])) {
    df8$방송내_상품종류별_점수[i] <- d[d$그룹코드 == df8$그룹코드[i],]$방송내_상품종류별_점수
  }
}
str(df8)
df9 <- df8


nrow(df9)

colSums(is.na(df9))

# 13. 방송내_상품선호도
df10 <- df9

str(df10)
train_rawdata1 <- df10 %>% filter(`날짜시간` < '2020010105')

train_rawdata1$`전체편성비율` <- train_rawdata1$`그룹코드_전체횟수` / nrow(train_rawdata1)


train_rawdata1$`그룹코드` <- as.numeric(train_rawdata1$`그룹코드`)
train_rawdata1$최소판매수량 <- floor(train_rawdata1$`취급액` / train_rawdata1$`판매단가`)


cnt_amount_df <- train_rawdata1 %>% group_by(`그룹코드`) %>% summarise(`그룹코드별_최소판매수량합` = sum(`최소판매수량`))
cnt_amount_df$`그룹코드` <- as.character(cnt_amount_df$`그룹코드`)

df <- left_join(df10, cnt_amount_df, by='그룹코드')

hap_df <- unique(df[, c('마더코드', '그룹코드', '상품명', '그룹코드별_최소판매수량합')])




hap_df$`방송내_최소판매수량합` <- -999
hap <- hap_df[1,]$`그룹코드별_최소판매수량합`
idx <- c(1)
for(i in 1:(nrow(hap_df) - 1)){
  if(hap_df[i, ]$`마더코드` == hap_df[i+1, ]$`마더코드`){
    idx <- c(idx, i+1)
    hap <- hap + hap_df[i+1, ]$그룹코드별_최소판매수량합
  }
  else{
    hap_df[idx,]$`방송내_최소판매수량합` <- hap
    idx <- c(i+1)
    hap <- hap_df[i+1, ]$`그룹코드별_최소판매수량합`
  }
}


hap_df$방송내_상품선호도 <- hap_df$`그룹코드별_최소판매수량` / hap_df$`방송내_최소판매수량합`
hap_df[hap_df$`방송내_상품선호도` == 1, ]$`방송내_상품선호도` <- 1/2



df11 <- left_join(df10, hap_df[,c('마더코드', '그룹코드', '상품명', '방송내_상품선호도')], by=c('마더코드', '그룹코드', '상품명'))


nrow(df11)
colSums(is.na(df11))
d10 <- df11








### train test 분리
# train데이터 : 2019년 1~12월(6월제외)
train1 <- d10[(d10$`날짜시간`<'2020010105'),]
# test데이터 : 2019년 6월
test1 <- d10[(d10$`날짜시간`>'2020010105'),]




### train 전처리

# 취급액 분포
boxplot(train1$취급액)
#install.packages('rcompanion')
library(rcompanion)
# 취급액의 분포가 왼쪽으로 치우쳐져 있다
plotNormalHistogram(train1$취급액)

# 정규 변환 - boxcox
#install.packages('MASS')
library(MASS)
Box = boxcox(lm(train1$취급액 ~ 1))
Cox = data.frame(Box$x, Box$y)          
Cox2 = Cox[with(Cox, order(-Cox$Box.y)),] 
lambda = Cox2[1, 'Box.x'] #lambda = 0.22
y2 = (train1$취급액 ^ lambda - 1)/lambda
plotNormalHistogram(y2)
qqnorm(y2); qqline(y2)

# 취급액 boxcox로 변환한 변수 생성
train1['취급액boxcox'] <- y2
summary(train1['취급액boxcox'])
colSums(is.na(train1))

# test 박스콕스
test1$취급액boxcox <- (test1$취급액 ^ lambda - 1)/lambda
colSums(is.na(test1))



nrow(test1)
write.csv(train1, file='2020train.csv')
write.csv(test1, file='2020test.csv')

