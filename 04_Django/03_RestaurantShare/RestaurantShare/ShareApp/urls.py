from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.index),
    path('categoryCreate/', views.categoryCreate),
    path('restaurantDetail/', views.restaurantDetail),
    path('restaurantCreate/', views.restaurantCreate),
]
