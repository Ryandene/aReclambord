from rest_framework import serializers
from .models import AReclamborProfileModel, DbProfileModel, LoginProfileModel, BillboardByVendorModel


class AReclambordProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = AReclamborProfileModel
        fields = '__all__'


class DbProfileModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = DbProfileModel
        fields = '__all__'


class LoginProfileModelSerializer(serializers.ModelSerializer):
    class Meta:
        model: LoginProfileModel
        fields = '__all__'


# billboardserializers
class BillboardByVendorModelSerializer(serializers.ModelSerializer):
    class Meta:
        model: BillboardByVendorModel
        fields = '__all__'
