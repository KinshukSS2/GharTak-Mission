# Quick Start Guide# 🎯 GharTak Mission - Quick Reference



## Get Started in 5 Minutes## Start Your Application



### Prerequisites```bash

cd /home/deadpool/Python-projects/Missing-Person-Detection-System

- Python 3.8 or higher./run.sh

- Webcam (for face detection)```

- Git

Then open: **http://127.0.0.1:8000**

### Installation

---

```bash

# Clone the repository## 🔐 Admin Login

git clone <repository-url>- **URL:** http://127.0.0.1:8000/admin

cd GharTak-Mission- **Username:** admin

- **Password:** admin123

# Set up virtual environment

python3 -m venv venv---

source venv/bin/activate  # On Windows: venv\Scripts\activate

## 📸 Face Detection

# Install dependencies

cd core**Keep server running, then in new terminal:**

pip install -r requirements.txt```bash

./run-detection.sh

# Set up environment variables```

cp .env.example .env

nano .env  # Edit with your settingsPress **Q** to quit detection window.



# Initialize database---

python manage.py migrate

## ⚙️ Configuration Required

# Create admin user

python manage.py createsuperuserEdit `core/.env` file:



# Run the server```properties

python manage.py runserverEMAIL_HOST_USER=your-email@gmail.com

```EMAIL_HOST_PASSWORD=your-gmail-app-password

```

Visit: **http://127.0.0.1:8000**

**Get Gmail App Password:**

## Essential Configuration1. https://myaccount.google.com/security

2. Enable 2-Step Verification

### Email Setup (Required for Alerts)3. https://myaccount.google.com/apppasswords

4. Create password for "Mail"

Edit `core/.env`:5. Copy 16-character password



```properties---

EMAIL_HOST_USER=your-email@gmail.com

EMAIL_HOST_PASSWORD=your-app-password## 🛠️ Common Commands

```

```bash

**Get Gmail App Password:**./run.sh              # Start server

1. Go to https://myaccount.google.com/security./run-detection.sh    # Run face detection

2. Enable 2-Step Verification./create-admin.sh     # Create new admin

3. Visit https://myaccount.google.com/apppasswords./dev.sh              # Developer menu

4. Create app password for "Mail"```

5. Use the 16-character password in .env

---

## Using Shell Scripts (Optional)

## 🔗 Important URLs

Make scripts executable:

```bash- **Home:** http://127.0.0.1:8000/

chmod +x *.sh- **Register Case:** http://127.0.0.1:8000/register/

```- **View Cases:** http://127.0.0.1:8000/missing/

- **Admin:** http://127.0.0.1:8000/admin/

Quick commands:

```bash---

./run.sh              # Start the server

./setup.sh            # Initial setup## ⚠️ Troubleshooting

./create-admin.sh     # Create admin user

```### Server won't start?

```bash

## Key Features./dev.sh

# Select option 6 to check

### Register a Missing Person```

1. Navigate to **Register Case** page

2. Fill in personal details### Face detection not working?

3. Upload a clear photo1. Check webcam is connected

4. Submit the form2. Check .env has email configured

3. Make sure server is running

### Run Face Detection

```bash### Email not sending?

# Terminal 1: Keep server runningEdit `core/.env` with Gmail credentials

python manage.py runserver

---

# Terminal 2: Run face detection

cd core## 📱 Features

python run_face_detection.py

```✅ Register missing persons  

✅ View all cases  

Press **'Q'** to quit the detection window.✅ Search by Aadhar number  

✅ Admin management  

### Admin Panel✅ Face detection with webcam  

✅ Email alerts on match  

Access: **http://127.0.0.1:8000/admin**✅ Update/delete records  



Features:---

- View all registered cases

- Update case information**Project:** GharTak Mission  

- Delete resolved cases**Owner:** Kinshuk  

- Manage user accounts**Tech:** Django, OpenCV, Face Recognition, SQLite


## Important URLs

- **Home:** http://127.0.0.1:8000/
- **Register Case:** http://127.0.0.1:8000/register/
- **View Cases:** http://127.0.0.1:8000/missing/
- **Surveillance:** http://127.0.0.1:8000/surveillance/
- **Admin:** http://127.0.0.1:8000/admin/

## Common Commands

```bash
# Start development server
python manage.py runserver

# Create admin user
python manage.py createsuperuser

# Apply database migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic

# Run tests
python manage.py test
```

## Troubleshooting

### Server Won't Start

Check for port conflicts:
```bash
# Kill process on port 8000
lsof -ti:8000 | xargs kill -9

# Or use different port
python manage.py runserver 8080
```

### Face Detection Not Working

1. Check webcam connection
2. Install camera drivers if needed
3. Verify OpenCV installation:
   ```bash
   python -c "import cv2; print(cv2.__version__)"
   ```

### Database Errors

Reset database:
```bash
rm db.sqlite3
python manage.py migrate
python manage.py createsuperuser
```

### Static Files Not Loading

```bash
python manage.py collectstatic --noinput
```

## Next Steps

- Read the full [README.md](README.md) for detailed documentation
- Check [DEPLOYMENT.md](DEPLOYMENT.md) for production deployment
- Review [PRODUCTION_READY.md](PRODUCTION_READY.md) for deployment checklist

## Support

- Check existing documentation files
- Review error logs in the console
- Ensure all dependencies are installed correctly

---

**Happy Coding!** 🚀
