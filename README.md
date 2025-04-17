# 🌱 Green Office Tracker

A mobile application that helps track and reduce carbon emissions in office environments. The app allows users to log their daily activities — such as commute, electricity use (HVAC, lights, computer), and view their total carbon footprint in a visual, engaging way. 🌍

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

- ☁️ **Dynamic Emission Factors**  
  Fetch emission values from a remote API to ensure calculations are up to date.

- 🧠 **Smart UI**  
  Simple and intuitive layout for quick daily logging.

---

## 📦 Tech Stack

- **Flutter** – Cross-platform mobile framework
- **Dart** – Language used for Flutter
- **Firebase** (optional) – Can be integrated for cloud sync or authentication
- **REST API** – For dynamic emission factor loading
- **percent_indicator** – For circular progress display


---

## 📷 Preview

![Home Page](screenshots/Home%20Page.png) **HOME PAGE**  ![Reward Page](screenshots/Reward%20Screen.png) **REWARD PAGE**
![Suggestion Page](screenshots/Suggestion%20Screen.png)  **SUGGESTION PAGE**  ![Trend Page](screenshots/Trend%20Screen(Show%20graph%20of%20Carbon%20emission%20of%20User).png)  **TREND PAGE**

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
git clone [https://github.com/your-username/green-office-tracker.git](https://github.com/Ritesh-9004/Green-Office-Tracker.git)
cd green-office-tracker

2. **Install dependencies**

3. **Enter "flutter pub get" in Terminal**

4. **Add emission factor JSON**
      Ensure emission_factors.json is placed under the assets folder:
         _assets/emission_factors.json_


6. **And update pubspec.yaml to include**:
   
     flutter:
        assets:
          - android/assets/emission_factors.json
   
7. **Run the App**
   
-To run on an emulator or a connected device, use:
    -flutter run
  
-If you encounter issues, try cleaning and rebuilding:
  -flutter clean
  -flutter pub get
  -flutter run

---
🤝 **Contributing**
    Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated!

  **Steps to Contribute**:

1. Fork the repository

2. Create a new branch (git checkout -b feature-name)

3. Make your changes

4. Commit your changes (git commit -m 'Add some feature')

5. Push to the branch (git push origin feature-name)

6. Open a Pull Request

---
## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.




