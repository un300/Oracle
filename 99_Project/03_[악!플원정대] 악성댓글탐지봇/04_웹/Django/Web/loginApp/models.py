from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class Signup(models.Model):
    user_email        = models.CharField(max_length=50, unique=True)
    user_pwd          = models.CharField(max_length=20)
    user_name         = models.CharField(max_length=10, primary_key=True, unique=True)
    user_image        = models.ImageField(upload_to='user_image/')
    penalty_count     = models.IntegerField()
    comment_count     = models.IntegerField()
    bad_comment_ratio = models.FloatField()
    about             = models.CharField(max_length=300)

    def __str__(self):  # localhost:8000/admin에서 나타날문자
        return self.user_name

    class Meta:
        db_table = 'user_db'




class Photo(models.Model):
    pk_num          = models.AutoField(primary_key=True, unique=True)
    author          = models.CharField(max_length=50)
    comment         = models.TextField(blank=True)
    image           = models.ImageField(blank=True)
    post_user_image = models.CharField(max_length=200)
    created         = models.CharField(max_length=50)
    like            = models.IntegerField()

    def __str__(self):
        return "comment : " + self.comment

    class Meta:
        db_table = 'photo_db'
        ordering = ['-created']



class Comment_posting(models.Model):
    comment_pk_num   = models.AutoField(primary_key=True, unique=True)
    post             = models.IntegerField()
    comment_id       = models.CharField(max_length=50)
    comment_id_image = models.CharField(max_length=200)
    comment          = models.TextField(max_length=400)
    created          = models.CharField(max_length=50)
    bad_comment_bool = models.IntegerField()
    bad_comment_prob = models.CharField(max_length=10)

    def __str__(self):
        return "comment_pk_num : " + self.comment_id

    class Meta:
        db_table = 'comment_db'
        ordering = ['created']


class Comment_report(models.Model):
    comment              = models.CharField(max_length=400)
    comment_pk_num       = models.IntegerField()
    customer_check_point = models.IntegerField()
    customer_opinion     = models.CharField(max_length=400)

    def __str__(self):
        return "comment : " + self.comment

    class Meta:
        db_table = 'report_db'



class Like(models.Model):
    post_pk_num  = models.IntegerField()
    user_id      = models.CharField(max_length=100)

    def __str__(self):
        return "post_pk_num" + self.post_pk_num

    class Meta:
        db_table = 'like_db'
