###### 2020-09-17 by Lee JaeOne

# Django Web Framework

> - Front-End에서는 DataBase로 부터 Data를 가져올 수 없다. 무조건 Back-End를 통해서 가져와야 한다.
> - Front-End의 경우는 `nginx라는 서버를 통해 접근 했지만, 장고는 **WAS**라는 서버를 통해 접근해야 한다.
> - 또한, 장고라는 Framework은 파이썬과 궁합이 아주 좋다!
> - 장고는 **MVT** 패턴으로 작동된다. **MVT**는 `model`, `view`, `template`을 지칭한다고 보면 된다.

![image-20200917092036654](C:\Users\lan41\Desktop\마크다운정리\MVT)





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
> 6. `python manage.py startapp HelloApp`을 입력하여 `manage.py`와 같은 디렉토리에 `HelloApp`디렉토리를 생성한다.
>
>    
>
>    > 우리의 경우는 [프로젝트명] : `websample` / [장고프로젝트명] : `djangoWEB`
>
>    





## (3) Django 특징

> - Django는 내장 DB로 `sqllite`를 사용한다. 나중에 사용자 임의로 DB를 바꿀수 있다.
>
> - 사용자가 웹 클라이언트에서 URL을 통해 App에 접근하게 된다. 이때 각각의 App은 Views를 가지고 있는데 사용자가 입력한 URL이 App의 View를 찾아 접근하는 방식인 것이다. 그러므로 URL이 App의 Views를 건들수 있도록 설정해 주어야 한다!! (말이 구구절절 너무어렵네요 ㅠ)
>
>   > 우리의 경우 App의 이름은 `helloApp`입니다!







## (4) URL과 App의 View를 설정해 줍시다!

###### M.V.T 에서 V(View)를 만들어줍니다!



### 1) `djangoWEB `> `djangoWEB` > `settings.py`

​		위 경로로 들어가서 아래 그림처럼 바꿔 준다

1. 

![image-20200917131503549](C:\Users\lan41\Desktop\마크다운정리\멀캠수업정리\장고\01_Django Web Framework.assets\image-20200917131503549.png)

2. ![image-20200917131617693](C:\Users\lan41\Desktop\마크다운정리\멀캠수업정리\장고\01_Django Web Framework.assets\image-20200917131617693.png)



3. ![image-20200917131634623](C:\Users\lan41\Desktop\마크다운정리\멀캠수업정리\장고\01_Django Web Framework.assets\image-20200917131634623.png)



### 2) `djangoWEB `> `djangoWEB` > `urls.py`

​		위 경로로 들어가서 아래처럼 지정해준다.

![image-20200917132115856](C:\Users\lan41\Desktop\마크다운정리\멀캠수업정리\장고\01_Django Web Framework.assets\image-20200917132115856.png)

```python
path('hello/', include('helloApp.urls'))
```

- 위의 코드를 추가 시켜주었는데 `URL을 hello라는 App의 URL과 연결시킨다`라는 의미이다.





### 3) `djangoWEB `> `helloApp`> `urls.py` 만들기

​		위 경로로 들어가 아래와 같이 코드를 작성해준다.

```python
from django.contrib import admin
from django.urls import path, include
from helloApp import views

urlpatterns = [
    path('index/', views.index),
    path('hi/', views.hi),
    path('login/', views.login, name='login')
```

- **2)**에서 "`URL을 hello라는 App의 URL과 연결시킨다`" 라고 하였는데 `hello`라는 App입장에서도 url을 연결 시켜야하기에 위과 같은 코드를 작성 하는 것이다.

