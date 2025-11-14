from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.contrib import messages
from django.core.mail import send_mail
from django.template.loader import render_to_string
from django.conf import settings
from datetime import datetime

# Optional imports for face detection
try:
    import face_recognition
    import cv2
    FACE_DETECTION_AVAILABLE = True
except ImportError:
    FACE_DETECTION_AVAILABLE = False
    print("⚠️  Warning: face_recognition/cv2 not installed. Face detection features will be disabled.")

# Optional Twilio import
try:
    from twilio.rest import Client
    TWILIO_AVAILABLE = True
except ImportError:
    TWILIO_AVAILABLE = False

from .models import MissingPerson, Location

#Add yourr own credentials
# account_sid = 'xxxxxxxxxxxxxxxxxxxxxxxxxxx'
# auth_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
# twilio_whatsapp_number = '+14155238886'


# Create your views here.
def home(request):
    return render(request,"index.html")

# def send_whatsapp_message(to,context):
#     client = Client(account_sid, auth_token)
#     whatsapp_message = (
#     f"Dear {context['fathers_name']},\n\n"
#     f"We are pleased to inform you that the missing person missing from {context['missing_from']} and you were concerned about has been found. "
#     "The person was located in a camera footage, and we have identified their whereabouts.\n\n"
#     "Here are the details:\n"
#     f" - Name: {context['first_name']} {context['last_name']}\n"
#     f" - Date and Time of Sighting: {context['date_time']}\n"
#     f" - Location: {context['location']}\n"
#     f" - Aadhar Number: {context['aadhar_number']}\n\n"
#     #"We understand the relief this news must bring to you. If you have any further questions or require more information, please do not hesitate to reach out to us.\n\n"
#     "Thank you for your cooperation and concern in this matter.\n\n"
#     "Sincerely,\n\n"
#     "Team GharTak Mission ")
#     message = client.messages.create(
#         body=whatsapp_message,
#         from_='whatsapp:' + twilio_whatsapp_number,
#         to='whatsapp:' + to
#     )
#     print(f"WhatsApp message sent: {message.sid}")
 
def detect(request):
    """
    Face detection function using webcam
    WARNING: This will block the server until detection is stopped (press 'q')
    For production, use the standalone script: run_face_detection.py
    """
    if not FACE_DETECTION_AVAILABLE:
        messages.warning(request, 
            'Face detection is not available. Please install face_recognition and opencv-python packages. '
            'For now, use the web interface for registration only.')
        return redirect('surveillance')
    
    try:
        video_capture = cv2.VideoCapture(0)
        
        if not video_capture.isOpened():
            messages.error(request, 'Could not open webcam. Please check if camera is connected and not in use.')
            return redirect('surveillance')
        
        # Initialize a flag to track if a face has been detected
        face_detected = False
        
        messages.info(request, 'Face detection started. A window should open. Press Q to quit.')
        
        while True:
            ret, frame = video_capture.read()
            
            if not ret:
                break
            
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
                            name = person.first_name + " " + person.last_name
                            matched_person = person
                            break
                    except Exception as e:
                        print(f"Error processing {person.first_name}: {e}")
                        continue
                
                # Draw rectangle and name
                color = (0, 255, 0) if matched_person else (0, 0, 255)
                cv2.rectangle(frame, (left, top), (right, bottom), color, 2)
                cv2.rectangle(frame, (left, bottom - 35), (right, bottom), color, cv2.FILLED)
                font = cv2.FONT_HERSHEY_DUPLEX
                cv2.putText(frame, name, (left + 6, bottom - 6), font, 0.6, (255, 255, 255), 1)

                # Send email if person is found and not already notified
                if matched_person and not face_detected:
                    print(f"Match found: {name}")
                    
                    current_time = datetime.now().strftime('%d-%m-%Y %H:%M')
                    subject = 'Missing Person Found - GharTak Mission'
                    from_email = settings.EMAIL_HOST_USER
                    recipientmail = matched_person.email
                    
                    context = {
                        "first_name": matched_person.first_name,
                        "last_name": matched_person.last_name,
                        'fathers_name': matched_person.father_name,
                        "aadhar_number": matched_person.aadhar_number,
                        "missing_from": matched_person.missing_from,
                        "date_time": current_time,
                        "location": "Camera Detection"
                    }
                    
                    try:
                        html_message = render_to_string('findemail.html', context=context)
                        send_mail(subject, '', from_email, [recipientmail], fail_silently=False, html_message=html_message)
                        face_detected = True
                        print(f"Email sent to {recipientmail}")
                    except Exception as e:
                        print(f"Error sending email: {e}")

            # Display the resulting image
            cv2.imshow('GharTak Mission - Face Detection (Press Q to quit)', frame)

            # Hit 'q' on the keyboard to quit
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
                
    except Exception as e:
        print(f"Error in face detection: {e}")
        messages.error(request, f'Face detection error: {str(e)}')
    finally:
        if 'video_capture' in locals():
            video_capture.release()
        cv2.destroyAllWindows()
    
    messages.success(request, 'Face detection stopped.')
    return redirect('surveillance')

def surveillance(request):
    """
    Surveillance page with instructions for face detection
    """
    return render(request, "surveillance.html")


def register(request):
    if request.method == 'POST':
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        father_name = request.POST.get('fathers_name')
        date_of_birth = request.POST.get('dob')
        address = request.POST.get('address')
        phone_number = request.POST.get('phonenum')
        aadhar_number = request.POST.get('aadhar_number')
        missing_from = request.POST.get('missing_date')
        email = request.POST.get('email')
        image = request.FILES.get('image')
        gender = request.POST.get('gender')
        aadhar = MissingPerson.objects.filter(aadhar_number=aadhar_number)
        if aadhar.exists():
            messages.info(request, 'Aadhar Number already exists')
            return redirect('/register')
        person = MissingPerson.objects.create(
            first_name = first_name,
            last_name = last_name,
            father_name = father_name,
            date_of_birth = date_of_birth,
            address = address,
            phone_number = phone_number,
            aadhar_number = aadhar_number,
            missing_from = missing_from,
            email = email,
            image = image,
            gender = gender,
        )
        person.save()
        messages.success(request,'Case Registered Successfully')
        current_time = datetime.now().strftime('%d-%m-%Y %H:%M')
        subject = 'Case Registered Successfully'
        from_email = settings.EMAIL_HOST_USER
        recipientmail = person.email
        context = {"first_name":person.first_name,"last_name":person.last_name,
                    'fathers_name':person.father_name,"aadhar_number":person.aadhar_number,
                    "missing_from":person.missing_from,"date_time":current_time}
        html_message = render_to_string('regmail.html',context = context)
        # Send the email
        send_mail(subject,'', from_email, [recipientmail], fail_silently=False, html_message=html_message)

    return render(request,"register.html")


def  missing(request):
    queryset = MissingPerson.objects.all()
    search_query = request.GET.get('search', '')
    if search_query:
        queryset = queryset.filter(aadhar_number__icontains=search_query)
    
    context = {'missingperson': queryset}
    return render(request,"missing.html",context)

def delete_person(request, person_id):
    person = get_object_or_404(MissingPerson, id=person_id)
    person.delete()
    return redirect('missing')  # Redirect to the missing view after deleting


def update_person(request, person_id):
    person = get_object_or_404(MissingPerson, id=person_id)

    if request.method == 'POST':
        # Retrieve data from the form
        first_name = request.POST.get('first_name', person.first_name)
        last_name = request.POST.get('last_name', person.last_name)
        father_name = request.POST.get('fathers_name', person.father_name)
        date_of_birth = request.POST.get('dob', person.date_of_birth)
        address = request.POST.get('address', person.address)
        email = request.POST.get('email', person.email)
        phone_number = request.POST.get('phonenum', person.phone_number)
        aadhar_number = request.POST.get('aadhar_number', person.aadhar_number)
        missing_from = request.POST.get('missing_date', person.missing_from)
        gender = request.POST.get('gender', person.gender)

        # Check if a new image is provided
        new_image = request.FILES.get('image')
        if new_image:
            person.image = new_image

        # Update the person instance
        person.first_name = first_name
        person.last_name = last_name
        person.father_name = father_name
        person.date_of_birth = date_of_birth
        person.address = address
        person.email = email
        person.phone_number = phone_number
        person.aadhar_number = aadhar_number
        person.missing_from = missing_from
        person.gender = gender

        # Save the changes
        person.save()

        return redirect('missing')  # Redirect to the missing view after editing

    return render(request, 'edit.html', {'person': person})

