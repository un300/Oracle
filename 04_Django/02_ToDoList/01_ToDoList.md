# ToDoList 만들기 (개인실습)



## 1. Application 구성하기

> 1. Django를 install package한 후, `pycharm`의 `Terminal`에서 다음과 같이 입력한다. 아래의 과정은 Django 프로젝트를 만드는 과정이다.
>    
> - `django-admin startproject ToDoList`
>    
> 2. 그 후, `Termianl`에서 다음과 같이 입력하여 Application(이하 App)을 구성한다. 우리의 경우 App의 이름은 `my_to_do_app`이다.
>
>    - `python manage.py startapp my_to_do_app`
>
> 3.  `manage.py`와 같은 디렉토리에 존재하는 `ToDoList`의 하위디렉토리에 있는 `url.py`에서 33줄에있는 코드를 다음과 같이 바꾸어준다. 정확히는 'my_to_do_app'을 추가시킨다. (`ToDoList`는 1번에서 Django 프로젝트명을 만들어 줄때, 이름과 같다.)
>
>    ```python
>    INSTALLED_APPS = [
>        'django.contrib.admin',
>        'django.contrib.auth',
>        'django.contrib.contenttypes',
>        'django.contrib.sessions',
>        'django.contrib.messages',
>        'django.contrib.staticfiles',
>        'my_to_do_app',
>    ]
>    ```



## 2. URL 설정하기

> `1.Application 구성하기`를 통해 이번 `ToDoList`의 기본적인 세팅은 끝났다. 네이버와 같이 www.naver.com이라는 url을 지정하고 싶다면 추가적인 설정을 통해서 내가 원하는 url을 구현하여야 한다. 하지만 우리의 경우 따로 url을 지정하지 않고 기본 접속 url인 `http://127.0.0.1:8000`또는 `http://localhost:8000`을 사용한다. Django에서 앞서 나열한 기본 접속 URL은 ''(비어있는칸)으로 표현한다.
>
> 1. `manage.py`와 같은 디렉토리에 있는 `ToDoList`의 하위에 있는 `urls.py`에 접속하여 다음과 같이 코드를 작성한다.
>
>    ```python
>    from django.contrib import admin
>    from django.urls import path, include
>    
>    urlpatterns = [
>        path('admin/', admin.site.urls),
>        path('', include('my_to_do_app.urls'))
>    ]
>    ```
>
>    위의 `include`함수는 `my_to_do_app`이라는 Application을 새롭게 추가해 주었기 때문에 사용하는 함수이다. 그러므로 위에서 `import` 해주는 것을 볼 수 있다.
>
>    
>
> 2. 위 설정 후 `manage.py`와 같은 디렉토리에 있는 `my_to_do_app`에 `urls.py`를 생성해준다. 그리고 다음과 같은 코드를 작성한다.
>
>    ```python
>    from django.urls import path
>    from . import views
>    
>    urlpatterns = [
>        path('', views.index)
>    ]
>    
>    ```
>
>    
>
> 3. 다음으로 `my_to_do_app`의 하위디렉토리에 속해있는 `view.py`에서 index라는 함수를 다음과 같이 정의한다.
>
>    ```python
>    from django.shortcuts import render
>    from django.http import HttpResponse
>    
>    # Create your views here.
>    
>    def index(request):
>        return render(request, 'my_to_do_app/index.html')
>    
>    ```
>
>    
>
> 4. `my_to_do_app`의 하위 디렉토리에 `templates` - `my_to_do_app`이라는 두개의 중첩된 폴더경로를 만들어준다. 
>
>    이것은 `templates` 안에 Django 프로젝트과 같은 이름의 폴더를 만들어주는 꼴인데, Django는 `html`파일을 탐색할때, `templates`파일을 먼저 찾은 다음, 그 내부에서 Django프로젝트명과 같은 이름의 파일을 찾고 또 다시 그 내부의 `html`파일을 찾기 때문이다. 그러므로 위와 같이 경로를 만들어 준다. 
>
>    
>
> 5. `my_to_do_app` - `templates` - `my_to_do_app`의 하위에 책에서 제공해주는 `index.html`파일을 만들어준다.  `index.html`파일 코드는 다음과 같다.
>
>    사실 html코드는 프론트엔드 쪽이기 때문에 이책에선 다루지 않는다. 하지만 Django와 같은 Back-End를 전문적으로 다루기 위해서는 html, css과 같은 정적(static)페이지와 JavaScript와 같은 동적(Dynamic)페이지를 이해하고 다룰줄 알아야한다.
>
>    ```html
>    <html lang="ko">
>    <head>
>        <meta charset="UTF-8">
>    
>        <!-- Boot strap -->
>        <!-- 합쳐지고 최소화된 최신 CSS -->
>        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
>        <!-- 부가적인 테마 -->
>        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
>        <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
>        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
>    
>        <style>
>            .content{
>                height: 75%;
>            }
>            .messageDiv{
>                margin-top: 20px;
>                margin-bottom: 50px;
>            }
>            .toDoDiv{
>    
>            }
>            .custom-btn{
>                font-size: 10px;
>            }
>            .panel-footer{
>                height:10%;
>                color:gray;
>            }
>        </style>
>    
>        <title>To-Do</title>
>    </head>
>    <body>
>        <div class="container">
>            <div class="header">
>                <div class="page-header">
>                    <h1>To-do List <small>with Django</small></h1>
>                </div>
>            </div>
>            <div class="content">
>                <div class="messageDiv">
>                    <form action="" method="POST">{% csrf_token %}
>                        <div class="input-group">
>                            <input id="todoContent" name="todoContent" type="text" class="form-control" placeholder="메모할 내용을 적어주세요">
>                            <span class="input-group-btn">
>                                <button class="btn btn-default" type="submit">메모하기!</button>
>                            </span>
>                        </div>
>                    </form>
>                </div>
>    
>                <div class="toDoDiv">
>                    <ul class="list-group">
>    
>                        <form action="" method="GET">
>                            <div class="input-group" name='todo1'>
>                                <li class="list-group-item">메모한 내용은 여기에 기록될 거에요</li>
>                                <input type="hidden" id="todoNum" name="todoNum" value="1"></input>
>                                <span class="input-group-addon">
>                                    <button type="submit" class="custom-btn btn btn-danger">완료</button>
>                                </span>
>                            </div>
>                        </form>
>    
>                    </ul>
>                </div>
>            </div>
>            <div class="panel-footer">
>                실전예제로 배우는 Django. Project1-TodoList
>            </div>
>        </div>
>    </body>
>    </html>
>    ```
>
>    

