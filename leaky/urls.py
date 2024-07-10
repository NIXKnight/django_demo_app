from django.urls import path
from . import views

urlpatterns = [
    path('leak/', views.leaky_view, name='leaky_view'),
]
