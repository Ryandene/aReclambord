from rest_framework import serializers
from .models import AReclamborUserModel


class AReclambordUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = AReclamborUserModel
        fields = '__all__'
