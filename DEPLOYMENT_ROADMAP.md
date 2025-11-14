# 🚀 GharTak Mission - Complete Deployment Roadmap

## 📋 Table of Contents
1. [Pre-Deployment Checklist](#pre-deployment-checklist)
2. [Local Testing](#local-testing)
3. [Deployment Options](#deployment-options)
4. [Step-by-Step Deployment Guide](#step-by-step-deployment-guide)
5. [Post-Deployment](#post-deployment)
6. [Monitoring & Maintenance](#monitoring--maintenance)

---

## ✅ Pre-Deployment Checklist

### Current Status Assessment
- ✅ Git repository clean (no uncommitted changes)
- ❌ Virtual environment not set up
- ❌ Dependencies not installed
- ⚠️  Email configuration needed
- ⚠️  Production settings not configured
- ⚠️  Database needs to be set up
- ⚠️  Static files need to be collected

### Critical Issues to Fix Before Deployment
1. **Virtual Environment** - Must be created and activated
2. **Dependencies** - All Python packages must be installed
3. **Environment Variables** - `.env` file must be configured
4. **Database** - Migrations must be run
5. **Static Files** - Must be collected for production
6. **Security Settings** - DEBUG must be False, SECRET_KEY must be secure

---

## 🧪 Local Testing Phase

### Step 1: Setup Local Environment

```bash
# 1. Create virtual environment
cd /home/deadpool/Python-projects/GharTak-Mission
python3 -m venv venv
source venv/bin/activate

# 2. Install system dependencies
sudo apt-get update
sudo apt-get install -y python3-dev cmake build-essential libopencv-dev

# 3. Install Python dependencies
cd core
pip install --upgrade pip
pip install -r requirements.txt

# 4. Create .env file
cp ../.env.example .env
nano .env  # Edit with your settings
```

### Step 2: Configure Environment Variables

Create `/home/deadpool/Python-projects/GharTak-Mission/core/.env`:

```env
# Django Configuration
DJANGO_SECRET_KEY=generate-a-secure-random-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1,0.0.0.0

# Email Configuration (REQUIRED for alerts)
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-16-char-app-password

# Database (SQLite for development)
# Will use PostgreSQL for production
```

**How to get Gmail App Password:**
1. Go to https://myaccount.google.com/security
2. Enable 2-Step Verification
3. Go to https://myaccount.google.com/apppasswords
4. Create "Mail" app password
5. Copy the 16-character password

### Step 3: Initialize Database

```bash
cd /home/deadpool/Python-projects/GharTak-Mission/core

# Run migrations
python manage.py makemigrations
python manage.py migrate

# Create superuser for admin access
python manage.py createsuperuser
# Username: admin
# Email: your-email@gmail.com
# Password: (choose a strong password)
```

### Step 4: Collect Static Files

```bash
python manage.py collectstatic --noinput
```

### Step 5: Run Local Tests

```bash
# Test 1: Django system check
python manage.py check

# Test 2: Start development server
python manage.py runserver 0.0.0.0:8000

# Open browser: http://127.0.0.1:8000
# Expected: Home page loads correctly
```

### Step 6: Test All Features

**Manual Testing Checklist:**
- [ ] Home page loads without errors
- [ ] Navigation works (all links functional)
- [ ] Missing person registration form works
- [ ] File upload (photo) works
- [ ] Form validation works
- [ ] Admin panel accessible (/admin)
- [ ] Admin can view/edit/delete records
- [ ] Search functionality works
- [ ] Email notification test (register a case)
- [ ] Face detection script runs (optional, requires webcam)

```bash
# Test face detection (if webcam available)
# In separate terminal:
cd /home/deadpool/Python-projects/GharTak-Mission/core
source ../venv/bin/activate
python run_face_detection.py
# Press 'Q' to quit
```

---

## 🌐 Deployment Options

### Option 1: VPS/Cloud Server (Recommended)
**Best for:** Full control, production-ready
**Services:** DigitalOcean, AWS EC2, Linode, Vultr, Azure VM
**Cost:** $5-20/month
**Setup Time:** 2-3 hours

**Pros:**
- Full control over server
- Can use webcam for face detection
- Good performance
- Professional domain support

**Cons:**
- Requires server management
- Manual SSL setup
- Need to configure firewall

### Option 2: Platform as a Service (PaaS)
**Best for:** Quick deployment, less maintenance
**Services:** Heroku, Railway, Render, PythonAnywhere
**Cost:** Free tier available, $7-25/month paid
**Setup Time:** 30 minutes - 1 hour

**Pros:**
- Easy deployment
- Automatic SSL
- Built-in CI/CD
- Minimal configuration

**Cons:**
- Less control
- May need code modifications
- Face detection may not work (no webcam access)
- Limited to web interface only

### Option 3: Containerized Deployment
**Best for:** Scalability, modern infrastructure
**Services:** Docker + Kubernetes, AWS ECS, Google Cloud Run
**Cost:** Varies ($10-50/month)
**Setup Time:** 3-5 hours

**Pros:**
- Highly scalable
- Consistent environment
- Easy to replicate
- Good for CI/CD

**Cons:**
- More complex setup
- Requires Docker knowledge
- Higher initial effort

---

## 🎯 Step-by-Step Deployment Guide

### Recommended: VPS Deployment with Ubuntu Server

#### Phase 1: Server Setup (30 minutes)

**1. Get a VPS Server:**
- Sign up for DigitalOcean, Linode, or AWS
- Create Ubuntu 22.04 LTS droplet/instance
- Minimum specs: 2GB RAM, 1 CPU, 25GB storage
- Note your server IP address

**2. Initial Server Configuration:**

```bash
# SSH into your server
ssh root@your-server-ip

# Update system
apt update && apt upgrade -y

# Create application user
adduser ghartakmission
usermod -aG sudo ghartakmission

# Switch to application user
su - ghartakmission
```

**3. Install Dependencies:**

```bash
# Install Python and build tools
sudo apt install -y python3 python3-pip python3-venv
sudo apt install -y cmake build-essential libopencv-dev
sudo apt install -y nginx certbot python3-certbot-nginx
sudo apt install -y postgresql postgresql-contrib
```

#### Phase 2: Application Deployment (45 minutes)

**1. Clone Repository:**

```bash
cd /home/ghartakmission
git clone https://github.com/KinshukSS2/GharTak-Mission.git
cd GharTak-Mission
```

**2. Setup Virtual Environment:**

```bash
python3 -m venv venv
source venv/bin/activate
cd core
pip install --upgrade pip
pip install -r requirements.txt
pip install gunicorn psycopg2-binary
```

**3. Configure PostgreSQL:**

```bash
sudo -u postgres psql

# In PostgreSQL:
CREATE DATABASE ghartakmission;
CREATE USER ghartakuser WITH PASSWORD 'your-secure-password';
ALTER ROLE ghartakuser SET client_encoding TO 'utf8';
ALTER ROLE ghartakuser SET default_transaction_isolation TO 'read committed';
ALTER ROLE ghartakuser SET timezone TO 'Asia/Kolkata';
GRANT ALL PRIVILEGES ON DATABASE ghartakmission TO ghartakuser;
\q
```

**4. Configure Production Environment:**

Create `/home/ghartakmission/GharTak-Mission/core/.env`:

```env
# Django Configuration
DJANGO_SECRET_KEY=your-very-long-random-secret-key-here
DEBUG=False
ALLOWED_HOSTS=your-domain.com,www.your-domain.com,your-server-ip

# Database (PostgreSQL)
DATABASE_URL=postgresql://ghartakuser:your-secure-password@localhost:5432/ghartakmission

# Email Configuration
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-gmail-app-password

# Security
SECURE_SSL_REDIRECT=True
SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True
```

**5. Update Django Settings for Production:**

Edit `core/core/settings.py` - add at the end:

```python
# Production Database Configuration
import dj_database_url
if not DEBUG:
    DATABASES = {
        'default': dj_database_url.config(
            default=config('DATABASE_URL')
        )
    }
```

**6. Initialize Application:**

```bash
cd /home/ghartakmission/GharTak-Mission/core
source ../venv/bin/activate

# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Collect static files
python manage.py collectstatic --noinput

# Test
python manage.py check --deploy
```

#### Phase 3: Web Server Configuration (30 minutes)

**1. Configure Gunicorn:**

Create `/etc/systemd/system/ghartakmission.service`:

```ini
[Unit]
Description=GharTak Mission Gunicorn Daemon
After=network.target

[Service]
User=ghartakmission
Group=www-data
WorkingDirectory=/home/ghartakmission/GharTak-Mission/core
Environment="PATH=/home/ghartakmission/GharTak-Mission/venv/bin"
ExecStart=/home/ghartakmission/GharTak-Mission/venv/bin/gunicorn \
    --workers 3 \
    --bind unix:/run/ghartakmission.sock \
    core.wsgi:application

[Install]
WantedBy=multi-user.target
```

**2. Start Gunicorn:**

```bash
sudo systemctl start ghartakmission
sudo systemctl enable ghartakmission
sudo systemctl status ghartakmission
```

**3. Configure Nginx:**

Create `/etc/nginx/sites-available/ghartakmission`:

```nginx
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    location = /favicon.ico { access_log off; log_not_found off; }
    
    location /static/ {
        alias /home/ghartakmission/GharTak-Mission/core/staticfiles/;
    }
    
    location /media/ {
        alias /home/ghartakmission/GharTak-Mission/core/public/static/;
    }

    location / {
        include proxy_params;
        proxy_pass http://unix:/run/ghartakmission.sock;
    }

    client_max_body_size 10M;
}
```

**4. Enable Site:**

```bash
sudo ln -s /etc/nginx/sites-available/ghartakmission /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx
```

**5. Configure Firewall:**

```bash
sudo ufw allow 'Nginx Full'
sudo ufw allow OpenSSH
sudo ufw enable
```

#### Phase 4: SSL Certificate (15 minutes)

```bash
# Get free SSL certificate from Let's Encrypt
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# Test auto-renewal
sudo certbot renew --dry-run
```

#### Phase 5: Domain Configuration (10 minutes)

**In your domain registrar (GoDaddy, Namecheap, etc.):**
1. Add A record: `@` → `your-server-ip`
2. Add A record: `www` → `your-server-ip`
3. Wait 5-30 minutes for DNS propagation

---

## 🎉 Post-Deployment

### Verification Checklist

```bash
# 1. Test HTTP → HTTPS redirect
curl -I http://your-domain.com

# 2. Test website access
curl https://your-domain.com

# 3. Check Gunicorn
sudo systemctl status ghartakmission

# 4. Check Nginx
sudo systemctl status nginx

# 5. Check logs
sudo journalctl -u ghartakmission -n 50
sudo tail -f /var/log/nginx/error.log
```

### Manual Testing
- [ ] Visit https://your-domain.com
- [ ] Register a missing person case
- [ ] Upload photo
- [ ] Check admin panel
- [ ] Verify email notifications
- [ ] Test search functionality
- [ ] Check mobile responsiveness

---

## 📊 Monitoring & Maintenance

### Daily Tasks
- Check error logs
- Monitor disk space
- Check email delivery

### Weekly Tasks
```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Restart services
sudo systemctl restart ghartakmission
sudo systemctl restart nginx

# Backup database
pg_dump ghartakmission > backup_$(date +%Y%m%d).sql
```

### Monthly Tasks
- Review security logs
- Update Python dependencies
- Check SSL certificate expiry
- Review and archive old cases

### Automated Backups

Create `/home/ghartakmission/backup.sh`:

```bash
#!/bin/bash
BACKUP_DIR="/home/ghartakmission/backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Backup database
pg_dump ghartakmission > $BACKUP_DIR/db_$DATE.sql

# Backup media files
tar -czf $BACKUP_DIR/media_$DATE.tar.gz \
    /home/ghartakmission/GharTak-Mission/core/public/static/

# Keep only last 7 days
find $BACKUP_DIR -type f -mtime +7 -delete
```

Add to crontab:
```bash
crontab -e
# Add: 0 2 * * * /home/ghartakmission/backup.sh
```

---

## 🐛 Troubleshooting

### Issue: 502 Bad Gateway
```bash
sudo systemctl status ghartakmission
sudo journalctl -u ghartakmission -n 50
```

### Issue: Static files not loading
```bash
cd /home/ghartakmission/GharTak-Mission/core
source ../venv/bin/activate
python manage.py collectstatic --noinput
sudo systemctl restart ghartakmission
```

### Issue: Permission denied
```bash
sudo chown -R ghartakmission:www-data /home/ghartakmission/GharTak-Mission
sudo chmod -R 755 /home/ghartakmission/GharTak-Mission
```

---

## 📝 Quick Commands Reference

```bash
# Restart application
sudo systemctl restart ghartakmission

# View logs
sudo journalctl -u ghartakmission -f

# Update code
cd /home/ghartakmission/GharTak-Mission
git pull
source venv/bin/activate
cd core
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic --noinput
sudo systemctl restart ghartakmission

# Django shell
python manage.py shell

# Check deployment
python manage.py check --deploy
```

---

## 🎯 Deployment Timeline

**Total Estimated Time: 3-4 hours**

| Phase | Duration | Status |
|-------|----------|--------|
| Server Setup | 30 min | ⏳ Pending |
| Application Deployment | 45 min | ⏳ Pending |
| Web Server Configuration | 30 min | ⏳ Pending |
| SSL Certificate | 15 min | ⏳ Pending |
| Domain Configuration | 10 min | ⏳ Pending |
| Testing & Verification | 30 min | ⏳ Pending |
| Documentation & Handoff | 30 min | ⏳ Pending |

---

## ✅ Final Pre-Launch Checklist

- [ ] DEBUG = False in production
- [ ] Strong SECRET_KEY configured
- [ ] Database backup system in place
- [ ] SSL certificate active
- [ ] Firewall configured
- [ ] Email notifications working
- [ ] Admin account created
- [ ] All static files served correctly
- [ ] Mobile responsive
- [ ] Error pages customized (404, 500)
- [ ] Monitoring system set up
- [ ] Documentation complete

---

**Good luck with your deployment! 🚀**

For support, refer to DEPLOYMENT.md, PRODUCTION_READY.md, or open an issue on GitHub.
