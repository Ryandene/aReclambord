from django.db import models
from .enums import BillboardUserType, BillboardType


# Create your models here.
class AReclamborProfileModel(models.Model):
    email: models.CharField(max_length=30)
    password: models.CharField(max_length=16)
    firstName: models.TextField()
    lastName: models.TextField()
    type: models.TextField(choices=BillboardUserType.choices(), default=BillboardUserType.CUSTOMER)


class DbProfileModel(models.Model):
    email: models.CharField(max_length=30)
    firstName: models.TextField()
    lastName: models.TextField()
    type: models.TextField(choices=BillboardUserType.choices(), default=BillboardUserType.CUSTOMER)


class LoginProfileModel(models.Model):
    email: models.CharField(max_length=30)
    password: models.CharField(max_length=16)


# billboard models
class BillboardByVendorModel(models.Model):
    vendorId: models.CharField(max_length=30)
    width: models.CharField(max_length=16)
    height: models.CharField(max_length=16)
    location_lat: models.CharField(max_length=16)
    location_long: models.CharField(max_length=16)
    type: models.TextField(choices=BillboardType.choices(), default=BillboardType.SMALL)
