###### 2020-10-15 목요일

###### 2020-10-16 금요일

###### by Lee-JaeWon



# ToDoList (2)



## 1. M(model) 사용하기

> MVT 패턴에서 Model에 해당하는 M이다. model은 (sql같은) 데이터베이스에서 Table에 해당한다고 생각하면 된다.
>
> 1. `ToDoList` > `manageApp` > `model.py` 에서 다음과 같이 코드를 작성해본다.
>
>    ```python
>    from django.db import models
>    
>    # Create your models here.
>    
>    class Todo(models.Model):
>    	content = models.CharField(max_length = 255)
>    ```
>
>    위의 ToDo 라는 클레스 이름은 하나의 Model, (sql로 따지자면 하나의 테이블)이라고 생각하면 될 것이다.
>
>    위 ToDo 클래서는 `content`라는 문자열 칼럼을 가지는 모델(=테이블)이다.
>
> 2. model 클래스 (sql로 따지면 하나의 테이블)을 만들면, `migration`이라는 작업을 해주어야 한다. terminal창에서 다음과 같이 입력하자.
>
>    아 그리고 밑의 작업은 `python manage.py runserver`가 실행되고 있지 않은 상태에서 진행하여야 한다.
>
>    만약 서버가 실행 중이라면 `ctrl + c`를 눌러 서버를 종료시킨후 아래 코드를 작성하라.
>
>    ```python
>    python manage.py makemigration    # 새롭게 만든 model을 생성하는 작업
>    python manage.py migrate          # 새롭게 만든 model을 장고프로젝트 데이터베이스에 실제로 적용하는 작업
>    ```
>
> 3.  위의`migrate`작업을 완료했다면 teminal 창에서 다음 보이는 코드를 입력하여 내가만든 ToDo 모델이 장고프로젝트 데이터베이스에 적용되었는지 확인해보자
>
>    ```python
>    python manage.py dbshell
>    .table
>    ```
>
>    위 코드를 입력했다면 다음과 같은 결과를 얻을 수 있다.
>
>    ![ToDoList04](./마크다운이미지/ToDoList04.PNG)
>
>    `manageApp_todo`는 방금 migrate한 모델이름이고, 나머지는 Django에서 제공해주는 기본 모델(=테이블)이라고 생각하면 된다.





## 2. 만들어진 `Todo` Model(M)에 데이터 입력하기

> 지금까지 우리는 아무런 기능도 수행할 수 없는 그럴듯한 홈페이지를 만들었다.
>
> 이제 홈페이지에서 데이터를 입력하여 Todo 모델에 저장하는 작업을 진행해보자.
>
> 1. `ToDoList` > `manageApp` > `templates` > `manageApp` > `index.html`로 들어가서 44번째 줄에 있는 `<form>`테그를 찾아보자.
>    - 기본적으로 html에서는 서버로 데이터를 전달할 때, `<form>`테그로 감싸야 한다. 그리고 이 `<form>`테그 안에는 데이터를 서버로 제출하는 `button`이 존재하며, 직접 전송되어지는 데이터가 담기는 `input`(46번째 줄)이 존재한다.
>    - 우리가 직접 건드릴 곳은 `<form>`테그의 `action`과 `method`이다. 
>    - (1) `method`
>      - 먼저 `method`에는 크게 `get`방식과 `post`방식이 존재하는데, 먼저 알아야 할 것은 `post`방식 일때, `{% csrf_token %}`을 적어주여야 한다.
>      - 로그인을 예로들어 `get`과 `post`를 설명해 보자.
>      - 로그인 방법을 `get`방식으로 지정하면, url에 아이디와 비밀번호가 노출이 된다. 즉, `get`방식은 입력값이 url에 노출이 되는 방식인 것이다.
>      - 반대로 `post`방식은 노출이 되지않는다. 그래서 로그인은 `post`를 사용하는 것이다.
>    - (2) `action`
>      - `action`은 서버로 데이터를 전달할 때, 어떠한 경로로 url로 전달할 것인지를 나타낸다.
>      - 즉, `action`에 적어주는 경로로 데이터가 전달되는 것이다.
>
> 2. 44번째줄 `<fomr>`테그에 존재하는`action`을 다음과 같이 변경해주자
>
>    ```html
>    <form action="./createTodo" method="POST">{% csrf_token %}
>    ```
>
> 3. 그다음 `python manage.py runserver`를 입력하여 서버를 실행시킨 후, 메모하기 버튼을 눌러보면 다음과 같은 화면이 나타날 것이다.
>
>    ![ToDoList05](./마크다운이미지/ToDoList05.PNG)
>
>    `Page not found (404)`에러는 페이지가 없어서 나타나는 에러이다. 아직 우리는 페이지를 만들지 않았기 때문에 에러가 나타나는건 당연한 일이니 놀라지마시라
>
>    `Page not found (404)`에러는 Django를 다루면서 앞으로 자주보게될 에러이다.