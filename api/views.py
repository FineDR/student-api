from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Student, Subject
from .serializers import StudentSerializer, SubjectSerializer

class StudentsListView(APIView):
    def get(self, request):
        students = Student.objects.all()
        return Response({"students": StudentSerializer(students, many=True).data})

    def post(self, request):
        serializer = StudentSerializer(data=request.data)
        if serializer.is_valid():
            student = serializer.save()
            return Response({"student": StudentSerializer(student).data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class SubjectsListView(APIView):
    def get(self, request):
        subjects = Subject.objects.all()
        return Response({"subjects": SubjectSerializer(subjects, many=True).data})

    def post(self, request):
        serializer = SubjectSerializer(data=request.data)
        if serializer.is_valid():
            subject = serializer.save()
            return Response({"subject": SubjectSerializer(subject).data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
