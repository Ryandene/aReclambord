from django.http import JsonResponse
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser
from rest_framework.response import Response

from areclambord_api.pyrebase_settings import db, auth
from .enums import BillboardUserType, BillboardType, AdvertisementPackageType

import schedule
import time
import sched
from datetime import timedelta, date

# Create your views here.


from UserManagement.serializers import AReclambordProfileSerializer, DbProfileModelSerializer, \
    LoginProfileModelSerializer, BillboardByVendorModelSerializer
from UserManagement.models import DbProfileModel, AReclamborProfileModel


@api_view(['POST'])
def signup_user(request):
    user_data = JSONParser().parse(request)

    user_type = user_data.get('type')
    if user_type == BillboardUserType.CUSTOMER.value or user_type == BillboardUserType.VENDOR.value or user_type == BillboardUserType.ADMIN.value:
        user_data["type"] = user_type
    else:
        user_data["type"] = BillboardUserType.CUSTOMER.value

    user_serializer = AReclambordProfileSerializer(data=user_data)
    if user_serializer.is_valid():
        db_user_serializer = {
            'email': user_data.get('email'),
            'firstName': user_data.get('firstName'),
            'lastName': user_data.get('lastName'),
            'type': user_data.get('type')
        }
    else:
        return JsonResponse(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        user = auth.create_user_with_email_and_password(user_data.get('email'), user_data.get('password'))
        db.child("System_Users").child(user['localId']).set(db_user_serializer)
        return JsonResponse({'message': 'User created successfully'}, status=status.HTTP_201_CREATED)
    except Exception as e:
        # exception_message = traceback.format_exc()
        return JsonResponse({'message': 'Email id invalid or already exists.'}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def signin_user(request):
    login_data = JSONParser().parse(request)
    # print(login_data)
    # login_serializer = LoginProfileModelSerializer(data=login_data)
    try:
        user = auth.sign_in_with_email_and_password(login_data.get('email'), login_data.get('password'))
        # print(user)
        access_token = user['idToken']
        refresh_token = user['refreshToken']
        expiresIn = user['expiresIn']
        expiresIn_integer = int(expiresIn)

        # print(refresh_token)
        data = {
            'access_token': access_token
        }
        # print(data)
        # print(temp)
        response = Response()
        response.data = data
        response.status_code = status.HTTP_200_OK
        response.set_cookie(key='refreshToken', value=refresh_token, max_age=expiresIn_integer)
        # db.child("System_Users").child(user['localId']).set(db_user_serializer)
        return response
        # return JsonResponse({'access_token': access_token}, status=status.HTTP_200_OK).set_cookie(key='refreshToken', value=refresh_token,
        #                                                              max_age=expiresIn_integer)
    except Exception as e:
        # exception_message = traceback.format_exc()
        return Response({'message': 'Email id invalid or already exists.'}, status=status.HTTP_400_BAD_REQUEST)


def check_initial_payment():
    print("End initial pay")


def check_and_notify_init_pay():
    print("swim")


@api_view(['POST'])
def schedule_events(request):
    scheduling_parameters = JSONParser().parse(request)
    advertisement_category = scheduling_parameters.get('advertisement_type')
    advertisement_package = scheduling_parameters.get('package_type')

    if advertisement_package == AdvertisementPackageType.SILVER.value:
        init_payment_notify_date = (date.today() + timedelta(days=3)).strftime('%Y-%m-%d')
        init_pay_end_date = (date.today() + timedelta(days=5)).strftime('%Y-%m-%d')
    else:
        init_payment_notify_date = (date.today() + timedelta(days=8)).strftime('%Y-%m-%d')
        init_pay_end_date = (date.today() + timedelta(days=10)).strftime('%Y-%m-%d')

    init_payment_notify_set = time.strptime(init_payment_notify_date + '12:00:00', '%Y-%m-%d %H:%M:%S')
    init_payment_notify_set = time.mktime(init_payment_notify_set)
    init_pay_set = time.strptime(init_pay_end_date + '12:00:00', '%Y-%m-%d %H:%M:%S')
    init_pay_set = time.mktime(init_pay_set)

    ad_campaign_scheduler = sched.scheduler.enterabs(init_payment_notify_set, 1, check_initial_payment, ())
    ad_campaign_scheduler = sched.scheduler.enterabs(init_pay_set, 1, check_and_notify_init_pay, ())
    ad_campaign_scheduler.run()
    # schedule.every(5).seconds.do(do_run)
    # schedule.every(10).seconds.do(do_run)
    # while 1:
    #     schedule.run_pending()
    #     time.sleep(1)


@api_view(['POST'])
def create_billboard_by_vendor(request):
    billboard_data = JSONParser().parse(request)

    billboard_type = billboard_data.get('type')
    if billboard_type == BillboardType.WIDE.value or billboard_type == BillboardType.ULTRAWIDE.value or billboard_type == BillboardType.SMALL.value:
        billboard_data["type"] = billboard_type
    else:
        billboard_data["type"] = BillboardType.SMALL.value

    billboard_serializer = BillboardByVendorModelSerializer(data=billboard_data)
    if billboard_serializer.is_valid():
        db_billboard_serializer = {
            'email': billboard_data.get('vendorId'),
            'firstName': billboard_data.get('width'),
            'lastName': billboard_data.get('height'),
            'latitude': billboard_data.get('location_lat'),
            'longitude': billboard_data.get('location_long'),
            'type': billboard_data.get('type')
        }
    else:
        return JsonResponse(billboard_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        db.child("Billboard_By_Vendors").child().set(billboard_serializer)
        return JsonResponse({'message': 'Billboard vacancy created successfully'}, status=status.HTTP_201_CREATED)
    except Exception as e:
        # exception_message = traceback.format_exc()
        return JsonResponse({'message': 'An error occurred'}, status=status.HTTP_400_BAD_REQUEST)
