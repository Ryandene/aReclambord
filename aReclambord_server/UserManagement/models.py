# from django.db import models
from __future__ import unicode_literals
from django.db import models


# Create your models here.
class AReclamborUserModel(models.Model):
    email: models.CharField(max_length=30)
    password: models.CharField(max_length=16)
