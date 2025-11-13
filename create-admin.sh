#!/bin/bash

# GharTak Mission - Create/Reset Admin User
# Author: Kinshuk

echo "============================================"
echo "  👤 GharTak Mission - Create Admin User"
echo "============================================"
echo ""

PROJECT_DIR="/home/deadpool/Python-projects/Missing-Person-Detection-System"
VENV_PYTHON="$PROJECT_DIR/venv/bin/python"

cd "$PROJECT_DIR/core" || exit 1

echo "Creating superuser account..."
echo ""

# Interactive superuser creation
$VENV_PYTHON manage.py createsuperuser

echo ""
echo "✅ Superuser created successfully!"
echo ""
