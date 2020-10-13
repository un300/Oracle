from django.db import models
from django.utils import timezone

# Create your models here.


class BbsUserRegister(models.Model):
    user_id = models.CharField(max_length=50)
    user_pwd = models.CharField(max_length=50)
    user_name = models.CharField(max_length=50)

    def __str__(self):
        return self.user_id + ',' + self.user_pwd + ', ' + self.user_name



class Bbs(models.Model) :
    # id = models.AutoField(primary key=True)
    title =  models.CharField(max_length=100)
    writer = models.CharField(max_length=100)
    content = models.TextField()
    regdate = models.DateTimeField(default=timezone.now)
    viewcnt = models.IntegerField(default=0)

    def __str__(self):
        return self.title




class Seops(models.Model):
    name = models.CharField(max_length=50)
    img = models.CharField(max_length=50)
    status = models.CharField(max_length=50)

    def __str__(self):
        return self.name + ', ' + self.img + ', ' + self.status










