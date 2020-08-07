



# 교차검증을 위한 데이터셋 분리 방법

# 1. sample()
# 2. K-Fold() 방식
# 3. Hold-Out 방식






# 1. 단순임의 추출
# sample()



sample(1:10, 5)
sample(1:10, replace = T)






# 2. K-Fold 방식

install.packages("cvTools")
library(cvTools)

set.seed(123)
?cvFolds

cvFolds()


fold <- cvFolds(n = 6, K = 3, R = 1)
fold

str(fold)
fold$subsets
fold$which
fold


fold$subsets[fold$which == 1, 1]



## 10-Fold cross validation을 3번 반복하세요
irisFold <- cvFolds(n = nrow(iris), K = 10, R = 3)
str(irisFold)
irisFold$subsets



# 1번 fold에 포함된 1번째 반복에 포함된 데이터를 출력하세요
irisFold$subsets[irisFold$which == 1, 1]








################### classification - naiveBayes알고리즘
# 목표변수가 범주형



# naiveBayes() 패키지
install.packages("e1071")
library(e1071)



learning_machine <- function(data, K, r){
  make_fold <- cvFolds(n = nrow(data), K=K, R=r)
  acc <- c()
  All_acc <- c()
  for(i in 1:r){
    k_acc <- c()
    cat(i, '번째 반복#############  \n')
    
    for(j in 1:K){
      # train / test 나누기
      test_set_idx <- make_fold$subsets[make_fold$which == j, i]
      test_set <- data[test_set_idx, ]
      train_set <- data[-test_set_idx, ]
      
      # 학습기 만들기
      model <- naiveBayes(Species ~. , data = train_set)
      pred <- predict(model, test_set)
      t <- table(pred, test_set$Species)
      cat(j,'Fold Validation :')
      print(t)
      acc <- (t[1, 1] + t[2, 2] +t[3, 3]) / sum(t)
      cat('accuracy is', acc, '\n\n')
      k_acc <- c(k_acc, acc)
    }
    All_acc <- cbind(All_acc, k_acc)
    
  }
  cat('\n')
  cat('All accuracy : ', k_acc, '\n')
  
  return(All_acc)
}


learning_machine(iris, 5, 3)










### 3. Hold-out 교차검증
install.packages("caret")
library(caret)

?createDataPartition
# createDataPartition


hold_out_train <- createDataPartition(iris$Species, p = 0.8)
names(hold_out_train)




train_iris <- iris[hold_out_train$Resample1, ]
test_iris <- iris[-hold_out_train$Resample1, ]

model <- naiveBayes(Species ~., data = train_iris)
pred <- predict(model, test_iris)
t <- table(pred, test_iris$Species)
print(t)

acc <- (t[1, 1] + t[2, 2] + t[3, 3]) / sum(t)
acc






######### -- 분류 실습(Naive Bayes classifier)
# 텍스트분류
# 문서를 여러 범주로 나누어서 판단하는 알고리즘
# 조건부 확률
# 10개의 메일 중, 3개는 스팸메일이다.
# 그리고 그와 상관없이 free라는 단어를 포함하는 메일이 4개이다.
# 문제는 free(A)라는 메일이 와 있을때,
# 그것이 스팸메일(B)인지 아닌지를 구분해야 한다면?
# 공식 : P(B/A) = P(B) * P(A/B) / P(A)
# 1. 스팸메일일 확률 : 3/10
# 2. free를 포함하는 메일의 확률 : 4/10
# 3. 스팸메일 중에 포함된 free 포함메일 : 2/3
# P(SPAM/FREE) = P(SPAM) * P(FREE/SPAM) / P(FREE)


iris
install.packages("klaR")
library(klaR)


train <- sample(nrow(iris), 100)
naive_model <- NaiveBayes(Species ~ . , data = iris, subset = train)


pred <- predict(naive_model, iris[-train, ])
names(pred)

tt <- table(iris$Species[-train],
            predict(naive_model, iris[-train, ])$class)


sum(tt[row(tt) == col(tt)]) / sum(tt)
1 - sum(tt[row(tt) == col(tt)]) / sum(tt)






library(ggplot2)
test <- iris[-train,]
test$pred <- predict(naive_model, iris[-train, ])$class

ggplot(test,
       aes(Species, pred, col = Species)) +
  geom_jitter(width = 0.2, height = 0.1, size = 2) +
  labs(x = 'Species',
       y = 'Predict')





































