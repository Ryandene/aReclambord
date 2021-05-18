import traceback
from urllib.error import HTTPError

from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.generics import ListAPIView, RetrieveAPIView
from rest_framework.parsers import JSONParser

# from UserManagement.serializers import AReclambordUserSerializer
from UserManagement.serializers import AReclambordUserSerializer
from aReclambord_server.pyrebase_settings import db, auth


# Create your views here.

# class BookListView(ListAPIView):
#     queryset = Book.objects.all()
#     serializer_class = BookSerializer
#
#
# class BookDetailView(RetrieveAPIView):
#     queryset = Book.objects.all()
#     serializer_class = BookSerializer

@api_view(['POST'])
def signup_user(request):
    user_data = JSONParser().parse(request)
    user_serializer = AReclambordUserSerializer(data=user_data)
    # print("asaa")
    print(user_data)
    print(user_data.get('email'))
    try:
        user = auth.create_user_with_email_and_password(user_data.get('email'), user_data.get('email'))
        return JsonResponse({'message': 'User created successfully'}, status=status.HTTP_201_CREATED)
    except Exception as e:
        exception_message = traceback.format_exc()
        return JsonResponse({'message': 'HttpError Exception occur.'}, status=status.HTTP_400_BAD_REQUEST)
