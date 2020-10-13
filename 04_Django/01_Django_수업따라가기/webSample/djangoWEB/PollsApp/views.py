from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse

from .models import *   # model.py로부터 모든 모델을 가져오겠다



# Create your views here.





def index(request):

    lists = Question.objects.all()  # lists는 리스트에 딕셔너리가 담겨져있는 형태로 구성되어있다. [{},{}] < 이런형식
    context = {'lists' : lists}

    return render(request, 'polls/index.html', context)



def choice(request, question_id):
    print('param question_id', str(question_id))
    lists = get_object_or_404(Question, pk=question_id)

    print('-' * 100)
    print(lists)
    print('-' * 100)

    context = {'clist' : lists}

    return render(request, 'polls/choice.html', context)  ### polls/choice.html으로 context를 보내겟다!



def vote(request) :

    choice = request.POST['choice']
    question_id = request.POST['question_id']
    print('param value choice - ', str(choice))
    print('param value id - ', str(question_id))

    question = get_object_or_404(Question, pk=question_id)
    checked_choice = question.choice_set.get(pk=choice)
    checked_choice.votes += 1
    checked_choice.save()

    context = {}

    request.session['question_id'] = question_id
    return redirect('result')
    # return HttpResponseRedirect(reverse('polls:result', args=(question.id, )))
    # return render(request, 'polls/result.html', context)


def result(request):
    question_id = request.session['question_id']
    print('---------------------- views.result', question_id)

    question = get_object_or_404(Question, pk=question_id)

    context = { 'question' : question }
    return render(request, 'polls/result.html', context)

    # 모델로부터 데이터를 가져오는 코드!
    # sql코드와 비교합니다 ㅎㅎ

    # select * from table ; << sql에서 테이블로부터 데이터를 이렇게 가져왔다면
    # > 모델이름.Objects.all()  <<  Django에서는 모델로부터 이렇게 데이터를 가져온다

    # select * from table where id = 1;
    # > 모델이름.objects.filter(id = 1) <<  또한 위 sql구문은 밑의 Django 구문과 같은 의미임

    # select * from table where id=1 and pwd=1;
    # > 모델이름.objects.filter(id=1, pwd=1)

    # select * from table where id=1 or pwd=1;
    # > 모델이름.objects.filter(Q(id=1) | Q(pwd=1))

    # select * from table where 칼럼이름 like '%공지%'     >   '공지'라는 문자를 포함하느냐
    # > 모델이름.objects.filter(칼럼이름_icontains='공지')
    # select * from table where 칼럼이름 like '공지%'     >    '공지'라는 문자로 시작하느냐
    # > 모델이름.objects.filter(칼럼이름_startswith='공지')
    # select * from table where 칼럼이름 like '%공지'      >    '공지'라는 문자로 끝이나느냐
    # > 모델이름.objects.filter(칼럼이름_endswith='공지')

    # insert into table values('')
    # > model(attr = value, attr = value .....)
    # > model.save()

    # delete 8 from table where id=1
    # > 모델이름.objects.get(id=1).delete()   >>  모델이름.objects.filter(id=1).delete()   >>> filter와 get은 반환하는 객체가 다르기 때문에 filter로 delete할 수 없음

    # update table set arrt=value where id=1
    # > obj = 모델이름.objects.get(id=1)
    # > obj.attr = '변경할 값'
    # > obj.save()
