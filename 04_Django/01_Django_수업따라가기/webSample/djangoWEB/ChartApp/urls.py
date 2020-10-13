




from django.contrib import admin
from django.urls import path, include
from ChartApp import views

urlpatterns = [
    path('index/', views.intro, name='index'),
    path('line/', views.line, name='line'),
    path('bar/', views.bar, name='bar'),
    path('wordcloud/', views.wordcloud, name='wordcloud'),
    path('ajax/', views.ajax, name='ajax'),
]












