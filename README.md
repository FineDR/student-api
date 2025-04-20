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