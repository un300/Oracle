




from django.contrib import admin
from django.urls import path, include
from PollsApp import views

urlpatterns = [
    path('index/', views.index, name='index'),
    path('<int:question_id>', views.choice, name='choice'),
    path('vote', views.vote, name='vote'),
    path('result/', views.result, name='result'),
]
