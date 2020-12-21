import datetime
import json

import tensorflow.keras.backend as K
from django.contrib.auth.hashers import make_password, check_password
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse
from django.shortcuts import render, redirect, HttpResponseRedirect, reverse
# tensorflow
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.utils import get_custom_objects

from .models import Signup, Photo, Comment_posting, Comment_report, Like


# Create your views here.

######################################################################
##### 악플탐지봇
# Mish 활성화 함수
def mish(x):
    return x * K.tanh(K.softplus(x))



def bad_comment_detector(comment):
    # 단어사전 불러오기
    word_index_json = open('loginApp/model/word_index_vocab.json', 'r', encoding='UTF-8-SIG').read()
    word_index_vocab = json.loads(word_index_json)
    tokenizer = Tokenizer()
    tokenizer.word_index = word_index_vocab
    get_custom_objects().update({'mish': mish})
    loaded_model = load_model('loginApp/model/1D_CNN_best.h5')
    comment_list = [list(comment)]
    comment_label = tokenizer.texts_to_sequences(comment_list)
    comment_pad = pad_sequences(comment_label, padding='post', maxlen=400)
    prob = loaded_model.predict(comment_pad)[0][0]
    if prob < 0.35:
        return 0, prob
    else:
        return 1, prob
#############################################################################



def index(request):
    return render(request, 'loginApp/index.html')


def signup(request):
    if request.method == 'POST' :
        input_name        = request.POST['fullname']
        input_email       = request.POST['email']
        input_password    = request.POST['passsword']
        input_re_password = request.POST['re_passsword']



        if input_password != input_re_password:
            error = '비밀번호가 일치하지 않습니다'
            return render(request, "loginApp/index.html", {'error' : error})

        elif ' ' in input_name :
            error = '이름에 빈칸이 포함되어 있습니다'
            return render(request, "loginApp/index.html", {'error': error})

        else :
            exist_email = Signup.objects.filter(user_email = input_email)
            exist_name = Signup.objects.filter(user_name = input_name)

            if exist_name :
                error = '닉네임이 존재합니다'
                return render(request, "loginApp/index.html", {'error' : error})
            elif exist_email:
                error = '이메일이 존재합니다'
                return render(request, "loginApp/index.html", {'error': error})

            else:
                database = Signup(user_email        = input_email,
                                  user_pwd          = make_password(input_password),
                                  user_name         = input_name,
                                  user_image        = '/user_image/default.jpg',
                                  penalty_count     = 0,
                                  comment_count     = 0,
                                  bad_comment_ratio = 0,
                                  about             = '소개를 입력하세요',)
                database.save()
                flag = 1
                return render(request, "loginApp/index.html", {'flag': flag})


def login(request):
    context= {}
    if request.method == 'GET':
        return HttpResponseRedirect(reverse('index'))
    elif request.method == 'POST':
        input_email = request.POST['email']
        input_password = request.POST['pwd']

        try :
            user_db = Signup.objects.get(user_email = input_email)
        except :
            user_db = False

        if not (input_email and input_password):
            context['error'] = '아이디와 비밀번호를 모두 입력해주세요'
            return render(request, 'loginApp/index.html', context)
        elif user_db == 0:
            context['error'] = '존재하지 않는 아이디 입니다'
            return render(request, 'loginApp/index.html', context)
        else :
            if check_password(input_password, user_db.user_pwd) :
                request.session['user_name'] = user_db.user_name
                return redirect('photo_list')
            else :
                context['error'] = '비밀번호를 틀렸습니다.'
                return render(request, 'loginApp/index.html', context)

def logout(request):
    request.session['user_name'] = {}
    request.session.modified = True
    return redirect('index')


def posting(request):
    context = {}
    if request.method == 'POST':
        author             = request.session['user_name']
        comment            = request.POST['comment']

        user_image = Signup.objects.get(user_name = author)

        try:
            uploaded_image = request.FILES['image']
            fs = FileSystemStorage()
            name = fs.save(uploaded_image.name, uploaded_image)
            image_url = fs.url(name)
        except:
            image_url = '/media/None/None.png'

        created = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        Photo.objects.create(
            author          = author,
            comment         = comment,
            image           = image_url,
            post_user_image = '/media/' + str(user_image.user_image),
            like            = 0,
            created         = created,

        )

    return redirect('photo_list')



def photo_list(request):
    photo_lists = Photo.objects.all()
    pk_num_list = [str(post.pk_num) for post in photo_lists]

    comment_list = Comment_posting.objects.all()
    user_name = request.session['user_name']

    user_db = Signup.objects.get(user_name = user_name)
    user_image = '/media/' + str(user_db.user_image)

    comment_pk_num = [row.comment_pk_num for row in comment_list]

    # 팝업을 위한 Signup 모델 호출
    popup_db = Signup.objects.all()
    context = {
        'user_name'           : user_name,
        'user_image'          : user_image,
        'post_lists'          : photo_lists,
        'comment_list'        : comment_list,
        'pk_num_list'         : json.dumps(pk_num_list),
        'comment_pk_num'      : json.dumps(comment_pk_num),
        'popup_db'            : popup_db,
        'user_db'             : user_db,
    }
    return render(request, 'loginApp/home.html', context)





def comment_create(request):
    if request.method == 'POST':
        post_pk_num = request.POST['post_pk_num']
        current_id = request.POST['writer']
        comment_content = request.POST['comment']
        created = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        bad_comment_bool, temp_bad_comment_prob = bad_comment_detector(comment_content)
        bad_comment_prob = str(round(temp_bad_comment_prob, 3))

        user_id = Signup.objects.get(user_name = current_id)
        current_id_image = user_id.user_image


        DB = Comment_posting(post             = post_pk_num,
                             comment_id       = current_id,
                             comment_id_image = '/media/' + str(current_id_image),
                             comment          = comment_content,
                             created          = created,
                             bad_comment_bool = bad_comment_bool,
                             bad_comment_prob = bad_comment_prob,)
        DB.save()

        user_db = Signup.objects.get(user_name = current_id)
        user_db.penalty_count         += bad_comment_bool
        user_db.comment_count         += 1
        user_db.bad_comment_ratio      = str(round(user_db.penalty_count / user_db.comment_count, 3))
        user_db.save()

        last_comment = Comment_posting.objects.order_by('comment_pk_num').last()
        temp_comment_pk_num = Comment_posting.objects.all()
        comment_pk_num = [element.comment_pk_num for element in temp_comment_pk_num]

        # 레이어 팝업을 위한 유저정보(댓글수, 악플게시수, 악플확률) 가져오기
        layer_user_db = Signup.objects.get(user_name = current_id)
        user_name         = current_id
        user_email        = layer_user_db.user_email
        penalty_count     = layer_user_db.penalty_count
        comment_count     = layer_user_db.comment_count
        bad_comment_ratio = layer_user_db.bad_comment_ratio
        about             = layer_user_db.about

        res = {
            'current_id'           : current_id,
            'current_id_image'     : '/media/' + str(current_id_image),
            'comment_content'      : comment_content,
            'created'              : created,
            'bad_comment_bool'     : bad_comment_bool,
            'last_comment_pk_num'  : last_comment.comment_pk_num,
            'comment_pk_num'       : json.dumps(comment_pk_num),
            'bad_comment_prob'     : bad_comment_prob,
            'user_name'            : user_name,
            'user_email'           : user_email,
            'penalty_count'        : penalty_count,
            'comment_count'        : comment_count,
            'bad_comment_ratio'    : bad_comment_ratio,
            'about'                : about,
        }
    return HttpResponse(json.dumps(res), content_type="application/json")



def comment_delete(request):
    if request.method == "POST":
        comment_pk = request.POST['comment_pk']

        DB = Comment_posting.objects.get(comment_pk_num = str(comment_pk))
        DB.delete()

        res2 = {
            'comment_pk' : comment_pk,
        }

    return HttpResponse(json.dumps(res2), content_type="application/json")




def convert(request):
    photo_lists = Photo.objects.all()
    pk_num_list = [str(post.pk_num) for post in photo_lists]

    comment_list = Comment_posting.objects.all()
    user_name = request.session['user_name']
    user_db = Signup.objects.get(user_name = user_name)
    user_image = '/media/' + str(user_db.user_image)

    comment_pk_num = [row.comment_pk_num for row in comment_list]

    # 팝업을 위한 Signup 모델 호출
    popup_db = Signup.objects.all()

    context = {
        'user_name'           : user_name,
        'user_image'          : user_image,
        'post_lists'          : photo_lists,
        'comment_list'        : comment_list,
        'pk_num_list'         : json.dumps(pk_num_list),
        'comment_pk_num'      : json.dumps(comment_pk_num),
        'popup_db'            : popup_db,
        'user_db'             : user_db,
    }
    return render(request, 'loginApp/home_no_model.html', context)




def profile_img(request):
    if request.method == 'POST':
        user_id         = request.session['user_name']

        try:
            new_profile_img = request.FILES['profile_image']
        except:
            return redirect('photo_list')

        user_db = Signup.objects.get(user_name = user_id)
        user_db.user_image = new_profile_img
        user_db.save()

        comment_db = Comment_posting.objects.filter(comment_id=user_id)
        comment_db.update(comment_id_image = '/media/user_image/' + str(new_profile_img))

        photo_db = Photo.objects.filter(author = user_id)
        photo_db.update(post_user_image = '/media/user_image/' + str(new_profile_img))

        return redirect('photo_list')


def introduce(request):
    return render(request, 'loginApp/user_detail.html')


def user_popup(request):
    if request.method == 'POST':
        user_name = request.session['user_name']

        user_db = Signup.objects.get(user_name = user_name)
        penalty_count = user_db.penalty_count
        user_email    = user_db.user_email

        res3 = {
            'user_name'     : user_name,
            'user_email'    : user_email,
            'penalty_count' : penalty_count,
        }

        return HttpResponse(json.dumps(res3), content_type="application/json")



def comment_report(request, id):
    report_comment = Comment_posting.objects.get(comment_pk_num = id)

    context = {
        'report_comment' : report_comment.comment,
        'comment_pk_num' : report_comment.comment_pk_num
    }
    return render(request, 'loginApp/comment_report.html', context)



def comment_report_save(request):
    if request.method == 'POST':
        comment_pk_num = request.POST['comment_pk_num']
        customer_check_point = request.POST['optionsRadios']
        customer_opinion = request.POST['customer_opinion']

        comment_db = Comment_posting.objects.get(comment_pk_num = comment_pk_num)
        comment = comment_db.comment

        print(comment)
        print(comment_pk_num)
        print(customer_check_point[-1])
        print(customer_opinion)

        comment_report_db = Comment_report(comment = comment,
                                           comment_pk_num = comment_pk_num,
                                           customer_check_point = customer_check_point[-1],
                                           customer_opinion = customer_opinion)
        comment_report_db.save()


        return redirect('photo_list')




def post_erase(request):
    if request.method == "POST":
        post_pk_num = request.POST['post_pk_num']
        photo_db = Photo(pk_num = post_pk_num)
        photo_db.delete()

        context = {
            'post_pk_num' : post_pk_num
        }

        return HttpResponse(json.dumps(context), content_type="application/json")




def like(request):
    if request.method == 'POST':
        post_pk_num = request.POST['post_pk_num']
        current_user_name = request.POST['current_user_name']

        post_like = Like.objects.filter(post_pk_num = post_pk_num)

        post_like_count = len(post_like)

        like_db = Like.objects.filter(post_pk_num=post_pk_num).filter(user_id=current_user_name)
        if like_db:
            like_db.delete()
            photo_like = Photo.objects.get(pk_num = post_pk_num)
            photo_like.like = post_like_count - 1
            photo_like.save()
        else :
            for_save = Like(post_pk_num = post_pk_num,
                            user_id     = current_user_name)
            for_save.save()
            photo_like = Photo.objects.get(pk_num=post_pk_num)
            photo_like.like = post_like_count + 1
            photo_like.save()

        context = {
            'post_like_count' : post_like_count
        }

        return HttpResponse(json.dumps(context), content_type="application/json")




def about(request):
    current_user = request.session['user_name']

    user_db = Signup.objects.get(user_name = current_user)
    about = user_db.about

    print(current_user)
    print(about)

    context = {
        'about'     : about,
    }
    return render(request, 'loginApp/about.html', context)



def about_change(request):
    if request.method == 'POST':
        about_content = request.POST['about_content']
        current_user = request.session['user_name']


        user_db = Signup.objects.get(user_name = current_user)
        user_db.about = about_content
        user_db.save()

        return redirect('photo_list')





