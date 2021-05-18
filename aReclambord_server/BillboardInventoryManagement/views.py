from rest_framework import status
from rest_framework.generics import ListAPIView, RetrieveAPIView, CreateAPIView, DestroyAPIView, UpdateAPIView
from rest_framework.parsers import JSONParser

from .models import BillboardInventory
from .serializers import BillboardInventorySerializer
from aReclambord_server.pyrebase_settings import db, auth
from django.http import HttpResponse, JsonResponse

from rest_framework.decorators import api_view


# Create your views here.
# class BookHistoryListView(ListAPIView):
#     queryset = BookHistory.objects.all()
#     serializer_class = BookHistorySerializer
#
#
# class BookHistoryDetailView(RetrieveAPIView):
#     queryset = BookHistory.objects.all()
#     serializer_class = BookHistorySerializer
#
#
# class BookHistoryCreateView(CreateAPIView):
#     queryset = BookHistory.objects.all()
#     serializer_class = BookHistorySerializer
#
#
# class BookHistoryUpdateView(UpdateAPIView):
#     queryset = BookHistory.objects.all()
#     serializer_class = BookHistorySerializer
#
#
# class BookHistoryDeleteView(DestroyAPIView):
#     queryset = BookHistory.objects.all()
#     serializer_class = BookHistorySerializer

# billboard vendor creates a new billboard request with approval status == pending
# admin needs to approve the billboard to publish for billboard customer
@api_view(['POST'])
def create_new_billboard_for_rent(request):
    billboard_data = JSONParser().parse(request)
    billboard_serializer = BillboardInventorySerializer(data=billboard_data)

    if billboard_serializer.is_valid():
        db.child("Billboard_Inventory").push(billboard_serializer.data)
        return JsonResponse(billboard_serializer.data, status=status.HTTP_201_CREATED)
    else:
        return JsonResponse(billboard_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
