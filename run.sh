#!/bin/bash

# GharTak Mission - Quick Start Script
# Author: Kinshuk
# This script runs the complete application

echo "============================================"
echo "  🚀 GharTak Mission - Quick Start"
echo "============================================"
echo ""

# Set project paths
PROJECT_DIR="/home/deadpool/Python-projects/Missing-Person-Detection-System"
VENV_PYTHON="$PROJECT_DIR/venv/bin/python"

# Check if virtual environment exists
if [ ! -d "$PROJECT_DIR/venv" ]; then
    echo "❌ Virtual environment not found!"
    echo "Running initial setup..."
    echo ""
    bash "$PROJECT_DIR/setup.sh"
    if [ $? -ne 0 ]; then
        echo "❌ Setup failed. Please check the errors above."
        exit 1
    fi
fi

# Change to core directory
cd "$PROJECT_DIR/core" || exit 1

echo "🔍 Running system checks..."
$VENV_PYTHON manage.py check

if [ $? -ne 0 ]; then
    echo ""
    echo "⚠️  System check found issues, but continuing anyway..."
    echo ""
fi

echo ""
echo "✅ Starting server..."
echo ""
echo "📍 Access your application at:"
echo "   🌐 Main Site: http://127.0.0.1:8000"
echo "   🔐 Admin Panel: http://127.0.0.1:8000/admin"
echo ""
echo "🎯 Quick Links:"
echo "   • Home: http://127.0.0.1:8000/"
echo "   • Register Missing Person: http://127.0.0.1:8000/register/"
echo "   • View Missing Persons: http://127.0.0.1:8000/missing/"
echo "   • Surveillance: http://127.0.0.1:8000/surveillance/"
echo ""
echo "👤 Admin Credentials:"
echo "   Username: admin"
echo "   Password: admin123"
echo ""
echo "⏹️  Press Ctrl+C to stop the server"
echo ""
echo "============================================"
echo ""

# Start the server
$VENV_PYTHON manage.py runserver 0.0.0.0:8000
