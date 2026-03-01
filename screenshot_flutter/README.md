# 🛡️ Secure ScreenShot Flutter

A production-grade, highly secure OTP Authentication system built with **Clean Architecture**, **Cubit State Management**, and **Fintech-Standard UI/UX**.

![Flutter Version](https://img.shields.io/badge/Flutter-3.11+-02569B?logo=flutter&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean--Layered-2ECC71)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

---

## 🚀 Key Features

### 💎 Premium Fintech UI

- **Modern Design Language**: Use of glassmorphism vibes, smooth gradients (Linear + Secondary glow), and Manrope/Urbanist typography via Google Fonts.
- **Dynamic Feedback**: Real-time attempt indicators (Warnings -> Error banners) based on user behavior.
- **Animated Transitions**: Smooth view switching between Phone & OTP inputs using `AnimatedSwitcher` and `FadeTransition`.

### 🛡️ Advanced Security Audit

This app implements a "First-of-its-kind" security audit flow for failed logins:

- **Mock OTP**: Fixed at `123456` for demo purposes.
- **Progressive Warnings**:
  - **Attempt 1 & 2**: Shows warning banners explaining counts.
  - **Attempt 3 (Lockout)**: Triggered automatically upon the 3rd incorrect submission.
- **Evidence Capture**:
  - **Silent Screenshot**: Captures the current state of the login form using `screenshot`.
  - **Gallery Storage**: Pushes the evidence directly to the device's **Public Gallery** (using `gal` package).
  - **Location Tracking**: Fetches GPS coordinates at the exact moment of failure.
- **Account Lock**: Provides a "Security Evidence Preview" within a custom Bottom Sheet on lockout.

---

## 🏗️ Architecture (SOLID Principles)

The project follows absolute **Clean Architecture** patterns to ensure scalability and testability:

```text
lib/
├── core/                   # Shared Infrastructure
│   ├── di/                 # Dependency Injection (GetIt)
│   ├── theme/              # Design System (Colors, Typography, Shadow, Sizing)
│   ├── widgets/            # Reusable Themed Components (AppButton, CustomField, OtpField)
│   └── error/              # Standardized Failure Handling
└── features/
    └── auth/               # Authentication Feature
        ├── data/           # Repository Impl & DataSources (Mock Logic)
        ├── domain/         # Entities, Repositories, UseCases (Logic contracts)
        └── presentation/   # Cubit (Business Logic) & Pages (UI)
```

---

## 🛠️ Technology Stack

- **State Management**: `flutter_bloc` (Cubit) for clean, predictable state flows.
- **Dependency Injection**: `get_it` (Service Locator pattern).
- **Network/Storage**:
  - `screenshot`: To capture visual evidence.
  - `gal`: To push images to the native Android/iOS gallery.
  - `geolocator`: High-precision location fetching.
  - `path_provider`: Managing temporary files.
- **Styling**: `google_fonts`, custom `manrope` theme integration.

---

## 🚦 Getting Started

### Prerequisites

- Flutter SDK `^3.11.0`
- Android/iOS Device or Emulator (Physical device recommended for Location/Screenshot testing).

### Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/Rudragup/ScreenShot_flutter.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### 🗝️ Demo Credentials

- **Mobile**: Enter any 10-digit number.
- **Success OTP**: `123456`
- **Security Trigger**: Enter any wrong OTP **3 times** to see the lockout logic and gallery screenshot.

---

## 📜 Permissions

The app requests the following to function correctly:

- `Location`: To log audit trails on breach.
- `Storage/Gallery`: To save visual evidence of the unauthorized attempt.

---

## 👨‍💻 Author

**Harshit Saini**  
_Flutter Engineer_ 🚀
