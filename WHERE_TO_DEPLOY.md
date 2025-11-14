# 🚀 Complete Deployment Guide - Frontend & Backend

## ✅ Pre-Deployment Checks - ALL PASSED!

### System Status
- ✅ No linting errors
- ✅ No deployment warnings
- ✅ Security settings configured
- ✅ Database initialized
- ✅ Static files collected
- ✅ Virtual environment set up
- ✅ All dependencies installed

---

## 📊 Important Understanding: This is a **Full-Stack Django App**

**GharTak Mission** is NOT a separate frontend/backend application. It's a **monolithic Django application** where:
- **Backend**: Django (Python) - handles all logic, database, API
- **Frontend**: HTML/CSS/JS templates served by Django - integrated into Django

**You deploy them TOGETHER** as a single application.

---

## 🌐 Deployment Options

### Option 1: VPS (Full Features) ⭐ **RECOMMENDED**
**Best for**: Production with face detection support  
**Cost**: $5-10/month  
**Providers**: DigitalOcean, Linode, AWS EC2, Vultr  
**Features**: ✅ Face detection, ✅ Full control, ✅ Scalable

### Option 2: PaaS (Quick Deploy)
**Best for**: Web-only features (no face detection)  
**Cost**: Free tier or $7-10/month  
**Providers**: Railway, Render, Heroku, PythonAnywhere  
**Features**: ✅ Easy setup, ❌ No face detection (no webcam)

### Option 3: Docker + Cloud
**Best for**: Enterprise/scalable deployments  
**Cost**: $10-50/month  
**Providers**: AWS ECS, Google Cloud Run, Azure Container Apps  
**Features**: ✅ Highly scalable, ⚠️ Complex setup

---

## 🎯 RECOMMENDED: VPS Deployment (DigitalOcean)

### Why VPS?
1. ✅ Full control over server
2. ✅ Face detection works (webcam access)
3. ✅ Best performance
4. ✅ Professional domain support
5. ✅ Cost-effective ($5-10/month)

---

## 📝 Complete VPS Deployment Steps

### Phase 1: Get a Server (15 minutes)

**1.1 Sign up for DigitalOcean**
- Go to https://www.digitalocean.com
- Create account (use GitHub for easy signup)
- Get $200 free credit for 60 days (new users)

**1.2 Create a Droplet**
```
Choose:
- Image: Ubuntu 22.04 LTS
- Plan: Basic ($6/month)
- RAM: 1GB minimum (2GB recommended)
- CPU: 1 vCPU
- Storage: 25GB SSD
- Datacenter: Bangalore/Mumbai (closest to India)
- Authentication: SSH Key (create and add)
```

**1.3 Note Your Server Details**
- Server IP: `your.server.ip.address`
- Root password/SSH key

---

### Phase 2: Initial Server Setup (20 minutes)

**2.1 Connect to Server**
```bash
# From your local machine
ssh root@your.server.ip.address
```

**2.2 Update System**
```bash
apt update && apt upgrade -y
```

**2.3 Create Application User**
```bash
# Create user
adduser ghartakmission
# Enter password when prompted

# Add to sudo group
usermod -aG sudo ghartakmission

# Switch to user
su - ghartakmission
```

**2.4 Install Dependencies**
```bash
# Python and build tools
sudo apt install -y python3 python3-pip python3-venv
sudo apt install -y cmake build-essential
sudo apt install -y libopencv-dev python3-opencv

# Web server and database
sudo apt install -y nginx
sudo apt install -y postgresql postgresql-contrib

# SSL certificate tool
sudo apt install -y certbot python3-certbot-nginx

# Git
sudo apt install -y git
```

---

### Phase 3: Deploy Application (30 minutes)

**3.1 Clone Repository**
```bash
cd /home/ghartakmission
git clone https://github.com/KinshukSS2/GharTak-Mission.git
cd GharTak-Mission
```

**3.2 Setup Virtual Environment**
```bash
python3 -m venv venv
source venv/bin/activate
```

**3.3 Install Python Dependencies**
```bash
cd core
pip install --upgrade pip
pip install -r requirements.txt
pip install gunicorn
```

**3.4 Setup PostgreSQL Database**
```bash
# Switch to postgres user
sudo -u postgres psql

# In PostgreSQL prompt:
CREATE DATABASE ghartakmission;
CREATE USER ghartakuser WITH PASSWORD 'YourStrongPassword123!';
ALTER ROLE ghartakuser SET client_encoding TO 'utf8';
ALTER ROLE ghartakuser SET default_transaction_isolation TO 'read committed';
ALTER ROLE ghartakuser SET timezone TO 'Asia/Kolkata';
GRANT ALL PRIVILEGES ON DATABASE ghartakmission TO ghartakuser;
\q
```

**3.5 Configure Environment**
```bash
cd /home/ghartakmission/GharTak-Mission/core
nano .env
```

**Update .env file:**
```properties
# Django Configuration
DJANGO_SECRET_KEY=generate-new-long-random-secret-key-here-min-50-chars-abc123xyz789
DEBUG=False
ALLOWED_HOSTS=your-domain.com,www.your-domain.com,your.server.ip.address

# Database (PostgreSQL)
DATABASE_URL=postgresql://ghartakuser:YourStrongPassword123!@localhost:5432/ghartakmission

# Email Configuration
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-gmail-app-password
```

**3.6 Run Migrations and Collect Static Files**
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

---

### Phase 4: Configure Gunicorn (20 minutes)

**4.1 Test Gunicorn**
```bash
cd /home/ghartakmission/GharTak-Mission/core
source ../venv/bin/activate
gunicorn --bind 0.0.0.0:8000 core.wsgi:application
# Press Ctrl+C to stop
```

**4.2 Create Gunicorn Service**
```bash
sudo nano /etc/systemd/system/ghartakmission.service
```

**Add this content:**
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

**4.3 Start Gunicorn Service**
```bash
sudo systemctl start ghartakmission
sudo systemctl enable ghartakmission
sudo systemctl status ghartakmission
```

---

### Phase 5: Configure Nginx (15 minutes)

**5.1 Create Nginx Configuration**
```bash
sudo nano /etc/nginx/sites-available/ghartakmission
```

**Add this content:**
```nginx
server {
    listen 80;
    server_name your-domain.com www.your-domain.com your.server.ip.address;

    location = /favicon.ico { 
        access_log off; 
        log_not_found off; 
    }
    
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

**5.2 Enable Site**
```bash
sudo ln -s /etc/nginx/sites-available/ghartakmission /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

**5.3 Configure Firewall**
```bash
sudo ufw allow 'Nginx Full'
sudo ufw allow OpenSSH
sudo ufw enable
```

---

### Phase 6: Domain & SSL (20 minutes)

**6.1 Point Domain to Server** (If you have a domain)

In your domain registrar (GoDaddy, Namecheap, etc.):
```
Add A Record:
  Name: @
  Value: your.server.ip.address
  TTL: 3600

Add A Record:
  Name: www
  Value: your.server.ip.address
  TTL: 3600
```

Wait 5-30 minutes for DNS propagation.

**6.2 Get SSL Certificate (Free)**
```bash
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# Follow prompts:
# - Enter email
# - Agree to terms
# - Choose: Redirect HTTP to HTTPS (option 2)
```

**6.3 Test Auto-Renewal**
```bash
sudo certbot renew --dry-run
```

---

### Phase 7: Verification & Testing (15 minutes)

**7.1 Test Website**
```bash
# Check if services are running
sudo systemctl status ghartakmission
sudo systemctl status nginx

# Check logs
sudo journalctl -u ghartakmission -n 50
sudo tail -f /var/log/nginx/error.log
```

**7.2 Access Your Site**
- Open browser: `https://your-domain.com` or `http://your.server.ip.address`
- Test all features:
  - [ ] Homepage loads
  - [ ] Register missing person
  - [ ] Upload photo
  - [ ] Admin panel (`/admin`)
  - [ ] Email notifications

---

## 🔄 Post-Deployment Maintenance

### Daily Backups
```bash
# Create backup script
nano /home/ghartakmission/backup.sh
```

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

echo "Backup completed: $DATE"
```

```bash
chmod +x /home/ghartakmission/backup.sh

# Add to crontab (run daily at 2 AM)
crontab -e
# Add: 0 2 * * * /home/ghartakmission/backup.sh
```

### Update Application
```bash
cd /home/ghartakmission/GharTak-Mission
git pull
source venv/bin/activate
cd core
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic --noinput
sudo systemctl restart ghartakmission
```

---

## 💡 Alternative: PaaS Deployment (Railway - Easy)

### Why Railway?
- ✅ Extremely easy setup
- ✅ Free tier available ($5 credit/month)
- ✅ Automatic HTTPS
- ✅ GitHub integration
- ❌ No face detection (no webcam)

### Railway Deployment Steps

**1. Prepare Repository**

Create `railway.json`:
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "cd core && gunicorn core.wsgi:application",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

Create `Procfile`:
```
web: cd core && gunicorn core.wsgi:application --bind 0.0.0.0:$PORT
```

Commit and push:
```bash
git add railway.json Procfile
git commit -m "Add Railway deployment config"
git push origin main
```

**2. Deploy on Railway**

1. Go to https://railway.app
2. Sign in with GitHub
3. Click "New Project"
4. Select "Deploy from GitHub repo"
5. Choose `KinshukSS2/GharTak-Mission`
6. Add environment variables:
   ```
   DJANGO_SECRET_KEY=your-secret-key
   DEBUG=False
   DATABASE_URL=(Railway will provide PostgreSQL)
   EMAIL_HOST_USER=your-email@gmail.com
   EMAIL_HOST_PASSWORD=your-app-password
   ```
7. Add PostgreSQL database (Railway marketplace)
8. Deploy!

**3. Run Migrations**
```bash
# In Railway dashboard terminal
cd core
python manage.py migrate
python manage.py createsuperuser
python manage.py collectstatic --noinput
```

---

## 📊 Deployment Comparison

| Feature | VPS (DigitalOcean) | PaaS (Railway/Render) | Docker (AWS ECS) |
|---------|-------------------|----------------------|------------------|
| **Setup Time** | 2-3 hours | 30 minutes | 4-5 hours |
| **Cost** | $5-10/month | Free - $7/month | $10-50/month |
| **Face Detection** | ✅ Yes | ❌ No | ✅ Yes |
| **Control** | ✅ Full | ⚠️ Limited | ✅ Full |
| **Scaling** | Manual | Automatic | Automatic |
| **SSL** | Free (Let's Encrypt) | Automatic | Configurable |
| **Maintenance** | You manage | Managed | Managed |
| **Best For** | Production | MVPs/Testing | Enterprise |

---

## 🎯 Recommendation

**For Your Use Case:**

1. **Start with VPS (DigitalOcean)** - Best for complete features including face detection
2. **Or use Railway** - If you want quick deployment and don't need face detection immediately

**My Recommendation: DigitalOcean VPS**
- Total cost: ~$6/month
- All features work (including face detection)
- Professional and scalable
- Good for portfolio/resume

---

## ✅ Final Checklist Before Deployment

- [ ] All code committed and pushed to GitHub
- [ ] Environment variables configured
- [ ] Strong SECRET_KEY generated
- [ ] Database credentials secure
- [ ] Email credentials configured
- [ ] Domain purchased (optional)
- [ ] Server/platform account created
- [ ] Backup strategy planned

---

## 🆘 Troubleshooting

### 502 Bad Gateway
```bash
sudo systemctl status ghartakmission
sudo journalctl -u ghartakmission -n 50
```

### Static Files Not Loading
```bash
cd /home/ghartakmission/GharTak-Mission/core
source ../venv/bin/activate
python manage.py collectstatic --noinput
sudo systemctl restart ghartakmission
```

### Database Connection Error
```bash
# Check PostgreSQL
sudo systemctl status postgresql
# Check DATABASE_URL in .env
```

---

## 📞 Need Help?

1. Check **DEPLOYMENT_ROADMAP.md** for detailed steps
2. Check **FIXES.md** for common issues
3. Review server logs: `sudo journalctl -u ghartakmission -n 100`
4. Check Nginx logs: `sudo tail -f /var/log/nginx/error.log`

---

**Total Deployment Time**: 2-3 hours (VPS) or 30 minutes (Railway)  
**Difficulty**: Intermediate (VPS) or Beginner (Railway)  
**Result**: Fully deployed, production-ready application! 🎉
