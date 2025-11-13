# 🚀 Quick Start Scripts - GharTak Mission

## Easy Command Reference

### 🎯 Most Common - Just Run Everything
```bash
./run.sh
```
This will start the server and show you all the URLs and login details!

### 🔧 All Available Scripts:

#### 1. **./run.sh** - Quick Start (Recommended) ⭐
Starts the server with all information displayed.
```bash
./run.sh
```

#### 2. **./run-backend.sh** - Start Backend Server
Runs just the Django backend server.
```bash
./run-backend.sh
```

#### 3. **./run-detection.sh** - Face Detection Mode 📸
Runs face detection using your webcam (separate from web server).
```bash
./run-detection.sh
```
**Note:** Keep the web server running in another terminal!

#### 4. **./setup.sh** - Initial Setup
Run this ONCE to set up everything from scratch.
```bash
./setup.sh
```

#### 5. **./create-admin.sh** - Create Admin User
Create a new admin/superuser account interactively.
```bash
./create-admin.sh
```

#### 6. **./dev.sh** - Developer Tools
Interactive menu with development tools.
```bash
./dev.sh
```

---

## 📍 After Starting Server:

Visit these URLs in your browser:

- **Main Website:** http://127.0.0.1:8000
- **Admin Panel:** http://127.0.0.1:8000/admin
- **Register Missing Person:** http://127.0.0.1:8000/register/
- **View All Cases:** http://127.0.0.1:8000/missing/
- **Surveillance (Camera):** http://127.0.0.1:8000/surveillance/

---

## 🔐 Default Login:
- **Username:** admin
- **Password:** admin123

---

## ⚠️ Important:

1. **Email Configuration Required** - Edit `core/.env` file:
   ```
   EMAIL_HOST_USER=your-email@gmail.com
   EMAIL_HOST_PASSWORD=your-gmail-app-password
   ```

2. **Camera Access** - Surveillance feature needs webcam permissions

3. **Stop Server** - Press `Ctrl+C` in terminal

---

## 🆘 Troubleshooting:

### Server won't start?
```bash
./dev.sh
# Select option 6 to check for errors
```

### Need to reset database?
```bash
./dev.sh
# Select option 7 (Warning: deletes all data!)
```

### Dependencies issues?
```bash
./dev.sh
# Select option 8 to reinstall
```

---

## 📝 Manual Commands (if scripts don't work):

```bash
# Activate virtual environment
source venv/bin/activate

# Run server
cd core
python manage.py runserver

# Create superuser
python manage.py createsuperuser

# Run migrations
python manage.py migrate
```

---

**Author:** Kinshuk  
**Project:** GharTak Mission - Missing Person Detection System
