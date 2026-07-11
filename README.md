# 🛠️ ServiceNear - Service Booking App

## 🌟 Overview
ServiceNear is a user-friendly application that connects **customers** with **service providers** nearby. The app allows customers to search for services, book appointments, chat with service providers, and track locations in real-time, while service providers can efficiently manage requests and availability.

---
📲 Download & Try the App

You can download:

👉 [Download ServiceNear APK](https://www.mediafire.com/file/shkl0alnyxvszue/ServiceNear.apk/file)

presentation:
[You can watch the presentation here](https://www.linkedin.com/posts/mohamed-walid-2a9061241_introducing-servicenear-my-latest-flutter-ugcPost-7440451901097246720-vmMB/?utm_source=share&utm_medium=member_desktop&rcm=ACoAADv8fmEBsSYSkjkP850s7_y_wYhX9Hob__8)


## 📋 Table of Contents
1. [🚀 User Flow](#-user-flow)
2. [✨ Features](#-features)
3. [📱 Screens](#-screens)
4. [🎨 Design Specifications](#-design-specifications)
5. [🔔 Status Indicators](#-status-indicators)

---



<img width="1070" height="878" alt="image" src="https://github.com/user-attachments/assets/8d34f604-76bc-4708-8db0-218aca4186dd" />

## 🚀 User Flow

### 🔐 Authentication Flow
- Users can **sign up** or **login** as:
  - Customer
  - Service Provider
- Role is stored in the database and determines accessible features.

---

### 🗺️ Customer Flow
1. Search for a service (Electrician, Plumber, Mechanic, etc.)
2. View **nearest providers** on map
3. Request a service and select date/time
4. Receive confirmation notification from the provider
5. Chat with provider after request is accepted
6. Track appointment history and status

---

### 🧰 Service Provider Flow
1. Receive **service requests** notifications
2. Accept or reject requests
3. Chat with customers
4. View today’s schedule and appointment history

---

### 💙 Service Provider Features
- 📅 View and manage incoming service requests
- ✅ Accept / 🕒 Pending / ❌ Reject requests
- 🗺️ Share real-time location for customers
- 💬 Chat with customers
- 📝 Manage service offerings and profile

### 👨 Customer Features
- 🔍 Search for services nearby
- 🗓️ Request a service with date/time selection
- 📊 Track request status
- 💬 Chat with service providers
- 👤 Personal profile management

---

## 📱 Screens

### 💙 Customer Screens (Blue Theme)
- 🏠 **Home Screen**
  - Search bar
  - Service categories
  - Nearby service provider cards
- 🗓️ **Service Request**
  - Date/time picker
  - Request confirmation
- 📊 **Request Status**
  - ✅ Accepted → Proceed to chat
  - 🕒 Pending → Waiting for confirmation
  - ❌ Rejected → Option to rebook
- 💬 **Chat Screen**
  - Real-time messaging interface
- 👤 **Profile Screen**
  - Personal info
  - Request history

### 🧰 Service Provider Screens
- 🏠 **Home Screen**
  - Incoming service requests
  - Accept / Reject buttons
- 🗓️ **Schedule Screen**
  - Today’s confirmed appointments
- 💬 **Chat Screen**
  - Messaging with customers
- 👤 **Profile Screen**
  - Services offered
  - Availability toggle (Online / Offline)

---

## 🎨 Design Specifications
- Responsive layout for phones and tablets
- Clean UI with clear status indicators
- Notifications and chat interfaces

---

## 🔔 Status Indicators
- ✅ Accepted → Customer can proceed
- 🕒 Pending → Awaiting confirmation
- ❌ Rejected → Customer can rebook
- 🟢 Online → Service provider available
- 🔴 Offline → Service provider unavailable
