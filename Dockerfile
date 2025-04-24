# Dockerfile
FROM python:3.10-slim

# Avoid caching issues and unnecessary bytecode generation
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create and use a dedicated working directory
WORKDIR /app

# Copy dependencies and install
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project files
COPY . /app/

# Expose default Django port
EXPOSE 8000

# Use CMD for final run command (ideal for overriding in Compose)
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
