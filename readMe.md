# Student API Project

## Description
A RESTful API built with Django and Django REST Framework that provides information about students and subjects in a Software Engineering program.

## Table of Contents
- [Project Overview](#project-overview)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Development and Setup](#development-and-setup)
- [Database Setup](#database-setup)
- [Deployment Process](#deployment-process)
- [Troubleshooting](#troubleshooting)
- [Author](#author)

## Project Overview
This project was developed for the CS 421 Software Deployment and Management course at the University of Dodoma.

### Features
- Retrieve student details and enrolled programs.
- Fetch subjects categorized by academic year.
- Secure API access with authentication.
- PostgreSQL database integration.

## Technology Stack
- **Backend:** Django 4.2.7
- **API Framework:** Django REST Framework 3.14.0
- **Database:** PostgreSQL
- **Web Server:** Nginx
- **WSGI Server:** Gunicorn

## Project Structure
```
student_api_project/
│── manage.py                      # Django management script
│── requirements.txt               # Project dependencies
│── README.md                      # Documentation
│
├── student_api_project/           # Project configuration
│   ├── settings.py                # Django settings
│   ├── urls.py                    # Main URL routing
│   ├── wsgi.py                     # WSGI config
│
└── api/                           # Main API application
    ├── models.py                  # Database models
    ├── serializers.py             # DRF serializers
    ├── views.py                   # API views
    ├── urls.py                    # API URL routing
    ├── migrations/                # Database migrations
```

## API Endpoints

| Method | Endpoint | Description |
|--------|---------|------------|
| GET    | `/students/` | Retrieve all students |
| GET    | `/subjects/` | Retrieve all subjects |

### Students Endpoint
URL: http://16.170.115.244/students/

### Subjects Endpoint
URL: http://16.170.115.244/subjects/

## Development and Setup

### 1. Clone the Repository
```bash
git clone https://github.com/REJOICE31/student_api.git
cd student_api
```

### 2. Create a Virtual Environment
```bash
python3 -m venv env
source env/bin/activate  # Windows: env\Scripts\activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Configure `.env` File
```bash
SECRET_KEY=django-screet-key
DEBUG=False
ALLOWED_HOSTS=localhost,16.170.115.244
DB_NAME=student
DB_USER=furahini
DB_PASSWORD=furahini
DB_HOST=localhost
DB_PORT=5432
```

### 5. Database Setup
```bash
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

## Deployment Process (AWS Ubuntu)

### 1. Install Required Packages
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx git
```

### 2. Create PostgreSQL Database
```sql
sudo -u postgres psql
CREATE DATABASE student_api;
CREATE USER student_api_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE student_api TO student_api_user;
\q
```

### 3. Deploy with Gunicorn & Nginx
```bash
sudo systemctl start gurnicorn
sudo systemctl enable gurnicorn
sudo systemctl restart nginx
```

## Troubleshooting

### Check Gunicorn Logs
```bash
sudo journalctl -u student_api --no-pager
```

### Check Nginx Logs
```bash
sudo tail -f /var/log/nginx/error.log
```

## Author
👤 Furahini Kisivani Siyanga
📧 furahinisiyanga31@gmail.com  
🔗 [GitHub Profile](https://github.com/REJOICE31)

