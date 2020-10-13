from django.shortcuts import render, HttpResponse

from .models import *

# Create your views here.



def index(request) :
    # return HttpResponse('<div align=center>섭이와 함께하는 Django WEB Framework</div>')
    return render(request, 'hello/index.html')


def hi(request):
    context = {'ment' : '여기까지 잘 되시나요? 쉬는시간 가질까요?'}
    return render(request, 'hello/ok.html', context)


def login(request):
    if request.method == 'POST':
        id      = request.POST['id']
        pwd     = request.POST['pwd']

        # select * from testUser where id = id ;
        user    = TestUser.objects.get(user_id = id)

        context = {}
        if user is not None:
            context['user'] = user
        return render(request, 'hello/success.html', context)



        # context = {'id' : id, 'pwd' : pwd}
        # return render(request, 'hello/success.html', context)