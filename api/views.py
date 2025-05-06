import os
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Student, Subject
from .serializers import StudentSerializer, SubjectSerializer
from rest_framework.response import Response
from rest_framework.utils.serializer_helpers import ReturnDict


class StudentsListView(APIView):
    def get(self, request):
        students = Student.objects.all()
        data = {"students": StudentSerializer(students, many=True).data}
        return self.add_node_id_header(Response(data))

    def post(self, request):
        serializer = StudentSerializer(data=request.data)
        if serializer.is_valid():
            student = serializer.save()
            data = {"student": StudentSerializer(student).data}
            return self.add_node_id_header(Response(data, status=status.HTTP_201_CREATED))
        return self.add_node_id_header(Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST))

    def add_node_id_header(self, response: Response) -> Response:
        response["X-Node-ID"] = os.getenv("NODE_ID", "unknown")
        return response


class SubjectsListView(APIView):
    def get(self, request):
        subjects = Subject.objects.all()
        data = {"subjects": SubjectSerializer(subjects, many=True).data}
        return self.add_node_id_header(Response(data))

    def post(self, request):
        serializer = SubjectSerializer(data=request.data)
        if serializer.is_valid():
            subject = serializer.save()
            data = {"subject": SubjectSerializer(subject).data}
            return self.add_node_id_header(Response(data, status=status.HTTP_201_CREATED))
        return self.add_node_id_header(Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST))

    def add_node_id_header(self, response: Response) -> Response:
        response["X-Node-ID"] = os.getenv("NODE_ID", "unknown")
        return response
