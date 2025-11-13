#!/bin/bash
# Script to create a proper commit history for GharTak Mission

cd /home/deadpool/Python-projects/GharTak-Mission

echo "Creating commit history for GharTak Mission..."

# Commit 1: Initial project structure
git add core/core/ core/manage.py core/requirements.txt
git commit -m "Initial Django project setup

- Created core Django project structure
- Added settings and URL configuration
- Set up project dependencies"

# Commit 2: Missing person app
git add core/missingperson/models.py core/missingperson/admin.py core/missingperson/__init__.py core/missingperson/apps.py core/missingperson/tests.py core/missingperson/migrations/
git commit -m "Add missing person tracking app

- Created MissingPerson and Location models
- Set up admin interface for data management
- Added initial database migrations"

# Commit 3: Face detection views
git add core/missingperson/views.py
git commit -m "Implement face detection and surveillance features

- Added webcam face recognition using OpenCV
- Integrated face_recognition library for matching
- Created email notification system for found persons
- Added registration and management views"

# Commit 4: Frontend templates
git add core/missingperson/templates/index.html core/missingperson/templates/register.html core/missingperson/templates/missing.html
git commit -m "Add main frontend templates

- Created responsive landing page with Bootstrap
- Added missing person registration form
- Implemented missing persons list view
- Added search functionality"

# Commit 5: Surveillance and detection templates  
git add core/missingperson/templates/surveillance.html core/missingperson/templates/detect.html core/missingperson/templates/edit.html
git commit -m "Add surveillance mode templates

- Created surveillance control interface
- Added person edit functionality
- Implemented detection confirmation UI"

# Commit 6: Email templates
git add core/missingperson/templates/findemail.html core/missingperson/templates/regmail.html
git commit -m "Add email notification templates

- Created HTML email for found person alerts
- Added registration confirmation emails
- Styled emails with professional layout"

# Commit 7: Static assets - CSS
git add core/public/static/assets/css/ core/public/static/img/
git commit -m "Add custom CSS and images

- Implemented custom styling for GharTak Mission theme
- Added hero images and branding assets
- Configured favicon and app icons"

# Commit 8: Static assets - JavaScript
git add core/public/static/assets/js/
git commit -m "Add JavaScript functionality

- Implemented smooth scrolling and navigation
- Added form validation helpers
- Fixed querySelector empty string bug"

# Commit 9: Bootstrap framework
git add core/public/static/assets/vendor/bootstrap/
git commit -m "Integrate Bootstrap 5 framework

- Added Bootstrap CSS and JS bundles
- Configured responsive grid system
- Included RTL support files"

# Commit 10: Additional vendor libraries
git add core/public/static/assets/vendor/aos/ core/public/static/assets/vendor/glightbox/ core/public/static/assets/vendor/swiper/
git commit -m "Add animation and UI enhancement libraries

- Integrated AOS (Animate On Scroll) library
- Added GLightbox for image galleries
- Included Swiper for carousels"

# Commit 11: Icon libraries
git add core/public/static/assets/vendor/bootstrap-icons/ core/public/static/assets/vendor/boxicons/ core/public/static/assets/vendor/remixicon/
git commit -m "Add icon libraries

- Integrated Bootstrap Icons
- Added Boxicons for diverse iconography
- Included Remixicon for modern icons"

# Commit 12: Remaining vendor libraries
git add core/public/static/assets/vendor/isotope-layout/ core/public/static/assets/vendor/waypoints/ core/public/static/assets/vendor/php-email-form/
git commit -m "Complete vendor library integration

- Added Isotope for filterable layouts
- Included Waypoints for scroll-triggered events
- Added form validation utilities"

# Commit 13: Environment configuration
git add core/.env .env.example .gitignore
git commit -m "Configure environment and security settings

- Added .env file for sensitive configuration
- Created .env.example template
- Configured .gitignore for Python/Django projects
- Set up email and database configuration"

# Commit 14: Shell scripts and automation
git add *.sh
git commit -m "Add deployment and automation scripts

- Created run.sh for quick server startup
- Added setup.sh for environment initialization
- Included create-admin.sh for superuser creation
- Added dev.sh and run-backend.sh utilities"

# Commit 15: Documentation
git add README.md QUICKSTART.md DEPLOYMENT.md SCRIPTS.md FIXES.md
git commit -m "Add comprehensive project documentation

- Created detailed README with project overview
- Added QUICKSTART guide for quick setup
- Included DEPLOYMENT instructions
- Documented all shell scripts
- Added FIXES log for bug resolutions"

# Commit 16: Standalone detection script
git add core/run_face_detection.py
git commit -m "Add standalone face detection script

- Created independent detection script
- Allows face recognition without web server
- Includes error handling and user feedback"

# Commit 17: Profile and branding updates
git add core/media/img/team/ core/public/media/img/team/
git commit -m "Update team section and profile pictures

- Replaced team members with Kinshuk Sanand
- Added new profile picture
- Updated team section layout"

# Commit 18: Requirements file
git add core/requirements_utf8.txt
git commit -m "Fix requirements.txt encoding

- Created UTF-8 encoded requirements file
- Ensures proper dependency installation"

# Commit 19: Final fixes and production prep
git add core/missingperson/templates/*.html
git commit -m "Apply branding changes and final fixes

- Changed all 'Bharatiya Rescue' to 'GharTak Mission'
- Fixed CSRF token in newsletter form
- Removed locations page 404 error
- Updated email configuration to use settings
- Added camera confirmation dialog
- Fixed syntax errors in views.py"

echo "✅ Commit history created successfully!"
echo "Total commits: $(git log --oneline | wc -l)"
