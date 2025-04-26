FROM ubuntu:22.04
# 1. Use an official Python image
FROM python:3.10-slim

# 2. Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt
# 3. Set working directory inside the container
WORKDIR /app

# 4. Copy requirement file and install packages
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# 5. Copy the rest of your project files into the container
COPY . .

# 6. Expose port 8000
EXPOSE 8000

# 7. Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
