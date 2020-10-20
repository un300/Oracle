from django.shortcuts import render, HttpResponse

# Create your views here.



def sendEmail(request):
    return HttpResponse('이메일 보낼꺼에요')