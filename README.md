# GharTak Mission: Missing Person Detection System# 🕵️‍♂️ GharTak Mission: Missing Person Detection System! 📸# 🕵️‍♂️ Bharatiya Rescue:Missing Person Detection System! 📸



A Django-based missing person detection system that uses facial recognition technology to help reunite missing individuals with their families.Bharatiya Rescue is an innovative project aimed at leveraging cutting-edge technology to help reunite missing individuals with their loved ones. Our user-friendly system, built using Django, HTML, CSS, JavaScript, OpenCV, and the `facerecognition` library, combines a smooth UI with robust functionality to ensure an efficient and seamless experience for all users.



## FeaturesGharTak Mission is an innovative project aimed at leveraging cutting-edge technology to help reunite missing individuals with their loved ones. Our user-friendly system, built using Django, HTML, CSS, JavaScript, OpenCV, and the `facerecognition` library, combines a smooth UI with robust functionality to ensure an efficient and seamless experience for all users.



- **Missing Person Registration**: Submit detailed information including photographs, personal details, and contact information## How It Works

- **Facial Recognition**: Automated face detection and matching using OpenCV and face recognition libraries

- **Real-time Alerts**: Automatic email notifications to family members and authorities when a match is found## How It Works1. **Register a missing person complaint** with essential details like a recent photograph, name, address, Aadhar number, email, and mobile number.

- **Location Tracking**: Secure storage of last known locations

- **Admin Dashboard**: Comprehensive management interface for case tracking and resolution1. **Register a missing person complaint** with essential details like a recent photograph, name, address, Aadhar number, email, and mobile number.2. **Surveillance mode**: The system uses facial recognition to detect the missing person's face. If a match is found, an email alert is automatically sent to the parents and the police.



## Technology Stack2. **Surveillance mode**: The system uses facial recognition to detect the missing person's face. If a match is found, an email alert is automatically sent to the parents and the police.3. **Location storage**: The system stores the missing person's last known location in a secure database.



- **Backend**: Django (Python)3. **Location storage**: The system stores the missing person's last known location in a secure database.4. **Admin management**: Admins can remove entries when the missing person is found, maintaining an up-to-date and efficient system.

- **Frontend**: HTML, CSS, JavaScript

- **Computer Vision**: OpenCV, face_recognition library4. **Admin management**: Admins can remove entries when the missing person is found, maintaining an up-to-date and efficient system.

- **Database**: SQLite (development), PostgreSQL/MySQL (production ready)

## Future Enhancements

## Quick Start

## Future Enhancements- Integration with advanced AI algorithms and machine learning models for improved face recognition accuracy.

### Prerequisites

- Integration with advanced AI algorithms and machine learning models for improved face recognition accuracy.- Use of geospatial technology for real-time tracking.

- Python 3.8 or higher

- pip package manager- Use of geospatial technology for real-time tracking.- Integration with social media and public alert systems to increase community response.

- Virtual environment (recommended)

- Integration with social media and public alert systems to increase community response.- Collaboration with law enforcement and technology innovators for continuous improvements.

### Installation

- Collaboration with law enforcement and technology innovators for continuous improvements.

1. **Clone the repository**

```bash

git clone <repository-url>

cd GharTak-Mission## Getting Started

```

### Prerequisites## Getting Started

2. **Set up virtual environment**

```bash- Python 3.x### Prerequisites

python -m venv venv

source venv/bin/activate  # On Windows: venv\Scripts\activate- `pip` (Python package installer)- Python 3.x

```

- `pip` (Python package installer)

3. **Install dependencies**

```bash

cd core

pip install -r requirements.txt### Set Up Virtual Environment

```

```bash### Set Up Virtual Environment

4. **Initialize database**

```bashpython -m venv venv```bash

python manage.py migrate

```source venv/bin/activate  # For Windows use: venv\Scripts\activatepython -m venv venv



5. **Create admin user**```source venv/bin/activate  # For Windows use: venv\Scripts\activate

```bash

python manage.py createsuperuser```

```

### Install Dependencies

6. **Run the development server**

```bash```bash### Install Dependencies

python manage.py runserver

```cd core```bash



Visit `http://localhost:8000` to access the application.pip install -r requirements.txtpip install -r requirements.txt



## Usage``````



1. **Register Missing Person**: Navigate to the registration page and submit complete details with a clear photograph

2. **Surveillance Mode**: Activate face detection to monitor for matches

3. **Receive Alerts**: Get automatic notifications when a potential match is detected### Create a New Database### Create a New Database

4. **Admin Management**: Use the admin panel to manage cases and mark resolved cases

Delete the existing `db.sqlite3` file (if present):Delete the existing `db.sqlite3` file (if present):

## Project Structure

```bash```bash

```

GharTak-Mission/rm db.sqlite3  # For Windows, use: del db.sqlite3rm db.sqlite3  # For Windows, use: del db.sqlite3

├── core/                  # Main Django project

│   ├── manage.py``````

│   ├── requirements.txt

│   ├── core/             # Project settings

│   ├── missingperson/    # Main application

│   └── public/           # Static files and mediaCreate a new database:Create a new database:

├── scripts/              # Utility scripts

└── docs/                 # Documentation```bash```bash

```

python manage.py migratepython manage.py migrate

## Configuration

``````

- Configure email settings in `core/settings.py` for alert notifications

- Adjust face recognition sensitivity parameters as needed

- Set up proper media file storage for production deployment

### Create Admin Superuser### Create Admin Superuser

## Future Roadmap

```bash```bash

- Enhanced AI/ML models for improved accuracy

- Integration with government databases (with proper authorization)python manage.py createsuperuserpython manage.py createsuperuser

- Mobile application for wider accessibility

- Real-time geospatial tracking``````

- Social media integration for community alerts

Follow the prompts to set up your admin username, email, and password.Follow the prompts to set up your admin username, email, and password.

## Contributing



Contributions are welcome! Please feel free to submit issues or pull requests.

### Run the Server### Run the Server

## License

```bash```bash

This project is developed for educational and humanitarian purposes.

python manage.py runserverpython manage.py runserver

## Support

``````

For questions or support, please open an issue in the repository.

Open http://127.0.0.1:8000 in your browser.

---



**Note**: This system is designed to assist in locating missing persons and should be used in coordination with proper law enforcement authorities.
