from django.shortcuts import render, HttpResponse, HttpResponseRedirect
from django.urls import reverse
from .models import *

# Create your views here.

def index(request) :
    todos = ToDo.objects.all()
    content = {'todos' : todos}
    return render(request, 'manageApp/index.html', content)

def createTodo(request):
    user_input_str = request.POST['todoContent']
    new_todo = ToDo(content = user_input_str)
    new_todo.save()
    return HttpResponseRedirect(reverse('index'))

def deleteTodo(request):
    done_todo_id = request.GET['todoNum']
    print('완료한 todo의 id :', done_todo_id)

    todo = ToDo.objects.get(id = done_todo_id)
    todo.delete()

    return HttpResponseRedirect(reverse('index'))