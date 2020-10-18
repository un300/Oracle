from django.shortcuts import render, HttpResponse
from .models import *

# Create your views here.

def index(request) :
    return render(request, 'manageApp/index.html')

def createTodo(request):
    user_input_str = request.POST['todoContent']
    new_todo = ToDo(content = user_input_str)
    new_todo.save()
    return HttpResponse('방금 입력한 문자열은 이거에요 : '+ user_input_str)