from django.shortcuts import render, HttpResponse

# Create your views here.


def index(request):
    return render(request, 'ShareApp/index.html')

def categoryCreate(request):
    return render(request, 'ShareApp/categoryCreate.html')

def restaurantCreate(request):
    return render(request, 'ShareApp/restaurantCreate.html')

def restaurantDetail(request):
    return render(request, 'ShareApp/restaurantDetail.html')
