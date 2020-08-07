######## Front end
# 브라우저
# html   :   브라우저   
# 여러가지의 elements로 구성되어있음
# elements는? < tag (속성: property) >     /    text </tag>                            
#                   여기서 이 속성을 알아야 크롤링이 가능하다
#

# css   :   꾸며줌        <tag class>
# javascript  :  동작처리     <tag id>

# 크롤링으로 자기가 원하는 글씨와 내용을 가져오기 위해서는
# 직접적으로 id와 class를 통해 접근해야 한다.
# id에 접근하려면 .
# class에 접근하려면 #
# 또한 원하는 텍스트를 가져오기 위해서는 정규표현식을 통해 정제해야함





######## Back end
# 24시간 request를 받을 수있도록 서버를 사용하는데
# 이때 사용하는 것이 아파치 서버 라고함
# 이 아파치 서버는 c언어로 만들어져있기에
# 파이썬과 자바로 프레임웤을 짜게되면 동작을 하지 못함
# 그래서 c언어가 아닌 언어로 만든 프레임웤을 아파치 서버에서 작동시키기 위해
# WAS를 통해 프레임 웤을 적용시켜야함



# Django라는 프레임웤은 WAS를 포함하기 때문에
# 따로 WAS를 필요로하지 않는다



######################################################
#####   R에서 크롤링 한번 해봅시다  ㅎㅎ







install.packages('rvest')
library(rvest)
library(dplyr)
library(stringr)


url <- "https://dhlottery.co.kr/store.do?method=topStoreRank&rank=1&pageGubun=L645"

link <- read_html(url)


# node walking 방법!
# 목차순서대로 찾아들어가는 방법


link %>% 
  html_nodes('body') %>% 
  html_nodes('.containerWrap') %>% 
  html_nodes('.contentSection') %>% 
  html_nodes('#article') %>% 
  html_nodes('')






# direct 방법
# 목차순서를 입력하지 않고 바로 원하는 항목에 접근하는 방법

link %>% 
  html_nodes('td') %>% 
  html_text()


lotto15 <- link %>% 
  html_nodes('tbody tr td') %>% 
  html_text()

lotto15 <- str_replace_all(lotto15, '\t|\n|\r', '')
lotto15
lotto15 <- str_replace_all(lotto15, '[[:space:]]', '')
lotto15





storeName <- NULL
cnt <- NULL
address <- NULL


for(idx in 1:length(lotto15)){
  if(idx %% 5 == 2){
    storeName <- c(storeName, lotto15[idx])
  } else if(idx %% 5 == 3){
    cnt <- c(cnt, lotto15[idx])
  } else if(idx %% 5 == 4){
    address <- c(address, lotto15[idx])
  }
}


lottoDF <- data.frame(storeName, cnt, address)
lottoDF



storeName
cnt
address




last <- link %>% 
  html_nodes('.paginate_common') %>% 
  html_nodes('a') %>% 
  html_attr('onclick') %>% 
  tail(1)

last





end <- regmatches(last, gregexpr('[0-9]', last))
end <- as.numeric(end[[1]])
end <- as.numeric(paste(end[1], end[2], end[3], sep = ""))
end



install.packages('RSelenium')
library(RSelenium)


remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = 'chrome')

remDr$open()
remDr$navigate("https://dhlottery.co.kr/store.do?method=topStoreRank&rank=1&pageGubun=L645")



lottoStore = c()
for(idx in 1:end){
  front <- "selfSubmit("
  back <- ")"
  script <- paste(front, idx, back, sep="")
  
  # 소스 받아오기
  source <- remDr$getPageSource()[[1]]
  js_html <- read_html(source)
  
  js_link <- html_nodes(js_html, 'tbody')
  stores <-js_link %>% 
    html_nodes('tr') %>% 
    html_nodes('td') %>% 
    html_text()

  lottoStore <- c(lottoStore, stores)
  pagemove <- remDr$executeScript(script, args = 1:2)
  
}









lottoStore <- str_replace_all(lottoStore, '\t|\n|\r', '')
lottoStore <- str_replace_all(lottoStore, '[[:space:]]', '')
lottoStore





storeName <- NULL
cnt <- NULL
address <- NULL


for(idx in 1:length(lottoStore)){
  if(idx %% 5 == 2){
    storeName <- c(storeName, lottoStore[idx])
  } else if(idx %% 5 == 3){
    cnt <- c(cnt, lottoStore[idx])
  } else if(idx %% 5 == 4){
    address <- c(address, lottoStore[idx])
  }
}


lottoDF <- data.frame(storeName, cnt, address)
write.csv(lottoDF, "lotto_store.csv", row.names = F)
lottoDF









