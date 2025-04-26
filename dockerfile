# Use official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory inside container
WORKDIR /app

# Install dependencies (SQLite is built-in, but we need system tools)
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt and install Python packages
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy project files into container
COPY . /app/

# Expose the port Django will run on
EXPOSE 8000

# Run Django app using gunicorn
CMD ["gunicorn", "student_api.wsgi:application", "--bind", "0.0.0.0:8000"]