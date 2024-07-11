from django.urls import path
from .views import get_hostname

urlpatterns = [
    path('hostname/', get_hostname, name='hostname'),
]
