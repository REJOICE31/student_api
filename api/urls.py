from django.urls import path
from django.views.generic import TemplateView
from .views import StudentListView, SubjectListView

urlpatterns = [
    path('', TemplateView.as_view(template_name='api/home.html'), name='home'),
    path('students/', StudentListView.as_view(), name='student-list'),
    path('subjects/', SubjectListView.as_view(), name='subject-list'),
]
