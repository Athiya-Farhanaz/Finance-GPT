# Finance GPT

## Overview

Finance GPT is an AI-powered financial document intelligence platform that enables users to securely upload, analyze, and process financial documents. The application combines a Flutter-based mobile frontend with AI-powered backend services to perform document classification, summarization, question answering, and Personally Identifiable Information (PII) detection while preserving user privacy.

The system is designed as a client-server architecture where the Flutter application handles user interaction, authentication, document upload, and result visualization, while AI models deployed through Flask/FastAPI APIs perform financial document analysis.

---

# Project Objectives

The primary objectives of Finance GPT are:

* Automate financial document understanding.
* Protect sensitive financial information using AI-based PII masking.
* Enable intelligent question answering over financial documents.
* Generate concise summaries of lengthy financial reports.
* Classify financial documents into predefined categories.
* Ensure privacy-preserving machine learning using Federated Learning.
* Provide a secure and scalable cloud-based AI platform.

---

# Key Features

## User Authentication

* Email & Password Authentication
* Google Sign-In
* Firebase Authentication
* OTP Verification using Twilio

---

## Financial Document Processing

* Upload PDF documents
* Upload cheque images
* Upload financial statements
* Image selection from Camera or Gallery

---

## AI Services

* Financial Document Classification
* Financial Document Summarization
* Financial Question Answering
* PII Detection
* Cheque Image Processing

---

## Security

* Personally Identifiable Information (PII) masking
* Secure authentication
* Privacy-preserving Federated Learning
* Cloud-based API communication

---

## Document Management

* View processed documents
* Download processed reports
* Share generated documents

---

# Technology Stack

## Frontend

* Flutter
* Dart

## Backend

* Flask / FastAPI
* REST APIs

## AI & Machine Learning

* RoBERTa
* Vision Transformer (ViT)
* Federated Learning

## Authentication

* Firebase Authentication
* Google Sign-In
* Twilio OTP

## Database

* Cloud Firestore

## Cloud

* AWS

---

# System Architecture

Finance GPT follows a three-layer architecture.

### Presentation Layer

The Flutter application provides an intuitive interface where users authenticate, upload financial documents, and view AI-generated outputs.

### Application Layer

Flask/FastAPI REST APIs receive uploaded documents, validate requests, invoke AI models, and return processed results to the mobile application.

### Intelligence Layer

The AI layer performs document understanding using RoBERTa and Vision Transformer models for classification, summarization, question answering, and PII detection.

---

# Application Workflow

1. User launches the Flutter application.
2. Firebase initializes authentication services.
3. User signs in using Email/Password or Google Sign-In.
4. OTP verification is performed through Twilio if required.
5. User accesses the dashboard.
6. Financial documents or cheque images are uploaded.
7. The Flutter application sends the document to backend REST APIs.
8. Backend AI services process the document.
9. AI models generate predictions or processed outputs.
10. Results are returned to the Flutter application.
11. Users can view, download, or share the processed document.

---

# AI Pipeline

The backend AI pipeline consists of the following modules:

## Financial Document Classification

Documents are categorized into predefined financial document types using Vision Transformer (ViT) and Natural Language Processing techniques.

---

## Document Summarization

RoBERTa-based language models generate concise summaries of lengthy financial reports, enabling users to quickly understand important information.

---

## Financial Question Answering

Users can ask questions related to uploaded financial documents. The backend extracts relevant information and returns context-aware answers.

---

## PII Detection

Sensitive information such as:

* Account Numbers
* IFSC Codes
* PAN Numbers
* Aadhaar Numbers
* Phone Numbers
* Email Addresses
* Customer Names

is automatically detected and masked before further processing.

---

## Cheque Image Processing

Cheque images are analyzed to identify important financial fields while ensuring sensitive information is protected.

---

## Federated Learning

Instead of transferring sensitive user data to a central server, model updates are aggregated from multiple clients. This approach improves model performance while preserving user privacy.

---

# Frontend Responsibilities

The Flutter application is responsible for:

* User authentication
* OTP verification
* Document upload
* Image selection
* API communication
* Displaying AI results
* Downloading processed files
* Sharing processed documents
* Permission management

---

# Backend Responsibilities

The backend services are responsible for:

* REST API endpoints
* AI model inference
* Document preprocessing
* PII detection
* Document summarization
* Question answering
* Classification
* Response generation
* AWS deployment

---

# Dependencies

Major Flutter packages include:

* firebase_core
* firebase_auth
* cloud_firestore
* google_sign_in
* twilio_flutter
* http
* image_picker
* file_picker
* path_provider
* open_file
* share_plus
* permission_handler
* flutter_dotenv

---

# Security Features

* Firebase Authentication
* OTP Verification
* Secure REST API communication
* PII masking
* Privacy-preserving Federated Learning



