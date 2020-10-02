###### html2020-09-17 by Lee JaeOne

# Django Web Framework

> - Front-End에서는 DataBase로 부터 Data를 가져올 수 없다. 무조건 Back-End를 통해서 가져와야 한다.
> - Front-End의 경우는 `nginx라는 서버를 통해 접근 했지만, 장고는 **WAS**라는 서버를 통해 접근해야 한다.
> - 또한, 장고라는 Framework은 파이썬과 궁합이 아주 좋다!
> - 장고는 **MVT** 패턴으로 작동된다. **MVT**는 `model`, `view`, `template`을 지칭한다고 보면 된다.

![img](https://blog.kakaocdn.net/dn/pdQ3m/btqwhTpC3gU/vXB2IGfXViX7cGFQgXjlR1/img.png)



## (1) MVT 코딩 순서

> - 무엇을 먼저 코딩해야 하는지 정해진 순서는 없다. UI 화면을 생각하면서 로직을 풀어나가는 것이 쉬울때에는 보통 템플릿을 먼저 코딩한다. 아래의 순서는 큰 의미가 없기에 편한 것을 임의대로 진행해도 된다.
>
>   
>
>   	1. 프로젝트 뼈대 만들기
>    	2. 모델 코딩하기
>    	3. URLconf 코딩하기
>    	4. 템플릿 코딩하기
>    	5. 뷰 코딩하기





## (2) Django를 사용하기 위한 준비

> 1. 파이참을 실행한 후 interpreter를 `Anaconda`의 `python`으로 설정한다.
>
> 2. `Anaconda`의 `python`은 써드파티 앱이기에 `setting` - `Project:[프로젝트명]` - `Python Interpreter`에 차례대로 접속하여 `django`를 `Install Package`한다.
>
> 3. 파이참 실행 기본 화면의 `Terminal`을 클릭하여 `django-admin startproject [장고프로젝트명]`을 입력한다.
>
> 4. `dir/w`을 입력하여 현재 경로를 확인한다.
>
> 5. `cd [장고프로젝트명]`을 입력하여 `[장고프로젝트명]`의 디렉토리로 이동한다.
>
> 6. `python manage.py startapp [App의이름]`을 입력하여 `manage.py`와 같은 디렉토리에 `App의 이름`디렉토리를 생성한다.
>
>    
>
>    > 우리의 경우는
> >
>    >  [프로젝트명] : `websample` 
>    >
>    > [장고프로젝트명] : `djangoWEB`
>    >
>    > [App의이름] : `PollsApp`
>    





## (3) Django 특징

> - Django는 내장 DB로 `sqllite`를 사용한다. 나중에 사용자 임의로 DB를 바꿀수 있다.
>
> - 사용자가 웹 클라이언트에서 URL을 통해 App에 접근하게 된다. 이때 각각의 App은 Views를 가지고 있는데 사용자가 입력한 URL이 App의 View를 찾아 접근하는 방식인 것이다. 그러므로 URL이 App의 Views를 건들수 있도록 설정해 주어야 한다!! (말이 구구절절 너무어렵네요 ㅠ)
>
>   > 우리의 경우 App의 이름은 `polls`입니다!







## (4) Django를 통해 투표를 해봅시다!

###### 

### 1) `djangoWEB `> `djangoWEB` > `settings.py`

​		위 경로로 들어가서 아래 그림처럼 바꿔 준다

1. ```python
   ALLOWED_HOSTS = ['127.0.0.1', 'localhost']
   ```

2. ```python
   INSTALLED_APPS = [
       'django.contrib.admin',
       'django.contrib.auth',
       'django.contrib.contenttypes',
       'django.contrib.sessions',
       'django.contrib.messages',
       'django.contrib.staticfiles',
       'PollsApp',
   ]
   
   ```

3. ```python
   LANGUAGE_CODE = 'en-us'
   
   TIME_ZONE = 'Asia/Seoul'
   
   USE_I18N = True
   
   USE_L10N = True
   
   USE_TZ = True
   
   ```

   



### 2) `djangoWEB `> `djangoWEB` > `urls.py`

​		위 경로로 들어가서 아래처럼 지정해준다.

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('pools/', include('PollsApp.urls')),
]
```

- 위의 코드를 추가 시켜주었는데`polls`라는 App을 연결해주는 거라고 보면된다. 이렇게 연결을 하면 사용자의 request를 각각의 App의 `View`가 받아들여 사용자에게 반응을 해줄 수 있다.





### 3) `djangoWEB `> `PollsApp`> `urls.py` 생성

​		위 경로로 들어가 아래와 같이 코드를 작성해준다.

```python
from django.contrib import admin
from django.urls import path, include
from PollsApp import views

urlpatterns = [
    path('index/', views.index),
    path('<int:question_id>', viwes.choice, name='choice'),
    path('vote', views.vote, name='vote')
    path('result/', views.result, name='resutl'),
```

- **2)**에서 "`URL을 hello라는 App의 URL과 연결시킨다`" 라고 하였는데 `Polls`라는 App도 자기자신의`Views`와 연결을 해주어야 하기에 위와 같은 코드를 작성한다.

- ```python
  path('index/', views.index)
  ```
  
  path 중 하나만 설명하자면, 앞의 **'index/'**는 사용자인 내가 임의로 지정한 이름이고, **views.index**는 `PollsApp`내의 `views.py`가 가지고있는 `index`라는 함수를 지칭하는 것이다. 





### 4) `djangoWEB` > `PollsApp` > `views.py` 

###### MVT에서 V를 담당하는 부분이 `views.py` 입니다



- **3)**에서 사용자의 requst를 **views.index**, **views.choice**, **views.vote**, **views.result**를 통해 연결해 주었으니 `views.py`에 `index`, `choice`, `vote`, `result` 함수를 구현해주어야 한다.

- 또한, `PollsApp` 내의 `views.py`는

  1. 사용자의 `url request`

  2. DB를 다루는 `models.py`

  3. 사용자의 `request`에 대하여 홈페이지 화면으로 응답하기(보여주기)위해 구현된 `templates`

     

  위 세가지를 모두 연결하는 **장**이기에 코드가 복잡할 수 있다...ㅠ

```python
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse


from .models import *   # model.py로부터 모든 모델을 가져오겠다
### 이것은 DB를 다루는 model과 연결하기 위한 import이다.


def index(request):
    lists = Question.objects.all() # 여기서 Question은 model.py에 구현된 model이다.
    context = {'lists' : lists}
    return render(request, 'polls/index.html', context)


def choice(request, question_id):
    print('param question_id', str(question_id))
    lists = get_object_or_404(Question, pk=question_id)
    context = {'clist' : lists}
    return render(request, 'polls/choice.html', context)  ### polls/choice.html으로 context를 보내겟다!



def vote(request) :
    choice = request.POST['choice']
    question_id = request.POST['question_id']
    print('param value choice - ', str(choice))
    print('param value id - ', str(question_id))
    question = get_object_or_404(Question, pk=question_id)
    checked_choice = question.choice_set.get(pk=choice)
    checked_choice.votes += 1
    checked_choice.save()
    
    context = {}
    
    request.session['question_id'] = question_id
    return redirect('result')


def result(request):
    question_id = request.session['question_id']
    print('---------------------- views.result', question_id)
    question = get_object_or_404(Question, pk=question_id)
    context = { 'question' : question }
    return render(request, 'polls/result.html', context)
```





### 6) `djangoWEB` > `PollsApp` > `models.py` 

###### MVT에서 M을 담당하는 부분이 `model.py` 입니다.



- DB를 다루는 `models.py`를 구현해 주어야 한다. 
- `model.py`는 쉽게 설명하자면.. 홈페이지에 로그인을 할때, 등록된 사용자의 아이디와 비밀번호는가 DB이고, 그것을 관리하는 방법이 `model.py`에 구현되었다 라고 생각하면된다.



​	아래와 같이 코드를 작성하자.

		1. `question`은 투표를 하고자 하는 주제의 질문과 날짜를 Data로 입력받고 다루는 함수이다.
  		2. `choice`는 각각의 질문마다 선택지를 입력받고 투표수를 다루는 함수이다.

```python
from django.db import models

class Question(models.Model):
    question_text   = models.CharField(max_length=200) # char 타입의 필드로 200 사이즈
    regdate = models.DateTimeField('date pulished')        # dataTIME 타입 필드

    def __str__(self):  # str은 입력 받은 객체의 문자열 버전을 반환하는 함수
        return self.question_text+ "," + str(self.regdate)


class Choice(models.Model):
    # question 가지고 있는 키를 가지고 외래키를 삼아 만들고  cascade로 삭제될 때 같이 삭제한다.
    question_text = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200) # char 200 사이즈
    votes = models.IntegerField(default=0) # int 타입의 필드로 기본값이 0 으로한다.

    def __str__(self):  # str은 입력 받은 객체의 문자열 버전을 반환하는 함수
        return str(self.question_text) + "," + self.choice_text+"," + str(self.votes)
```





### 7) `djangoWeb` > `PollsApp` > `templates` > `polls`경로 생성

###### MVT에서 T를 담당하는 것이 `templpates` 입니다.



- `templete`은 **사용자에게 보여주는 홈페이지 화면**이라고 생각하면 편하다.

- 위 경로로 들어가서 아래에 보이는 세 가지 html 코드를 작성해 주어야 한다.



1. `choice.html`

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <title>Title</title>
   </head>
   <body>
       <h1> {{ clist.question_text }} </h1>
       <hr/>
   
       <form method="post" action="{% url 'vote' %}">
           {% csrf_token %}
           <input type="hidden" name="question_id" value="{{ clist.id }}" />
   
           {% for choice in clist.choice_set.all %}
           <input type="radio"
              name="choice"
              value="{{ choice.id }}">
   
           <label>{{ choice.choice_text }}</label><br/>
           {% endfor %}
           <p/>
           <input type="submit" value="VOTE">
       </form>
   </body>
   </html>
   ```

   

2. `index.html`

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <title>Title</title>
   </head>
   <body>
       {% if lists %}
       <ul>
           {% for question in lists %}
           <li><a href="../{{question.id}}"> {{ question.question_text }} </a></li>
           {% endfor %}
       </ul>
       {% else %}
           <p> 데이터가 존재하지 않습니다 </p>
       {% endif %}
   
   </body>
   </html>
   ```

   

3. `resutl.html`

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <title>Title</title>
   </head>
   <body>
       <h1> {{ questrion.question_text }} </h1>
       <hr/>
   
       <ul>
           {% for choice in question.choice_set.all %}
               <li>{{ choice.choice_text }} - {{ choice.votes }}</li>
           {% endfor %}
       </ul>
       <p/>
       <a href="{% url 'index' %}"> 처음 페이지로 이동 </a>
   
   </body>
   </html>
   ```

   