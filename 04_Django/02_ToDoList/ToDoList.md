# ToDoList

> ToDoList를 만들어 봅시다



## 1. Django 세팅하기

> Django를 인스톨한 상태이서 진행해야 합니다.
>
> 1. teminal 창에서 `django-admin startproject ToDoList`를 입력한다.
>
>    다음 `cd ToDoList`를 입력하여 경로를 바꾸어준다.
>
>    여기서 `ToDoList`는 지금 진행하고자 하는 장고프로젝트 명이다.
>
>    
>
> 2. teminal 창으로 돌아와서 `python manage.py startapp manageApp`을 입력한다.
>
>    여기서 `manageApp`은 Django의 MVT 패턴에서 V를 가지고 있는 Application이다.
>
>    
>
> 3. `ToDoList` > `ToDoList`에 있는 `settings.py`에서 다음과 같이 코드를 추가한다.
>
>    ```python
>    INSTALLED_APPS = [
>        'django.contrib.admin',
>        'django.contrib.auth',
>        'django.contrib.contenttypes',
>        'django.contrib.sessions',
>        'django.contrib.messages',
>        'django.contrib.staticfiles',
>        'manageApp',  ## 이것을 입력해주자
>    ]				  ## V(Views)를 가지고 있는 App의 이름을 입력해 주는 것이다.
>    ```





## 2. URL 설정하기

> 사용자가 홈페이지에서 요청을 보낼때, `manageApp`이 가지고 있는 `Views`를 URL로 연결해 주어야 한다.
>
> 1. 우선 `ToDoList` > `ToDoList`에 있는 `urls.py`에서 다음과 같이 입력해주자
>
>    ```python
>    from django.contrib import admin
>    from django.urls import path, include ## 내가 추가해준것
>    
>    urlpatterns = [
>        path('admin/', admin.site.urls),
>        path('manage/', include('manageApp.urls'))  ## 내가 추가해준것
>    ]
>    ```
>
>    설명을 덧 붙이자면, ` path('manage/', ...)`이기 때문에
>
>     사용자가 앞서 만든 `mangeApp`을 사용하기 위해서는 다음과 같은 url로 접근해야한다. 
>
>    ```http
>    http://localhost:8000/manage/
>    ```
>
>    이 과정은 사용자의 request를 `manageApp`으로 보내주는 과정이라고 생각하면 된다.
>
> 
>
> 2. 다음으로 `ToDoList` > `manageApp` 폴더에 `urls.py`파일을 만들고 다음과 같이 입력한다.
>
>    ```python
>    from django.urls import path
>    from manageApp import views   ## manageApp 폴더에 있는 views.py모듈을 							      ## 임포트 하겟다 
>    urlpatterns = [
>        path('', views.index)     ## manage.py 폴더에 view.py에 있는 함수인
>    ]							  ## index함수를 사용한다
>    ```
>
>    
>
> 3.  이제 manageApp 폴더에 있는 `view.py`에 사용할 함수를 정의해 줄것이다.
>
>    ```python
>    from django.shortcuts import render, HttpResponse  ## 내가 추가해준것
>    
>    # Create your views here.
>    
>    def index(request) :  ## 내가추가해준함수
>        return HttpResponse('안녕하세요 ㅎㅎ')
>    ```
>
>    
>
> 4.  `python manage.py runserver`를 입력한다.
>
>    이까지 잘 따라왔다면, 크롬에서 `http://localhost:8000/manage/`입력시
>
>    다음과 같은 화면이 나타날 것이다.
>
>    
>
>    
>
>    ![ToDoList01](./마크다운이미지/
>
>    ToDoList01.PNG)