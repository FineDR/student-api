from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Student, Subject
from .serializers import StudentSerializer, SubjectSerializer
from .data import students_data, subjects_data

class StudentsListView(APIView):
    def get(self, request):
        if not Student.objects.exists():
            Student.objects.bulk_create([Student(**student) for student in students_data])
        students = Student.objects.all()
        return Response({"students": StudentSerializer(students, many=True).data})

class SubjectsListView(APIView):
    def get(self, request):
        if not Subject.objects.exists():
            Subject.objects.bulk_create([Subject(**subject) for subject in subjects_data])
        subjects = Subject.objects.all()
        return Response({"subjects": SubjectSerializer(subjects, many=True).data})
