from django.db import models

# Create your models here.


class Question(models.Model):
    question_text   = models.CharField(max_length=200) # char 타입의 필드로 200 사이즈
    regdate         = models.DateTimeField('date pulished')        # dataTIME 타입 필드

    def __str__(self):  # str은 입력 받은 객체의 문자열 버전을 반환하는 함수
        return self.question_text+ "," + str(self.regdate)


class Choice(models.Model):
    # question 가지고 있는 키를 가지고 외래키를 삼아 만들고  cascade로 삭제될 때 같이 삭제한다.
    question_text = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200) # char 200 사이즈
    votes = models.IntegerField(default=0) # int 타입의 필드로 기본값이 0 으로한다.

    def __str__(self):  # str은 입력 받은 객체의 문자열 버전을 반환하는 함수
        return str(self.question_text) + "," + self.choice_text+"," + str(self.votes)