from django.contrib import admin

from .models import *

# Register your models here.
# models.py에서 구현한 model의 클래스를 여기에서 허가해주는 것이라 보면된다



admin.site.register(Question)
admin.site.register(Choice)



# 위 코드 작성후
# python manage.py makemigrations : table을 만드는 것이러 보면되요
# python manage.py migrate를 teminal에 타이핑 ㄱㄱ
# 그런다음 관리자 계정으로 로그인하여 만들어진 테이블을 관리하여야 합니다.
# 그럴러면 python manage.py runserver를 실행하고
# http://localhost:8000/admin 에 접속해 테이블을 관리할 것이다
# 우리는 몇가지 질문을 table로 관리하고 웹에 질문들을 띄워보자










