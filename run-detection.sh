#!/bin/bash

# GharTak Mission - Run Face Detection
# Author: Kinshuk

echo "============================================"
echo "  📸 GharTak Mission - Face Detection Mode"
echo "============================================"
echo ""

PROJECT_DIR="/home/deadpool/Python-projects/Missing-Person-Detection-System"
VENV_PYTHON="$PROJECT_DIR/venv/bin/python"
SCRIPT="$PROJECT_DIR/core/run_face_detection.py"

# Check if virtual environment exists
if [ ! -f "$VENV_PYTHON" ]; then
    echo "❌ Error: Virtual environment not found!"
    echo "Please run setup.sh first."
    exit 1
fi

# Check if script exists
if [ ! -f "$SCRIPT" ]; then
    echo "❌ Error: Face detection script not found!"
    exit 1
fi

echo "⚠️  IMPORTANT NOTES:"
echo ""
echo "  1. Make sure the web server is running in another terminal"
echo "  2. This will open a window with your webcam feed"
echo "  3. Press 'Q' to stop detection"
echo "  4. Email alerts will be sent when a match is found"
echo ""
echo "============================================"
echo ""
read -p "Press Enter to start face detection..."
echo ""

# Run the detection script
cd "$PROJECT_DIR/core"
$VENV_PYTHON run_face_detection.py
