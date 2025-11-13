#!/bin/bash

# GharTak Mission - Development Helper Script
# Author: Kinshuk

echo "============================================"
echo "  🛠️  GharTak Mission - Development Tools"
echo "============================================"
echo ""
echo "Available Commands:"
echo ""
echo "  1) Run Server          - Start the Django development server"
echo "  2) Run Migrations      - Apply database migrations"
echo "  3) Make Migrations     - Create new migrations"
echo "  4) Create Superuser    - Create admin account"
echo "  5) Shell               - Open Django shell"
echo "  6) Check               - Run system checks"
echo "  7) Clear Database      - Delete and recreate database"
echo "  8) Install Deps        - Reinstall dependencies"
echo "  9) Exit"
echo ""
read -p "Select option [1-9]: " choice

PROJECT_DIR="/home/deadpool/Python-projects/Missing-Person-Detection-System"
VENV_PYTHON="$PROJECT_DIR/venv/bin/python"
cd "$PROJECT_DIR/core" || exit 1

case $choice in
    1)
        echo ""
        echo "🚀 Starting server..."
        $VENV_PYTHON manage.py runserver 0.0.0.0:8000
        ;;
    2)
        echo ""
        echo "📦 Running migrations..."
        $VENV_PYTHON manage.py migrate
        echo "✅ Done!"
        ;;
    3)
        echo ""
        echo "📝 Making migrations..."
        $VENV_PYTHON manage.py makemigrations
        echo "✅ Done!"
        ;;
    4)
        echo ""
        echo "👤 Creating superuser..."
        $VENV_PYTHON manage.py createsuperuser
        ;;
    5)
        echo ""
        echo "🐍 Opening Django shell..."
        $VENV_PYTHON manage.py shell
        ;;
    6)
        echo ""
        echo "🔍 Running system checks..."
        $VENV_PYTHON manage.py check
        ;;
    7)
        echo ""
        read -p "⚠️  This will delete all data! Continue? (y/N): " confirm
        if [[ $confirm == [yY] ]]; then
            rm -f db.sqlite3
            echo "🗑️  Database deleted"
            $VENV_PYTHON manage.py migrate
            echo "✅ New database created!"
            echo ""
            echo "Create a new superuser:"
            $VENV_PYTHON manage.py createsuperuser
        fi
        ;;
    8)
        echo ""
        echo "📥 Installing dependencies..."
        cd "$PROJECT_DIR"
        ./venv/bin/pip install -r core/requirements.txt
        echo "✅ Done!"
        ;;
    9)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid option"
        exit 1
        ;;
esac
