#!/bin/bash

# GharTak Mission - Setup Script
# Author: Kinshuk

echo "============================================"
echo "  GharTak Mission - Setup Script"
echo "============================================"
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"

# Check if we're in the correct directory
if [ ! -f "README.md" ]; then
    echo "Error: Please run this script from the project root directory."
    exit 1
fi

# Create virtual environment
echo ""
echo "Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo ""
echo "Upgrading pip..."
pip install --upgrade pip

# Install dependencies
echo ""
echo "Installing dependencies..."
cd core
pip install -r requirements.txt

if [ $? -ne 0 ]; then
    echo ""
    echo "Warning: Some packages failed to install."
    echo "This is common with dlib. Please check the DEPLOYMENT.md for troubleshooting."
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo ""
    echo "Creating .env file from template..."
    cp ../.env.example .env
    echo "✓ .env file created. Please edit it with your configuration."
else
    echo ""
    echo "✓ .env file already exists."
fi

# Remove old database
if [ -f "db.sqlite3" ]; then
    echo ""
    read -p "Remove existing database? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm db.sqlite3
        echo "✓ Old database removed."
    fi
fi

# Run migrations
echo ""
echo "Running database migrations..."
python manage.py makemigrations
python manage.py migrate

# Create media directories
echo ""
echo "Creating media directories..."
mkdir -p public/static/missing_persons

echo ""
echo "============================================"
echo "  Setup Complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "1. Edit core/.env with your configuration"
echo "2. Create a superuser: python manage.py createsuperuser"
echo "3. Run the server: python manage.py runserver"
echo ""
echo "For production deployment, see DEPLOYMENT.md"
echo ""
