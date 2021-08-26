from django.urls import path
from . import views

urlpatterns = [
    path('signup/', views.signup_user),
    path('signIn/', views.signin_user),
    path('schedule_campaign/', views.schedule_events)
]