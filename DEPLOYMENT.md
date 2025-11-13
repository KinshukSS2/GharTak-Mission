# Production Setup Guide - GharTak Mission

## Prerequisites
- Python 3.8 or higher
- pip (Python package installer)
- Virtual environment (recommended)
- CMake (for dlib installation)
- C++ compiler (for dlib)

## System Dependencies (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install -y python3-dev python3-pip cmake build-essential
```

## Installation Steps

### 1. Clone the Repository
```bash
git clone <your-repository-url>
cd Missing-Person-Detection-System
```

### 2. Set Up Virtual Environment
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies
```bash
cd core
pip install --upgrade pip
pip install -r requirements.txt
```

### 4. Environment Configuration
Copy the example environment file and configure it:
```bash
cp ../.env.example .env
```

Edit the `.env` file with your configuration:
```env
DJANGO_SECRET_KEY=your-strong-secret-key-here
DEBUG=False
ALLOWED_HOSTS=your-domain.com,www.your-domain.com

EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-specific-password
```

**Important:** For Gmail, you need to:
1. Enable 2-factor authentication
2. Generate an app-specific password
3. Use the app password in EMAIL_HOST_PASSWORD

### 5. Database Setup
```bash
# Remove old database if exists
rm -f db.sqlite3

# Create new database
python manage.py makemigrations
python manage.py migrate
```

### 6. Create Superuser
```bash
python manage.py createsuperuser
```
Follow the prompts to set up admin credentials.

### 7. Collect Static Files (Production)
```bash
python manage.py collectstatic --noinput
```

### 8. Run the Development Server
```bash
python manage.py runserver
```
Access at: http://127.0.0.1:8000

## Production Deployment

### Using Gunicorn
```bash
pip install gunicorn
gunicorn core.wsgi:application --bind 0.0.0.0:8000
```

### Using Nginx (Recommended)
1. Install Nginx
2. Configure Nginx to proxy to Gunicorn
3. Set up SSL certificate (Let's Encrypt)

Sample Nginx configuration:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location = /favicon.ico { access_log off; log_not_found off; }
    
    location /static/ {
        root /path/to/Missing-Person-Detection-System/core;
    }

    location /media/ {
        root /path/to/Missing-Person-Detection-System/core;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Using Systemd Service
Create `/etc/systemd/system/ghartakmission.service`:
```ini
[Unit]
Description=GharTak Mission Django Application
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/path/to/Missing-Person-Detection-System/core
Environment="PATH=/path/to/venv/bin"
ExecStart=/path/to/venv/bin/gunicorn --workers 3 --bind unix:/path/to/ghartakmission.sock core.wsgi:application

[Install]
WantedBy=multi-user.target
```

Enable and start:
```bash
sudo systemctl enable ghartakmission
sudo systemctl start ghartakmission
```

## Security Checklist

- [ ] Set DEBUG=False in production
- [ ] Use a strong SECRET_KEY
- [ ] Configure ALLOWED_HOSTS properly
- [ ] Set up SSL/TLS certificates
- [ ] Use environment variables for sensitive data
- [ ] Enable Django security middleware
- [ ] Set secure cookie flags
- [ ] Regularly update dependencies
- [ ] Set up proper logging
- [ ] Configure database backups
- [ ] Use a production-grade database (PostgreSQL/MySQL)

## Troubleshooting

### dlib Installation Issues
If you encounter issues with dlib:
```bash
pip install cmake
pip install dlib --verbose
```

### Face Recognition Issues
Make sure you have the required system libraries:
```bash
sudo apt-get install libopenblas-dev liblapack-dev
```

### Camera Access Issues
Ensure the user running the application has camera access permissions.

## Maintenance

### Database Backup
```bash
python manage.py dumpdata > backup.json
```

### Database Restore
```bash
python manage.py loaddata backup.json
```

### Updating Dependencies
```bash
pip install --upgrade -r requirements.txt
python manage.py migrate
```

## Support
For issues and questions, please refer to the project repository.

## License
[Add your license information here]

## Author
Kinshuk
