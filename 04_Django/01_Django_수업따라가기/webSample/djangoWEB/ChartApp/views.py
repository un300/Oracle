from django.shortcuts import render

# Create your views here.


def intro(request):
    return render(request, 'chart_index.html')

def line(request):
    seoul = [7.0, 6.9, 9.5, 14.5, 7.0, 6.9, 9.5, 14.5, 7.0, 6.9, 9.5, 14.5]
    london = [8.0, 9.9, 2.5, 11.5, 3.0, 4.9, 8.5, 12.5, 4.0, 4.9, 5.5, 10.5]
    context = {'seoul' : seoul, 'london' : london}
    return render(request, 'chart_line.html', context)



def bar(request):

    africa  = [107, 31, 635, 203, 2]
    america = [133, 156, 947, 408, 6]
    asia    = [814, 841, 3714, 727, 31]
    europe  = [1216, 1001, 4436, 738, 40]

    context = {'africa': africa, 'america': america, 'asia' : asia, 'europe' : europe}
    return render(request, 'chart_bar.html', context)



def wordcloud(request):
    txt = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean bibendum erat ac justo sollicitudin, quis lacinia ligula fringilla. Pellentesque hendrerit, nisi vitae posuere condimentum, lectus urna accumsan libero, rutrum commodo mi lacus pretium erat. Phasellus pretium ultrices mi sed semper. Praesent ut tristique magna. Donec nisl tellus, sagittis ut tempus sit amet, consectetur eget erat. Sed ornare gravida lacinia. Curabitur iaculis metus purus, eget pretium est laoreet ut. Quisque tristique augue ac eros malesuada, vitae facilisis mauris sollicitudin. Mauris ac molestie nulla, vitae facilisis quam. Curabitur placerat ornare sem, in mattis purus posuere eget. Praesent non condimentum odio. Nunc aliquet, odio nec auctor congue, sapien justo dictum massa, nec fermentum massa sapien non tellus. Praesent luctus eros et nunc pretium hendrerit. In consequat et eros nec interdum. Ut neque dui, maximus id elit ac, consequat pretium tellus. Nullam vel accumsan lorem.'
    context = {'txt' : txt}
    return render(request, 'chart_wordcloud.html', context)



def ajax(request):
    return render(request, 'chart_ajax.html')