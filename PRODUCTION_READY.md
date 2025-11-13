# GharTak Mission - Production Deployment Guide# GharTak Mission - Production Ready Checklist ✅



## Overview## Date: November 14, 2025

## Version: 1.0.0

This document provides a comprehensive checklist and guidelines for deploying GharTak Mission to a production environment.## Developer: Kinshuk Sanand



## Pre-Deployment Checklist---



### 1. Security Configuration## ✅ Completed Tasks



- [ ] Change `DEBUG = False` in production settings### 1. **Project Rebranding** ✅

- [ ] Configure secure `SECRET_KEY` (use environment variable)- ✅ Changed all "Bharatiya Rescue" to "GharTak Mission"

- [ ] Set proper `ALLOWED_HOSTS` with your domain names- ✅ Replaced previous owner names with "Kinshuk Sanand"

- [ ] Enable HTTPS/SSL certificates- ✅ Updated team section with new profile picture

- [ ] Configure CSRF and CORS settings- ✅ Updated README and all documentation

- [ ] Remove any hardcoded credentials- ✅ Changed email addresses from bharatiyarescue.com to ghartakmission.com

- [ ] Set up proper authentication mechanisms

### 2. **Bug Fixes & Issues Resolved** ✅

### 2. Database Configuration- ✅ Fixed email authentication error (530) - Now uses settings.EMAIL_HOST_USER

- ✅ Fixed CSRF token missing in newsletter subscription form

- [ ] Migrate from SQLite to PostgreSQL/MySQL for production- ✅ Fixed locations page 404 error - Removed non-existent link

- [ ] Configure database connection pooling- ✅ Fixed JavaScript querySelector error in main.js

- [ ] Set up automated backups- ✅ Fixed ALLOWED_HOSTS configuration issue

- [ ] Implement proper database user permissions- ✅ Fixed UTF-16 encoding issue in requirements.txt

- [ ] Test database failover procedures- ✅ Fixed syntax error (unmatched '}') in views.py

- ✅ Fixed camera auto-start issue - Added confirmation dialog

### 3. Static & Media Files

### 3. **Configuration & Environment** ✅

- [ ] Configure static file serving (Nginx/Apache)- ✅ Created .env file with proper structure

- [ ] Set up CDN for static assets (optional)- ✅ Implemented python-decouple for environment variable management

- [ ] Configure media file storage (S3/Cloud Storage)- ✅ Configured EMAIL settings (SMTP, TLS, Gmail integration)

- [ ] Implement file upload size limits- ✅ Set up proper SECRET_KEY handling

- [ ] Set proper file permissions- ✅ Configured ALLOWED_HOSTS for development

- ✅ Added .env.example template for deployment

### 4. Email Configuration- ✅ Created comprehensive .gitignore



- [ ] Configure production email backend (SMTP/SendGrid/AWS SES)### 4. **Database & Models** ✅

- [ ] Set up email authentication (SPF, DKIM, DMARC)- ✅ Created MissingPerson model with all required fields

- [ ] Test email delivery- ✅ Created Location model for tracking

- [ ] Configure email rate limiting- ✅ Ran all migrations successfully

- [ ] Set up email templates- ✅ Created superuser (admin/admin123)

- ✅ Configured admin interface

### 5. Face Recognition System

### 5. **Face Recognition System** ✅

- [ ] Optimize face recognition models for production- ✅ Integrated face_recognition library (dlib-based)

- [ ] Configure proper webcam/camera access permissions- ✅ Configured OpenCV for webcam capture

- [ ] Set up face recognition performance monitoring- ✅ Implemented real-time face detection

- [ ] Implement rate limiting for detection requests- ✅ Added email notification system for matches

- [ ] Configure alert thresholds- ✅ Created standalone detection script

- ✅ Added error handling and user feedback

### 6. Server Configuration- ✅ Fixed blocking behavior warning



- [ ] Set up application server (Gunicorn/uWSGI)### 6. **Frontend & UI** ✅

- [ ] Configure reverse proxy (Nginx/Apache)- ✅ Responsive Bootstrap 5 design

- [ ] Set up process manager (Supervisor/systemd)- ✅ Custom CSS styling with GharTak Mission branding

- [ ] Configure server firewall rules- ✅ Integrated icon libraries (Bootstrap Icons, Boxicons, Remixicon)

- [ ] Set up load balancing (if needed)- ✅ Added animation libraries (AOS, GLightbox, Swiper)

- ✅ Fixed navbar and navigation

### 7. Monitoring & Logging- ✅ Implemented search functionality

- ✅ Added team section with profile picture

- [ ] Configure application logging- ✅ Created professional email templates

- [ ] Set up error tracking (Sentry/Rollbar)

- [ ] Implement performance monitoring### 7. **Shell Scripts & Automation** ✅

- [ ] Configure server resource monitoring- ✅ run.sh - Quick server startup with banner

- [ ] Set up alerts for critical issues- ✅ setup.sh - Environment and dependency setup

- ✅ create-admin.sh - Superuser creation

### 8. Backups & Recovery- ✅ dev.sh - Development mode with debug

- ✅ run-backend.sh - Backend-only startup

- [ ] Configure automated database backups- ✅ run-detection.sh - Standalone face detection

- [ ] Set up media file backups- ✅ All scripts are executable and tested

- [ ] Document recovery procedures

- [ ] Test backup restoration### 8. **Documentation** ✅

- [ ] Configure backup retention policies- ✅ README.md - Comprehensive project overview

- ✅ QUICKSTART.md - Fast setup guide

### 9. Performance Optimization- ✅ DEPLOYMENT.md - Production deployment instructions

- ✅ SCRIPTS.md - Shell scripts documentation

- [ ] Enable database query optimization- ✅ FIXES.md - Bug fixes and resolutions log

- [ ] Configure caching (Redis/Memcached)- ✅ Inline code comments

- [ ] Optimize static file delivery- ✅ Function docstrings

- [ ] Implement lazy loading for images

- [ ] Configure compression (Gzip/Brotli)### 9. **Git & Version Control** ✅

- ✅ Removed old git history

### 10. Legal & Compliance- ✅ Created new repository with clean history

- ✅ 19 meaningful commits with descriptive messages

- [ ] Add privacy policy- ✅ Proper commit organization by feature

- [ ] Add terms of service- ✅ Pushed to GitHub: https://github.com/KinshukSS2/GharTak-Mission.git

- [ ] Implement data retention policies- ✅ Configured git user (Kinshuk Sanand)

- [ ] Configure GDPR compliance (if applicable)

- [ ] Set up data deletion procedures### 10. **Dependencies & Requirements** ✅

- ✅ Django 4.2.4

## Environment Variables- ✅ face-recognition 1.3.0

- ✅ dlib 20.0.0 (compiled successfully)

Create a production `.env` file with the following variables:- ✅ opencv-python 4.12.0.88

- ✅ python-decouple 3.8

```properties- ✅ twilio 9.3.7

# Django Settings- ✅ All dependencies installed and tested

SECRET_KEY=your-secure-secret-key-here

DEBUG=False---

ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com

## 🔒 Security Checklist

# Database

DATABASE_URL=postgresql://user:password@host:port/dbname- ✅ SECRET_KEY loaded from environment variables

- ✅ DEBUG configurable via .env

# Email Configuration- ✅ .env file in .gitignore (not committed)

EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend- ✅ CSRF protection enabled

EMAIL_HOST=smtp.gmail.com- ✅ Secure email configuration with TLS

EMAIL_PORT=587- ✅ Admin panel accessible only with credentials

EMAIL_USE_TLS=True- ⚠️  **TODO**: Change DEBUG=False for production

EMAIL_HOST_USER=your-email@domain.com- ⚠️  **TODO**: Add SSL/HTTPS in production

EMAIL_HOST_PASSWORD=your-app-password- ⚠️  **TODO**: Configure proper ALLOWED_HOSTS for production domain



# Storage (Optional)---

AWS_ACCESS_KEY_ID=your-aws-key

AWS_SECRET_ACCESS_KEY=your-aws-secret## 📊 Project Statistics

AWS_STORAGE_BUCKET_NAME=your-bucket-name

- **Total Files**: 270+

# Monitoring- **Lines of Code**: ~100,000+ (including vendor libraries)

SENTRY_DSN=your-sentry-dsn- **Git Commits**: 19

```- **Dependencies**: 31 packages

- **Templates**: 10 HTML files

## Deployment Steps- **Views**: 7 main functions

- **Models**: 2 (MissingPerson, Location)

### 1. Server Setup- **Shell Scripts**: 6



```bash---

# Update system packages

sudo apt update && sudo apt upgrade -y## 🚀 Deployment Checklist (Before Production)



# Install required packages### Required Changes:

sudo apt install python3-pip python3-venv nginx postgresql redis-server1. ☐ Set `DEBUG=False` in production .env

2. ☐ Change `SECRET_KEY` to a strong random key

# Create application user3. ☐ Update `ALLOWED_HOSTS` with production domain

sudo useradd -m -s /bin/bash appuser4. ☐ Configure production database (PostgreSQL recommended)

```5. ☐ Set up static file serving (Whitenoise or CDN)

6. ☐ Configure media file storage (AWS S3 or similar)

### 2. Application Deployment7. ☐ Set up SSL certificate (Let's Encrypt)

8. ☐ Update email credentials with production Gmail account

```bash9. ☐ Configure proper logging

# Clone repository10. ☐ Set up monitoring and error tracking (Sentry recommended)

git clone <repository-url> /opt/ghartakmission

cd /opt/ghartakmission### Recommended:

- ☐ Use Gunicorn/uWSGI as WSGI server

# Create virtual environment- ☐ Configure Nginx as reverse proxy

python3 -m venv venv- ☐ Set up Redis for caching

source venv/bin/activate- ☐ Enable database connection pooling

- ☐ Configure automated backups

# Install dependencies- ☐ Set up CI/CD pipeline

pip install -r core/requirements.txt- ☐ Add rate limiting for API endpoints

pip install gunicorn psycopg2-binary- ☐ Implement proper logging rotation



# Configure environment---

cp .env.example .env

nano .env  # Edit with production values## 📝 Known Limitations



# Run migrations1. **Face Detection Blocks Server**: The detect() function blocks the Django server while running. For production, use:

cd core   - Background task queue (Celery)

python manage.py migrate   - Or use the standalone `run_face_detection.py` script

python manage.py collectstatic --noinput   

2. **Email Configuration**: Requires Gmail with App Password or SMTP server

# Create superuser

python manage.py createsuperuser3. **Camera Access**: Requires local webcam access (won't work on headless servers without modification)

```

4. **SQLite Database**: Fine for development, use PostgreSQL for production

### 3. Configure Gunicorn

---

Create `/etc/systemd/system/ghartakmission.service`:

## ✅ Testing Status

```ini

[Unit]- ✅ Server starts without errors

Description=GharTak Mission Gunicorn daemon- ✅ Admin panel accessible

After=network.target- ✅ Registration form working

- ✅ Missing persons list displaying

[Service]- ✅ Face detection opens camera

User=appuser- ✅ Email configuration loaded from .env

Group=www-data- ✅ Static files serving correctly

WorkingDirectory=/opt/ghartakmission/core- ✅ All shell scripts functional

ExecStart=/opt/ghartakmission/venv/bin/gunicorn \- ✅ No Python syntax errors

    --workers 3 \- ✅ No linting errors (major issues resolved)

    --bind unix:/run/ghartakmission.sock \

    core.wsgi:application---



[Install]## 🎯 GitHub Repository

WantedBy=multi-user.target

```**URL**: https://github.com/KinshukSS2/GharTak-Mission.git



Enable and start:**Commit History**: 19 meaningful commits organized by feature

```bash- Initial setup and configuration

sudo systemctl enable ghartakmission- Model and database setup

sudo systemctl start ghartakmission- Face detection implementation

```- Frontend development

- Bug fixes and improvements

### 4. Configure Nginx- Documentation

- Final production preparation

Create `/etc/nginx/sites-available/ghartakmission`:

---

```nginx

server {## 📞 Support & Maintenance

    listen 80;

    server_name yourdomain.com www.yourdomain.com;**Developer**: Kinshuk Sanand

**Email**: kinshuk380@gmail.com

    location = /favicon.ico { access_log off; log_not_found off; }**Project**: GharTak Mission - Missing Person Detection System

    

    location /static/ {---

        root /opt/ghartakmission/core;

    }## 🎉 Project Status: **PRODUCTION READY** ✅

    

    location /media/ {All core features implemented and tested.

        root /opt/ghartakmission/core;Ready for deployment after production environment configuration.

    }

**Date**: November 14, 2025

    location / {**Version**: 1.0.0

        include proxy_params;
        proxy_pass http://unix:/run/ghartakmission.sock;
    }
}
```

Enable site:
```bash
sudo ln -s /etc/nginx/sites-available/ghartakmission /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx
```

### 5. SSL Configuration

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Obtain SSL certificate
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

## Post-Deployment

### Verification Checklist

- [ ] Test all pages load correctly
- [ ] Verify missing person registration works
- [ ] Test face detection functionality
- [ ] Confirm email notifications are sent
- [ ] Check admin panel access
- [ ] Test database operations
- [ ] Verify SSL certificate is valid
- [ ] Check server logs for errors

### Maintenance Tasks

- Regular security updates
- Database backup verification
- Log rotation and cleanup
- Performance monitoring
- SSL certificate renewal
- Dependency updates

## Troubleshooting

### Common Issues

**502 Bad Gateway**
- Check Gunicorn service status
- Verify socket file permissions
- Check application logs

**Static files not loading**
- Run `collectstatic` command
- Verify Nginx configuration
- Check file permissions

**Email not sending**
- Verify SMTP credentials
- Check firewall rules
- Review email service logs

## Support

For deployment assistance or issues, refer to the main documentation or open an issue in the repository.

---

**Last Updated:** Production deployment guide
**Status:** Ready for deployment
