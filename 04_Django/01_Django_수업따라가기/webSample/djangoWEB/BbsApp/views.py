import json

from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, JsonResponse
# Create your views here.
from .models import *

import csv



def loginForm(request):
    if request.session.get('user_id'):
        context = {'id' : request.session['user_id'],
                   'name' : request.session['user_name']}   # > if session이 있는경우(로그인 되어있는 경우) 로그인 주소를 입력하면 이동하지 않는다는 구문을 추가해 준것임
        return render(request, 'home.html', context)

    return render(request, 'login.html')


def registerForm(request):
    return render(request, 'join.html')



def register(request):
    if request.method == 'POST':
        id = request.POST['id']
        pwd = request.POST['pwd']
        name = request.POST['name']

        # insert into table values('')
        # model(attr = value, attr = value ...)
        # -> model.save()

        register = BbsUserRegister(user_id=id, user_pwd=pwd, user_name=name)
        register.save()

    return redirect('loginForm')



def login(request):
    if request.method == 'GET':
        return redirect('login')
    elif request.method == 'POST':
        id = request.POST['id']
        pwd = request.POST['pwd']
        user = BbsUserRegister.objects.get(user_id=id, user_pwd=pwd)
        print('user result : ', user)
        context = {}
        if user is not None:
            request.session['user_name'] = user.user_name
            request.session['user_id'] = user.user_id
            context['name'] = request.session['user_name']
            context['id'] = request.session['user_id']

    return render(request, 'home.html', context)



def logout(request):
    request.session['user_name'] = {}
    request.session['user_id'] = {}
    request.session.modified = True
    return redirect('loginForm')


def list(request):

    # select * from table;
    # > modelName.objects.all()
    boards = Bbs.objects.all()
    print('boards result -', type(boards), boards)
    context = {'boards' : boards,
               'name' : request.session['user_name'],
               'id' : request.session['user_id']}
    return render(request, 'list.html', context)




def bbsRegisterForm(request):
    context = {'name': request.session['user_name'],
               'id': request.session['user_id']}
    return render(request, 'bbsRegisterForm.html', context)



def bbsRegister(request):
    if request.method == 'GET':
        return redirect('bbs_registerForm.html')
    elif request.method == 'POST':
        title = request.POST['title']
        content = request.POST['content']
        writer = request.POST['writer']

        board = Bbs(title = title, content = content, writer = writer)
        board.save()

    return redirect('bbs_list')


def bbsRead(request, id): # get방식으로
    print('param - ', id)
    # board = get_object_or_404(Bbs, pk=id) < 나는 이걸로 db작업함
    # 강사님이 알려주는 db작업코드


    board = Bbs.objects.get(id = id)
    board.viewcnt = board.viewcnt + 1
    board.save()

    context = {'board' : board,
               'name' : request.session['user_name'],
               'id' : request.session['user_id']}
    return render(request, 'read.html', context)


def bbsRemove(request):

    id = request.POST['id']
    board = Bbs.objects.get(id=id).delete()

    return redirect('bbs_list')


def bbsModifyForm(request):
    id = request.POST['id']

    board = Bbs.objects.get(id=id)
    context = {'board': board,
               'name': request.session['user_name'],
               'id': request.session['user_id']}

    # model
    return render(request, 'modify.html', context)



def bbsModify(request):

    id = request.POST['id']
    title = request.POST['title']
    content = request.POST['content']

    board = Bbs(id=id, title=title, content=content)
    board.save()
    return redirect('bbs_list')



## ajax - json
def bbsSearch(request):
    print('------------------   ajax json bbsSearch')
    type = request.POST['type']
    keyword = request.POST['keyword']
    print('type : ', type, 'keyword :', keyword)

    # model 작업
    # select * from table where title like %공지%
    # modelName.objects.filter(subject_icontains = '공지')
    # select * from table where title like 공지%
    # modelName.objects.filter(subject_startswith = '공지')
    if type == 'title':
        boards = Bbs.objects.filter(title__startswith=keyword)
    if type == 'writer':
        boards = Bbs.objects.filter(writer__startswith=keyword)
    print('ajax -- result : ', boards)

    data = []
    for board in boards :
        data.append({
            'id'        : board.id,
            'title'     : board.title,
            'writer'    : board.writer,
            'regdate'   : board.regdate,
            'viewcnt'   : board.viewcnt
        })

    return JsonResponse(data, safe=False)



def csvToModel(request):
    path = 'C:/csv/seop.csv'
    file = open(path)
    reader = csv.reader(file)
    print('----', reader)
    list = []
    for row in reader:
        print(row)
        list.append(Seops(name  = row[0],
                         img    = row[1],
                         status = row[2]))
    Seops.objects.bulk_create(list)
    return HttpResponse('create model')


def csvUpload(request):
    file = request.FILES['csv_file']
    print('----', file)
    if not file.name.endswith('.csv'):
        return redirect('loginForm')
    result_file = file.read().decode('utf-8').splitlines()
    print('result_file', result_file)

    reader = csv.reader(result_file)
    list =[]
    for row in reader:
        print('---------', row)
        list.append(Seops(name  = row[0],
                          img   = row[1],
                          status= row[2]))

    file.close()
    Seops.objects.bulk_create(list)
    return redirect('loginForm')
