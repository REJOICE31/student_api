from django.contrib import admin
from .models import Student, Subject

@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
    """Admin configuration for the Student model."""
    list_display = ('name', 'program')
    search_fields = ('name', 'program')
    list_filter = ('program',)

@admin.register(Subject)
class SubjectAdmin(admin.ModelAdmin):
    """Admin configuration for the Subject model."""
    list_display = ('code', 'name', 'year', 'semester')
    search_fields = ('name', 'code')
    list_filter = ('year', 'semester')