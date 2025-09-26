# 🚦 Flash Pass

**Flash Pass** is an emergency traffic management app built with **Flutter**.  
It helps ambulances, police vehicles, and other emergency responders automatically request nearby traffic signals to turn green, ensuring faster response times during emergencies.

---

## ✨ Features

- 🔑 **Authentication**

  - Sign In / Sign Up (step-based signup flow)
  - Forgot & Reset Password

- 🚑 **Emergency Request System**

  - Request to open the nearest traffic light through the map
  - Supports ambulance and police emergency scenarios
  - Real-time signal control for faster clearance

- 🗺 **Traffic Light Control**

  - Detects upcoming signals via map
  - Automatically sends request if an emergency is declared

- 📊 **User Dashboard**

  - Permit management
  - Request history
  - User details screen

- 🎨 **UI/UX**
  - Splash screen & onboarding pages
  - Support & help section
  - Success confirmation screens

---

## 📂 Project Structure

lib/
│-- accountsSc.dart # User account screen
│-- customtabs.dart # Custom navigation tabs
│-- dashSc.dart # Dashboard
│-- deptType.dart # Department type selector
│-- forgetPass.dart # Forgot password
│-- getPermitScreen.dart # Permit request
│-- historySc.dart # Request history
│-- homeSc.dart # Home screen
│-- loginOrSignUp.dart # Login or sign up choice
│-- loginSc.dart # Login screen
│-- main.dart # App entry point
│-- openTrLight.dart # Open traffic light request
│-- reqRecSc.dart # Request received confirmation
│-- resetPass2.dart # Reset password step 2
│-- resetPassSc.dart # Reset password
│-- scheduleSc.dart # Schedule request
│-- signUpSc1-5.dart # Step-based sign up screens
│-- splash.dart # Splash screen
│-- succRegistered.dart # Registration success
│-- supportSc.dart # Support/help
│-- trafficLightCont.dart # Traffic light control logic
│-- userDetailsSc.dart # User details
│-- vpage1.dart # Onboarding page 1
│-- vpage2.dart # Onboarding page 2
│-- vpage3.dart # Onboarding page 3
│-- vpage4.dart # Onboarding page 4

---

## 📱 App Screenshots

### 🚦main_screen

<img src="screenshots/flash_pass/main_screen.png" width="300"/>

### 🚦empolyer_sign_up_login.png

<img src="screenshots/flash_pass/empolyer_sign_up_login.png" width="300"/>

### 🚦employe_id

<img src="screenshots/flash_pass/employe_id.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/set_password.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/login.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/employe_add_details.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/employe_dashboard.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/emergency.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/visitor_detail.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/employe_phone_number.png" width="300"/>
### 🚦

<img src="screenshots/flash_pass/location.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/map.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/send _request.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/request.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/coming_alert.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/traffic_light.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/support.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/history.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/profile_setting-screen.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/empoly_detail.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/employe_shift.png" width="300"/>

### 🚦

<img src="screenshots/flash_pass/feedback.png" width="300"/>

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart >= 3.x
- Android Studio / VS Code with Flutter plugin
- Firebase or REST API for authentication & traffic signal control

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/flash-pass.git
   cd flash-pass
   ```
