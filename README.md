
# student-api

This is a simple API built with Django and Django REST Framework.

---

##  Endpoints

- **GET /api/students/** - Returns a list of students.  
- **GET /api/subjects/** - Returns subjects by year.

---

##  Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/FineDR/student-api.git
cd student-api
```

2. Create a virtual environment and install dependencies:

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

3. Run migrations and start the server:

```bash
python manage.py migrate
python manage.py runserver
```

---

##  Backup Schemes

This section explains the backup strategies considered for automating the backup process of the deployed API project (Assignment 1) running on an AWS EC2 Ubuntu server.

### 1. Full Backup

A full backup creates a complete copy of all API project files and databases.

- **Advantages**:
  - Simplifies recovery.
  - Guarantees data completeness.
- **Disadvantages**:
  - Time-consuming.
  - High storage consumption.
- **Use Case**:
  - Scheduled weekly backups of `/api/students/`.

### 2. Incremental Backup

Only changes made since the last backup are saved.

- **Advantages**:
  - Very efficient.
  - Minimal storage usage.
- **Disadvantages**:
  - Complex to restore (requires full + all incremental files).
- **Use Case**:
  - Ideal for daily backups combined with weekly full backups.

### 3. Differential Backup

Backs up all changes made since the last **full** backup.

- **Advantages**:
  - Easier recovery than incremental.
- **Disadvantages**:
  - Backup size increases over time if full backups are not frequent.
- **Use Case**:
  - Every 2-3 days to complement a full weekly backup.

---

##  Bash Server Management Scripts

This directory contains Bash scripts for automating server maintenance tasks for the deployed API.

### Scripts

1. **health_check.sh**
   - Monitors CPU, memory, and disk usage.
   - Checks if the web server is running.
   - Verifies `/students` and `/subjects` endpoints using curl.
   - Logs health status to `/var/log/server_health.log`.

2. **backup_api.sh**
   - Backs up the API directory and database.
   - Deletes backups older than 7 days.
   - Logs results to `/var/log/backup.log`.

3. **update_server.sh**
   - Updates Ubuntu packages.
   - Pulls latest changes from GitHub.
   - Restarts the server and logs to `/var/log/update.log`.

### Setup Instructions

```bash
# Make scripts executable
chmod +x bash_scripts/*.sh

# Dependencies required:
# - curl
# - PostgreSQL client tools (if using PostgreSQL)
# - tar
```

---

# 🐳 Docker Deployment

##  1. Project Title and Description

This is a Django REST API for managing students and subjects, containerized using Docker and orchestrated with Docker Compose.

---

##  2. 🔧 Building the Docker Image

Clone the repository and navigate to the project directory:

```bash
git clone https://github.com/FineDR/student-api.git
cd student-api
```

Build the Docker image:

```bash
sudo docker-compose build
```

---

##  3.  Running with Docker Compose

Start the containers:

```bash
sudo docker-compose up -d
```

Check running containers:

```bash
sudo docker ps
```

Access your API at:  
📍 `http://localhost:8000/api/students/`  
📍 `http://localhost:8000/api/subjects/`

---

##  4.  AWS EC2 Deployment (Free Tier)

1. Launch an **Ubuntu EC2 instance**.
2. **Install Docker** and **Docker Compose**:

```bash
sudo apt update && sudo apt install docker.io docker-compose -y
```

3. **Clone the repository** to your EC2 instance:

```bash
git clone https://github.com/FineDR/student-api.git
cd student-api
```

4. **Run the application**:

```bash
sudo docker-compose up -d
```

Access your app at:  
 `http://3.226.236.217:8000`

---

## 5. Docker Hub Image

You can pull the image directly from Docker Hub:

```bash
docker pull kubehwa/student_api
```

Docker Hub Link:  
 `https://hub.docker.com/r/kubehwa/student_api`

---

##  6. Screenshots & Logs

-  `docker_ps.png`: Screenshot showing running containers.  
-  `docker_logs.txt`: Captured logs of Docker container output.

---

## 7. Troubleshooting

- **Port already in use**:  
  Use `sudo lsof -i :8000` to find and stop the process, or change the port in `docker-compose.yml`.

- **Container name conflict**:  
  Use `docker rm <container_id>` or `docker-compose down` to clean up.

- **Database connection errors**:  
  Ensure that the PostgreSQL container is running and all environment variables are correctly set in `.env`.

---



## Version Control and Docker Registry

### ✅ GitHub Repository


- `Dockerfile` for:
  - Frontend (React)
- `docker-compose.yml` defining all services including:
  - Frontend nodes (for load balancing)
  - PostgreSQL database
  - NGINX load balancer
- Frontend source code (`student_frontend/`)
- Load balancer configuration file (`nginx.conf`)
- Updated `README.md` file with instructions and setup details

🔗 **GitHub Repository URL**:  
[https://github.com/FineDR/student-api](https://github.com/FineDR/student-api)  


---

### ✅ Docker Hub Repositories

All Docker images have been built and pushed to Docker Hub for public access:

- **Backend API Image**  
  🔗 `https://hub.docker.com/r/kubehwa/student-api-backend`

- **Frontend Image**  
  🔗 `https://hub.docker.com/r/kubehwa/student-frontend`

- **NGINX Load Balancer Image**  
  🔗 `https://hub.docker.com/r/kubehwa/student-nginx-loadbalancer`

