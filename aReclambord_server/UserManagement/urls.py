from django.urls import path

# from .views import BookListView, BookDetailView
from . import views

    # path('', BookListView.as_view()),
    # path('<pk>', BookDetailView.as_view())

urlpatterns = [
    path('signup/', views.signup_user)
]
