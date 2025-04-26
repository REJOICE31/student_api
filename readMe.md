# Student API Project

## Description
A RESTful API built with Django and Django REST Framework to manage and serve data about students and subjects in a Software Engineering program.

## Table of Contents
- [Project Overview](#project-overview)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Development and Setup](#development-and-setup)
- [Database Setup](#database-setup)
- [Deployment Process](#deployment-process)
- [Troubleshooting](#troubleshooting)
- [Backup Schemes](#backup-schemes)
- [Bash Automation Scripts](#bash-automation-scripts)
- [Docker](#docker)
- [Dependencies](#dependencies)
- [Author](#author)

---

## Project Overview
This API was created for academic use under the CS 421 Software Deployment and Management course at the University of Dodoma. It allows access to structured data for students and their subjects.

### Features
- Fetch all students
- Fetch all subjects by academic year
- Simple RESTful interface using Django REST Framework
- PostgreSQL database
- Secured access to endpoints

---

## Technology Stack
- **Framework**: Django 4.2.7
- **API**: Django REST Framework 3.14.0
- **Database**: PostgreSQL
- **Web Server**: Nginx
- **WSGI**: Gunicorn
- **Containerization**: Docker

---

## Project Structure
```
student_api/
│── manage.py
│── requirements.txt
│── README.md
├── student_api/
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
└── api/
    ├── models.py
    ├── serializers.py
    ├── views.py
    ├── urls.py
    └── migrations/
```

---

## API Endpoints

| Method | Endpoint      | Description           |
|--------|---------------|-----------------------|
| GET    | `/students/`  | Retrieve all students |
| GET    | `/subjects/`  | Retrieve all subjects |

- **Students URL**: http://16.170.115.244/students/  
- **Subjects URL**: http://16.170.115.244/subjects/

---

## Development and Setup

### Clone the Repo
```bash
git clone https://github.com/REJOICE31/student_api.git
cd student_api
```

### Create a Virtual Environment
```bash
python3 -m venv env
source env/bin/activate
```

### Install Requirements
```bash
pip install -r requirements.txt
```

### Environment Setup
Create a `.env` file:
```
SECRET_KEY=django-screet-key
DEBUG=False
ALLOWED_HOSTS=localhost,16.170.115.244
DB_NAME=student
DB_USER=furahini
DB_PASSWORD=furahini
DB_HOST=localhost
DB_PORT=5432
```

---

## Database Setup

### PostgreSQL Commands
```bash
sudo -u postgres psql
CREATE DATABASE student;
CREATE USER furahini WITH PASSWORD 'furahini';
GRANT ALL PRIVILEGES ON DATABASE student TO furahini;
\q
```

### Django Migrations
```bash
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

---

## Deployment Process

### Install Server Dependencies
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx git
```

### Configure Gunicorn and Nginx
```bash
sudo systemctl start gurnicorn
sudo systemctl enable gurnicorn
sudo systemctl restart nginx
```

---

## Troubleshooting

### Check Gunicorn Logs
```bash
sudo journalctl -u gurnicorn --no-pager
```

### Check Nginx Logs
```bash
sudo tail -f /var/log/nginx/error.log
```

---

## Backup Schemes

### Full Backup
- Backs up entire dataset
- Easy to restore, takes more space and time

### Incremental Backup
- Only backs up changes since last backup
- Efficient but complex to restore

### Differential Backup
- Backs up changes since last full backup
- Faster restore, more space than incremental

---

## Bash Automation Scripts

**Folder:** `/home/ubuntu/bash_scripts`

### 1. health_check.sh
- Checks CPU, memory, and disk usage
- Confirms application is reachable
- Logs output to `/var/log/server_health.log`

### 2. update_server.sh
- Updates OS packages
- Pulls latest code from GitHub
- Restarts Gunicorn or Docker container
- Logs to `/var/log/update.log`

### 3. backup_server.sh
- Creates backups of the project and PostgreSQL database
- Stores them locally with timestamp

### Make Executable
```bash
chmod +x /home/ubuntu/bash_scripts/*.sh
```

### Cron Jobs Example
```bash
crontab -e

# Run health check every hour
0 * * * * /home/ubuntu/bash_scripts/health_check.sh

# Run update daily
0 2 * * * /home/ubuntu/bash_scripts/update_server.sh
```

---

## Docker

### Build Docker Image
```bash
docker build -t rejoice31/student_api_web:latest .
```

### Run Docker Container With Volumes & Environment Variables
```bash
docker run -d -p 8000:8000   --env DB_NAME=student   --env DB_USER=furahini   --env DB_PASSWORD=furahini   --env DB_HOST=host.docker.internal   -v $(pwd):/app   --name student_api_container   rejoice31/student_api_web:latest
```

### Login to Docker Hub
```bash
docker login
```

### Push Image to Docker Hub
```bash
docker push rejoice31/student_api_web:latest
```

### Pull and Run on Server
```bash
sudo apt install docker.io
sudo docker pull rejoice31/student_api_web:latest

sudo docker run -d -p 8000:8000   --env DB_NAME=student   --env DB_USER=furahini   --env DB_PASSWORD=furahini   --env DB_HOST=host.docker.internal   --name student_api_container   rejoice31/student_api_web:latest
```

### DockerHub Repository
[https://hub.docker.com/r/rejoice31/student_api_web](https://hub.docker.com/r/rejoice31/student_api_web)

---

## Dependencies
- Python 3.x
- pip
- PostgreSQL
- Docker
- Gunicorn
- Nginx
- Git
- curl
- cron

---

## Author

**Name**: Furahini  
**Email**: furahinisiyanga31@gmail.com  
**GitHub**: [REJOICE31](https://github.com/REJOICE31)