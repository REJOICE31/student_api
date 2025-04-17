## Bash Automation Scripts

This directory (`bash_scripts`) contains automation scripts for managing the student API server:

### 1. health_check.sh
- Checks CPU, memory, and disk usage.
- Verifies web server is running.
- Tests `/students` and `/subjects` endpoints.
- Logs to `/var/log/server_health.log`.

### 2. update_server.sh
- Updates Ubuntu packages.
- Pulls latest code from GitHub.
- Restarts the web server.
- Logs to `/var/log/update.log`.

### 3. backup_api.sh
- Will back up the API project and database (to be completed).

### 🛠 Setup Instructions
```bash
cd bash_scripts
chmod +x *.sh
