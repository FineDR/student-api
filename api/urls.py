from django.urls import path
from . import views
urlpatterns = [
    path('students/', views.StudentsListView.as_view(), name='students-list'),
    path('subjects/', views.SubjectsListView.as_view(), name='subjects-list'),
]
