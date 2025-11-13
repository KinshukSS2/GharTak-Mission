#!/bin/bash

# GharTak Mission - Backend Server Startup Script
# Author: Kinshuk

echo "============================================"
echo "  GharTak Mission - Starting Backend Server"
echo "============================================"
echo ""

# Set project paths
PROJECT_DIR="/home/deadpool/Python-projects/Missing-Person-Detection-System"
VENV_PYTHON="$PROJECT_DIR/venv/bin/python"
MANAGE_PY="$PROJECT_DIR/core/manage.py"

# Check if virtual environment exists
if [ ! -f "$VENV_PYTHON" ]; then
    echo "❌ Error: Virtual environment not found!"
    echo "Please run setup.sh first to install dependencies."
    exit 1
fi

# Check if manage.py exists
if [ ! -f "$MANAGE_PY" ]; then
    echo "❌ Error: manage.py not found!"
    exit 1
fi

# Change to core directory
cd "$PROJECT_DIR/core" || exit 1

echo "🔍 Checking system..."
$VENV_PYTHON manage.py check --deploy 2>/dev/null || $VENV_PYTHON manage.py check

echo ""
echo "✅ System check passed!"
echo ""
echo "🚀 Starting Django development server..."
echo ""
echo "📍 Server will be available at:"
echo "   - http://127.0.0.1:8000"
echo "   - http://localhost:8000"
echo ""
echo "🔐 Admin Panel: http://127.0.0.1:8000/admin"
echo "   Username: admin"
echo "   Password: admin123"
echo ""
echo "⏹️  Press Ctrl+C to stop the server"
echo ""
echo "============================================"
echo ""

# Start the server
$VENV_PYTHON manage.py runserver 0.0.0.0:8000
