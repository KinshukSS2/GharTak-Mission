#!/bin/bash

# GharTak Mission - Pre-Deployment Testing Script
# This script runs comprehensive tests before deployment

echo "=============================================="
echo "  🧪 GharTak Mission - Pre-Deployment Tests"
echo "=============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PASSED=0
FAILED=0
WARNINGS=0

# Test function
test_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASSED${NC}: $2"
        ((PASSED++))
    else
        echo -e "${RED}✗ FAILED${NC}: $2"
        ((FAILED++))
    fi
}

warn_result() {
    echo -e "${YELLOW}⚠ WARNING${NC}: $1"
    ((WARNINGS++))
}

echo "📋 Running Pre-Deployment Tests..."
echo ""

# Test 1: Check Python version
echo "Test 1: Python Version"
python3 --version 2>&1 | grep -q "Python 3"
test_result $? "Python 3.x is installed"
echo ""

# Test 2: Check if virtual environment exists
echo "Test 2: Virtual Environment"
if [ -d "venv" ]; then
    test_result 0 "Virtual environment exists"
else
    test_result 1 "Virtual environment not found"
    warn_result "Run: python3 -m venv venv"
fi
echo ""

# Test 3: Check if .env file exists
echo "Test 3: Environment Configuration"
if [ -f "core/.env" ]; then
    test_result 0 ".env file exists"
    
    # Check for required variables
    if grep -q "DJANGO_SECRET_KEY" core/.env && grep -q "EMAIL_HOST_USER" core/.env; then
        test_result 0 "Required environment variables present"
    else
        test_result 1 "Missing required environment variables"
    fi
else
    test_result 1 ".env file not found"
    warn_result "Copy .env.example to core/.env and configure it"
fi
echo ""

# Test 4: Check Git status
echo "Test 4: Git Repository"
if git status &>/dev/null; then
    test_result 0 "Git repository initialized"
    
    if [ -z "$(git status --porcelain)" ]; then
        test_result 0 "No uncommitted changes"
    else
        warn_result "Uncommitted changes detected"
    fi
else
    test_result 1 "Not a Git repository"
fi
echo ""

# Test 5: Check required files
echo "Test 5: Required Files"
FILES=("core/manage.py" "core/requirements.txt" "core/core/settings.py" "README.md")
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        test_result 0 "$file exists"
    else
        test_result 1 "$file missing"
    fi
done
echo ""

# Test 6: Check if dependencies are installed (if venv exists)
echo "Test 6: Dependencies"
if [ -d "venv" ]; then
    if [ -f "venv/bin/activate" ]; then
        source venv/bin/activate
        
        # Check for Django
        python -c "import django" 2>/dev/null
        test_result $? "Django installed"
        
        # Check for face_recognition
        python -c "import face_recognition" 2>/dev/null
        test_result $? "face_recognition installed"
        
        # Check for OpenCV
        python -c "import cv2" 2>/dev/null
        test_result $? "OpenCV installed"
        
        deactivate
    fi
else
    warn_result "Virtual environment not found - skipping dependency checks"
fi
echo ""

# Test 7: Check database
echo "Test 7: Database"
if [ -f "core/db.sqlite3" ]; then
    test_result 0 "Database file exists"
else
    warn_result "Database not initialized - run migrations"
fi
echo ""

# Test 8: Check static files
echo "Test 8: Static Files"
if [ -d "core/public/static" ]; then
    test_result 0 "Static files directory exists"
else
    test_result 1 "Static files directory missing"
fi
echo ""

# Test 9: Security checks
echo "Test 9: Security Configuration"
if [ -f "core/.env" ]; then
    if grep -q "DEBUG=True" core/.env; then
        warn_result "DEBUG is set to True (should be False for production)"
    else
        test_result 0 "DEBUG setting appropriate"
    fi
    
    if grep -q "django-insecure" core/.env; then
        test_result 1 "Using default SECRET_KEY (SECURITY RISK)"
    else
        test_result 0 "Custom SECRET_KEY configured"
    fi
fi
echo ""

# Test 10: Check permissions
echo "Test 10: File Permissions"
if [ -x "run.sh" ]; then
    test_result 0 "Shell scripts are executable"
else
    warn_result "Shell scripts not executable - run: chmod +x *.sh"
fi
echo ""

# Summary
echo "=============================================="
echo "  📊 Test Summary"
echo "=============================================="
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
echo ""

if [ $FAILED -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed! Ready for deployment.${NC}"
    exit 0
elif [ $FAILED -eq 0 ]; then
    echo -e "${YELLOW}⚠ Tests passed with warnings. Review warnings before deployment.${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Fix issues before deployment.${NC}"
    echo ""
    echo "Quick Setup Guide:"
    echo "1. Create virtual environment: python3 -m venv venv"
    echo "2. Activate it: source venv/bin/activate"
    echo "3. Install dependencies: cd core && pip install -r requirements.txt"
    echo "4. Create .env file: cp .env.example core/.env && nano core/.env"
    echo "5. Run migrations: python manage.py migrate"
    echo "6. Create superuser: python manage.py createsuperuser"
    echo "7. Run this test again: ./test-deployment.sh"
    exit 1
fi
