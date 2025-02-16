from flask import Flask, request, jsonify
import boto3
import firebase_admin
from firebase_admin import credentials, firestore
import random
import string
import datetime

# Initialize Firebase
cred = credentials.Certificate("path/to/your/firebase-adminsdk.json")  # Replace with correct path
firebase_admin.initialize_app(cred)
db = firestore.client()

# AWS SES Configuration
AWS_REGION = "us-east-1"  # Replace with your AWS region
SENDER_EMAIL = "your-email@example.com"  # Replace with your verified email in SES
ses_client = boto3.client("ses", region_name=AWS_REGION)

app = Flask(__name__)

def generate_otp():
    return "".join(random.choices(string.digits, k=4))

@app.route("/send-otp", methods=["POST"])
def send_otp():
    data = request.get_json()
    email = data.get("email")

    if not email:
        return jsonify({"success": False, "message": "Email is required"}), 400

    otp = generate_otp()
    expiry_time = datetime.datetime.utcnow() + datetime.timedelta(minutes=5)

    # Store OTP in Firestore
    db.collection("otp_verification").document(email).set({
        "otp": otp,
        "expiry": expiry_time.isoformat(),
    })

    # Send OTP via AWS SES
    subject = "Your OTP Code for Password Reset"
    body = f"Your OTP code is {otp}. It is valid for 5 minutes."
    ses_client.send_email(
        Source=SENDER_EMAIL,
        Destination={"ToAddresses": [email]},
        Message={
            "Subject": {"Data": subject},
            "Body": {"Text": {"Data": body}},
        },
    )

    return jsonify({"success": True, "message": "OTP sent successfully"}), 200

if __name__ == "__main__":
    app.run(debug=True)
