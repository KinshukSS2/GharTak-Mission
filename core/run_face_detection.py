#!/usr/bin/env python
"""
GharTak Mission - Standalone Face Detection Script
Author: Kinshuk

This script runs face detection independently of the web server.
It opens your webcam and compares faces with the missing persons database.

Usage:
    python run_face_detection.py
    
Press 'q' to quit the detection window.
"""

import os
import sys
import django

# Setup Django environment
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from datetime import datetime
import cv2
import face_recognition
from django.core.mail import send_mail
from django.template.loader import render_to_string
from missingperson.models import MissingPerson

def run_detection():
    """Run face detection using webcam"""
    print("=" * 60)
    print("  GharTak Mission - Face Detection Mode")
    print("=" * 60)
    print("\n🎥 Initializing webcam...")
    
    video_capture = cv2.VideoCapture(0)
    
    if not video_capture.isOpened():
        print("❌ Error: Could not open webcam!")
        print("Please check:")
        print("  1. Webcam is connected")
        print("  2. No other application is using the webcam")
        print("  3. You have permission to access the webcam")
        return
    
    print("✅ Webcam initialized successfully!")
    print("\n📸 Starting face detection...")
    print("   Press 'q' to quit\n")
    print("=" * 60)
    
    # Track detected faces to avoid sending duplicate emails
    detected_faces = set()
    frame_count = 0
    
    try:
        while True:
            ret, frame = video_capture.read()
            frame_count += 1
            
            if not ret:
                print("❌ Failed to grab frame")
                break
            
            # Process every 5th frame to improve performance
            if frame_count % 5 != 0:
                cv2.imshow('GharTak Mission - Face Detection (Press Q to quit)', frame)
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break
                continue
            
            # Find face locations and encodings in the current frame
            face_locations = face_recognition.face_locations(frame)
            face_encodings = face_recognition.face_encodings(frame, face_locations)
            
            for face_encoding, (top, right, bottom, left) in zip(face_encodings, face_locations):
                name = "Unknown"
                matched_person = None
                
                # Compare detected face with stored face images
                for person in MissingPerson.objects.all():
                    try:
                        stored_image = face_recognition.load_image_file(person.image.path)
                        stored_face_encodings = face_recognition.face_encodings(stored_image)
                        
                        if not stored_face_encodings:
                            continue
                            
                        stored_face_encoding = stored_face_encodings[0]
                        matches = face_recognition.compare_faces([stored_face_encoding], face_encoding, tolerance=0.6)
                        
                        if any(matches):
                            name = f"{person.first_name} {person.last_name}"
                            matched_person = person
                            break
                    except Exception as e:
                        print(f"⚠️  Error processing image for {person.first_name}: {e}")
                        continue
                
                # Draw rectangle and name
                color = (0, 255, 0) if matched_person else (0, 0, 255)
                cv2.rectangle(frame, (left, top), (right, bottom), color, 2)
                cv2.rectangle(frame, (left, bottom - 35), (right, bottom), color, cv2.FILLED)
                font = cv2.FONT_HERSHEY_DUPLEX
                cv2.putText(frame, name, (left + 6, bottom - 6), font, 0.6, (255, 255, 255), 1)
                
                # Send email if person is found and not already notified
                if matched_person and matched_person.id not in detected_faces:
                    print(f"\n🎯 MATCH FOUND: {name}")
                    print("📧 Sending email notification...")
                    
                    try:
                        current_time = datetime.now().strftime('%d-%m-%Y %H:%M')
                        subject = 'Missing Person Found - GharTak Mission'
                        from_email = 'ghartakmission@example.com'
                        recipient_email = matched_person.email
                        
                        context = {
                            "first_name": matched_person.first_name,
                            "last_name": matched_person.last_name,
                            'fathers_name': matched_person.father_name,
                            "aadhar_number": matched_person.aadhar_number,
                            "missing_from": matched_person.missing_from,
                            "date_time": current_time,
                            "location": "Camera Detection System"
                        }
                        
                        html_message = render_to_string('findemail.html', context=context)
                        send_mail(
                            subject, 
                            '', 
                            from_email, 
                            [recipient_email], 
                            fail_silently=False, 
                            html_message=html_message
                        )
                        
                        detected_faces.add(matched_person.id)
                        print(f"✅ Email sent to {recipient_email}")
                        print("=" * 60)
                        
                    except Exception as e:
                        print(f"❌ Error sending email: {e}")
                        print("   Check your email configuration in .env file")
            
            # Display the resulting image
            cv2.imshow('GharTak Mission - Face Detection (Press Q to quit)', frame)
            
            # Hit 'q' on the keyboard to quit
            if cv2.waitKey(1) & 0xFF == ord('q'):
                print("\n👋 Stopping face detection...")
                break
                
    except KeyboardInterrupt:
        print("\n\n⚠️  Detection stopped by user")
    except Exception as e:
        print(f"\n❌ Error during detection: {e}")
    finally:
        video_capture.release()
        cv2.destroyAllWindows()
        print("✅ Camera released")
        print("=" * 60)
        print("Thank you for using GharTak Mission!")
        print("=" * 60)

if __name__ == "__main__":
    run_detection()
