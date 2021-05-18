from django.urls import path
from . import views

# from .views import (
#     BookHistoryListView,
#     BookHistoryDetailView,
#     BookHistoryCreateView,
#     BookHistoryDeleteView,
#     BookHistoryUpdateView
# )

# urlpatterns = [
#     path('bookHistory/', BookHistoryListView.as_view()),
#     path('bookHistory/create/', BookHistoryCreateView.as_view()),
#     path('bookHistory/<pk>', BookHistoryDetailView.as_view()),
#     path('bookHistory/<pk>/update/', BookHistoryUpdateView.as_view()),
#     path('bookHistory/<pk>/delete/', BookHistoryDeleteView.as_view()),
# ]

urlpatterns = [
    path('create/', views.create_new_billboard_for_rent)
]