import json
from django.shortcuts import render
from rest_framework import generics
from rest_framework.response import Response
from django.db.models import F
from collections import defaultdict

from .models import Student, Subject
from .serializers import StudentSerializer, SubjectSerializer

class StudentListView(generics.ListAPIView):
    """API endpoint that allows students to be viewed."""
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

    def list(self, request, *args, **kwargs):
        """Override list method to customize the response format."""
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        
        response_data = {
            'status': 'success',
            'data': {
                'students': serializer.data
            }
        }
        
        # Check for format parameter or accept header for JSON response
        if request.accepted_renderer.format == 'json' or request.query_params.get('format') == 'json':
            return Response(response_data)
        
        # Render HTML template with JSON data if requested
        json_data = json.dumps(response_data)
        return render(request, 'api/students.html', {'json_data': json_data})

class SubjectListView(generics.ListAPIView):
    """API endpoint that allows subjects to be viewed."""
    queryset = Subject.objects.all().order_by('year', 'semester', 'code')
    serializer_class = SubjectSerializer

    def list(self, request, *args, **kwargs):
        """Override list method to group subjects by year."""
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        
        # Group subjects by year
        subjects_by_year = defaultdict(list)
        for subject in serializer.data:
            year_key = f"Year {subject['year']}"
            subjects_by_year[year_key].append(subject)
        
        response_data = {
            'status': 'success',
            'data': {
                'program': 'Software Engineering',
                'subjects': dict(subjects_by_year)
            }
        }
        
        # Check for format parameter or accept header for JSON response
        if request.accepted_renderer.format == 'json' or request.query_params.get('format') == 'json':
            return Response(response_data)
        
        # Render HTML template with JSON data if requested
        json_data = json.dumps(response_data)
        return render(request, 'api/subjects.html', {'json_data': json_data})
