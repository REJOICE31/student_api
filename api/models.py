from django.db import models

# Create your models here.

class Student(models.Model):
    """Model representing a student."""
    name = models.CharField(max_length=100)
    program = models.CharField(max_length=100)
    
    class Meta:
        ordering = ['name']
    
    def __str__(self):
        return f"{self.name} - {self.program}"

class Subject(models.Model):
    """Model representing a subject in the curriculum."""
    YEAR_CHOICES = [
        (1, 'Year 1'),
        (2, 'Year 2'),
        (3, 'Year 3'),
        (4, 'Year 4'),
    ]
    
    SEMESTER_CHOICES = [
        (1, 'Semester 1'),
        (2, 'Semester 2'),
    ]
    
    name = models.CharField(max_length=100)
    code = models.CharField(max_length=20)
    year = models.IntegerField(choices=YEAR_CHOICES)
    semester = models.IntegerField(choices=SEMESTER_CHOICES)
    
    class Meta:
        ordering = ['year', 'semester', 'code']
    
    def __str__(self):
        return f"{self.code} - {self.name} (Year {self.year}, Semester {self.semester})"