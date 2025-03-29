from rest_framework import serializers
from .models import Student, Subject

class StudentSerializer(serializers.ModelSerializer):
    """Serializer for the Student model."""
    
    class Meta:
        model = Student
        fields = ['id', 'name', 'program']

class SubjectSerializer(serializers.ModelSerializer):
    """Serializer for the Subject model."""
    year_name = serializers.CharField(source='get_year_display', read_only=True)
    semester_name = serializers.CharField(source='get_semester_display', read_only=True)
    
    class Meta:
        model = Subject
        fields = ['id', 'name', 'code', 'year', 'year_name', 'semester', 'semester_name']