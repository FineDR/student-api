# student-api

This is a simple API built with Django and Django REST Framework.

## Endpoints
- **GET /api/students/** - Returns a list of students.
- **GET /api/subjects/** - Returns subjects by year.

## Setup Instructions
1. Clone the repository:  

## 🔄 Backup Schemes

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




## Bash Server Management Scripts

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
sudo apt install curl git mysql-client  # Or postgresql-client, depending on DB
