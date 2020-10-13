from django.db import models

# Create your models here.


class TestUser(models.Model):  # models.Model을 상속하고 있다고 보면됨
    user_id     = models.CharField(max_length=50)
    user_pwd    = models.CharField(max_length=50)
    user_name   = models.CharField(max_length=50)



