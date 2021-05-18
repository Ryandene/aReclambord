from __future__ import unicode_literals
from django.db import models


# Create your models here.
class BillboardInventory(models.Model):
    vendorId = models.IntegerField()
    latitude = models.FloatField()
    longitude = models.FloatField()
    status = models.TextField()


# id = models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
# Latitudes can take any value between -90 and 90
# longitude values can take any value between -180 and 180
# latitude = models.DecimalField(decimal_places=6, max_digits=8)
# longitude = models.DecimalField(decimal_places=6, max_digits=9)