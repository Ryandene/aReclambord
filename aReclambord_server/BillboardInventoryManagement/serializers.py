from rest_framework import serializers
from .models import BillboardInventory


class BillboardInventorySerializer(serializers.ModelSerializer):
    class Meta:
        model = BillboardInventory
        fields = (
            'vendorId',
            'latitude',
            'longitude',
            'status'
        )
