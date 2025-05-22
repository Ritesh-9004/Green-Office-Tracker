<div align="center">

  <h1>🌱 Green Office Tracker</h1>

 <img src="https://img.shields.io/badge/Status-Complete-brightgreen" alt=" Status">
<img src="https://img.shields.io/badge/Flutter-blue?logo=flutter" alt="Flutter">
<img src="https://img.shields.io/badge/Dart-%2317B8C4.svg?logo=dart&logoColor=white" alt="Dart">
<img src="https://img.shields.io/github/license/Ritesh-9004/Green-Office-Tracker" alt="License">


</div>

## 

### ⚠️ **Note:** This project was submitted as a solution to a hackathon problem statement. It is not a production-ready application.

##
## A mobile application that helps track and reduce carbon emissions in office environments. The app allows users to log their daily activities — such as commute, electricity use (HVAC, lights, computer), and view their total carbon footprint in a visual, engaging way. 🌍

---

## 📱 Features

- 🚶 **Commute Tracker**  
  Log your commute distance and mode of transport to estimate travel-related emissions.

- 🔌 **Electricity Use**  
  Track hours of HVAC, lights, and computer usage to compute power-based emissions.

- 📊 **Real-Time Carbon Footprint**  
  Circular progress visualization showing your daily total emissions as a percentage of a max limit.

- 🔽 **Dropdown Selection for Commute Mode**  
  Easily choose between car, bus, train, flight, etc. to get more accurate results.

- ☁️ **Fetched from remote API**  
  Fetch emission values from a remote API to ensure calculations are up to date.

- 🧠 **Smart UI**  
  Simple and intuitive layout for quick daily logging.

---

## 📦 Tech Stack

- **Flutter** – Cross-platform mobile framework
- **Dart** – Language used for Flutter
- **REST API** – For dynamic emission factor loading (Emission factors are fetched from a remote API to ensure data is always up to date.)
- **percent_indicator** – For circular progress display


---

## 📷 Preview

| ![Home Page](screenshots/Home%20Page.png) | ![Reward Page](screenshots/Reward%20Screen.png) | ![Suggestion Page](screenshots/Suggestion%20Screen.png) | ![Trend Page](screenshots/Trend%20Screen%28Show%20graph%20of%20Carbon%20emission%20of%20User%29.png) |
|:----------------------------------------:|:----------------------------------------------:|:------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------:|
| **HOME PAGE**                             | **REWARD PAGE**                                 | **SUGGESTION PAGE**                                     | **TREND PAGE**                                                                                                           |

---

## 🛠️ Getting Started

Follow these steps to set up and run the Green Office Tracker app on your local machine.

### ✅ Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio or VS Code with Flutter extension
- A physical device or emulator
- Internet connection (for fetching dynamic emission factors)

---

### 🚀 Installation

1. **Clone the repository**

bash
git clone [https://github.com/Ritesh-9004/green-office-tracker.git](https://github.com/Ritesh-9004/Green-Office-Tracker.git)
cd green-office-tracker

2. **Install dependencies**

3. **Enter "flutter pub get" in Terminal**

4. **Add emission factor JSON**
     - Ensure emission_factors.json is placed under the assets folder:
        - _assets/emission_factors.json_


6. **And update pubspec.yaml to include**:
   
    - flutter:
       - assets:
          - android/assets/emission_factors.json
   
7. **Run the App**
   
- To run on an emulator or a connected device, use:
    - flutter run
  
- If you encounter issues, try cleaning and rebuilding:
  - flutter clean
  - flutter pub get
  - flutter run



---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.




