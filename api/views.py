from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Student, Subject
from .serializers import StudentSerializer, SubjectSerializer
import os

class StudentsListView(APIView):
    def get(self, request):
        students = Student.objects.all()
        data = {"students": StudentSerializer(students, many=True).data}
        node_id = os.getenv('NODE_ID', 'Unknown')
        response = Response(data)
        response.headers['X-Node-ID'] = node_id
        return response

    def post(self, request):
        serializer = StudentSerializer(data=request.data)
        if serializer.is_valid():
            student = serializer.save()
            data = {"student": StudentSerializer(student).data}
            node_id = os.getenv('NODE_ID', 'Unknown')
            response = Response(data, status=status.HTTP_201_CREATED)
            response.headers['X-Node-ID'] = node_id
            return response
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class SubjectsListView(APIView):
    def get(self, request):
        subjects = Subject.objects.all()
        data = {"subjects": SubjectSerializer(subjects, many=True).data}
        node_id = os.getenv('NODE_ID', 'Unknown')
        response = Response(data)
        response.headers['X-Node-ID'] = node_id
        return response

    def post(self, request):
        serializer = SubjectSerializer(data=request.data)
        if serializer.is_valid():
            subject = serializer.save()
            data = {"subject": SubjectSerializer(subject).data}
            node_id = os.getenv('NODE_ID', 'Unknown')
            response = Response(data, status=status.HTTP_201_CREATED)
            response.headers['X-Node-ID'] = node_id
            return response
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
