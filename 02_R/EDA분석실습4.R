# 1.
# 데이터 내에 결측치 여부를 확인한다. 
# NA값이 310681개 있는 것을 확인할 수 있다.


apply(is.na(temp_data), 2, sum)


################################################################################
# 강사님 팁
# 결측치를 확인하는 방법
spanish_data[!complete.cases(spanish_data), ]
# 결측치를 제거하는 방법
spanish_data2 <- spanish_data[complete.cases(spanish_data), ]
################################################################################


# 2.
# filter와 !is.na함수를 통해 결측치를 모두 제거했다.

as_tibble(temp_data)
no_NA <- temp_data %>% 
  filter(!is.na(price) & !is.na(id))

as_tibble(no_NA)


# 3.
# 마드리드 출발
# 마드리드에서 출발하는 열차 데이터만을 떼어내 madrid_origin이라는 변수로 저장하고 
# 우선, 마드리드에서 출발하는 열차 데이터만을 이용해 비교해보기로 한다.


madrid_orgin <- no_NA %>% filter(origin == 'MADRID')
madrid_orgin <- madrid_orgin[, -2]
str(madrid_orgin)





# 4.
# summary함수를 통해 일반적 데이터 정보를 다시 확인한다.

summary(madrid_orgin)





# 5.
# 마드리드 출발 열차의 빈도 수
# 마드리드를 출발하는 기차의 도착 도시별 운행빈도 수를 바형태로 나타내보자

str(madrid_orgin)


depart_madrid <- madrid_orgin %>% 
  group_by(destination) %>% 
  dplyr::summarise(count = n())

str(depart_madrid)



ggplot(data = depart_madrid, 
       aes(x = destination,
           y = count,
           fill = destination)) +
  geom_bar(stat = 'identity') +
  coord_flip() +
  theme(legend.position = 'none')


# 6.
# 마드리발 도착지별 가격 박스플롯으로
# 티켓가격의 높은 순을 확인해보자

str(madrid_orgin)

ggplot(data = madrid_orgin,
       aes(x = destination,
           y = price,
           fill = destination)) +
  geom_boxplot() + 
  coord_flip() + 
  theme(legend.position = 'none')



# 7.
# AVE의좌석 등급별 가격박스플롯이 시각화 
# 똑같은 열차와 똑같은 좌석등급, 똑같은 도착지라 하더라도 가격이 차이가 나는 것을 확인할 수 있다.

str(madrid_orgin)
as_tibble(madrid_orgin)

AVE_madrid_orgin <- madrid_orgin %>% 
  filter(train_type == 'AVE')

factor(AVE_madrid_orgin$train_type)

str(AVE_madrid_orgin)
AVE_madrid_orgin <- AVE_madrid_orgin[, -5]


str(AVE_madrid_orgin)


ggplot(data = AVE_madrid_orgin,
       aes(x = train_class,
           y = price,
           fill = train_class)) +
  geom_boxplot() +
  coord_flip() +
  theme(legend.position = 'none')
