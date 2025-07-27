# 🌤️ Weather App

A beautiful, modern weather application built with SwiftUI that provides real-time weather information for cities worldwide with stunning dynamic backgrounds that change based on weather conditions.

![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## ✨ Features

### 🔍 **Smart Search**
- Search for any city worldwide
- Auto-clearing search field for seamless user experience
- Instant feedback with loading animations

### 🎨 **Dynamic Backgrounds**
- Weather-based gradient backgrounds that automatically change based on current conditions:
  - ☀️ **Sunny**: Warm yellow → orange → red gradients
  - ⛅ **Cloudy**: Cool blue → cyan → white transitions
  - 🌧️ **Rainy**: Deep blue → indigo → gray tones
  - ❄️ **Snow**: Pure white → icy blue → cyan gradients
  - ⛈️ **Thunderstorms**: Dramatic black → purple → blue
  - 🌫️ **Fog**: Soft gray → white → blue atmospheric colors

### 📊 **Comprehensive Weather Data**
- **Current Temperature** with "feels like" information
- **Weather Conditions** with descriptive text
- **Detailed Metrics**:
  - Humidity percentage
  - Wind speed and direction
  - Atmospheric pressure
  - Visibility distance
  - Cloud cover percentage
  - UV Index
  - Last update time

### 🎯 **Modern UI/UX**
- **Glassmorphism Design** with ultra-thin material backgrounds
- **Smooth Animations** with spring physics and staggered card animations
- **Haptic Feedback** for interactive elements
- **Loading States** with custom circular progress indicators
- **Error Handling** with user-friendly messages

## 🛠️ Technical Architecture

### **MVVM Pattern**
- **Model**: Clean data structures for weather API responses
- **View**: SwiftUI components with declarative UI
- **ViewModel**: Business logic and state management with `@Published` properties

### **Modern Swift Features**
- **Async/Await** for network operations
- **Combine Framework** for reactive programming
- **Protocol-Oriented Design** for testability
- **Error Handling** with custom error types

## 🎥 Demo Video

### **See the Weather App in Action**

https://github.com/coderaryanjain/Weather-App/raw/main/demo/weather-app-demo.mov

*Watch the smooth animations, dynamic backgrounds, and seamless city search functionality*

### **Key Features Demonstrated:**
- 🔍 **Smart search** with auto-clearing text field
- 🎨 **Dynamic backgrounds** changing based on weather conditions
- ⚡ **Smooth animations** with spring physics
- 📊 **Comprehensive weather data** display
- 🌍 **Global city support** with real-time data

> **Note**: The video demonstrates real-time weather fetching for multiple cities showing how the background gradient automatically adapts to different weather conditions.

## 🚀 Getting Started

### Prerequisites
- **Xcode 14.0+**
- **iOS 15.0+**
- **Swift 5.7+**

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/coderaryanjain/Weather-App.git
   cd weather-app
   ```

2. **Open in Xcode**
   ```bash
   open Weather_App.xcodeproj
   ```

3. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run the app

### API Information
This app uses the **wttr.in** API which provides free weather data without requiring API keys:
- **Endpoint**: `https://wttr.in/{location}?format=j1`
- **No registration required**
- **Global coverage**
- **Real-time data**

## 🏗️ Project Structure

```
Weather_App/
├── Models/
│   └── WeatherModel.swift          # Data structures for API responses
├── Views/
│   ├── WeatherView.swift          # Main weather interface
│   └── ContentView.swift          # App entry point
├── ViewModels/
│   └── WeatherViewModel.swift     # Business logic and state management
├── Services/
│   └── WeatherService.swift       # Network layer for API calls
└── Assets.xcassets/               # App icons and assets
```

## 🧪 Key Components

### **WeatherViewModel**
```swift
class WeatherViewModel: ObservableObject {
    @Published var weather: WttrResponse?
    @Published var isLoading = false
    @Published var searchText = ""
    
    func searchWeather() {
        // Handles search logic with async/await
    }
}
```

### **WeatherService**
```swift
class WeatherService {
    func fetchWeather(for city: String) async throws -> WttrResponse {
        // Simple API call using URLSession
    }
}
```

### **Dynamic Backgrounds**
The app automatically changes background gradients based on weather codes:
- Sunny conditions → Warm gradients
- Rainy weather → Cool blue tones
- Snow → Icy white/blue gradients
- Storms → Dramatic dark colors

## 🎨 Design Principles

- **Minimalist Interface** - Clean, uncluttered design
- **Intuitive Navigation** - Simple search-based interaction
- **Visual Feedback** - Animations and haptic responses
- **Accessibility** - Proper contrast and font sizing
- **Performance** - Optimized for smooth 60fps animations

## 📈 Future Enhancements

- [ ] **7-day Forecast** - Extended weather predictions
- [ ] **Location Services** - Auto-detect current location
- [ ] **Weather Alerts** - Push notifications for severe weather
- [ ] **Multiple Cities** - Save and manage favorite locations
- [ ] **Weather Maps** - Interactive radar and satellite imagery
- [ ] **Widgets** - iOS home screen widgets
- [ ] **Apple Watch** - Companion watchOS app

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Commit your changes** (`git commit -m 'Add amazing feature'`)
4. **Push to the branch** (`git push origin feature/amazing-feature`)
5. **Open a Pull Request**

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **wttr.in** - Free weather API service
- **Apple** - SwiftUI framework and design guidelines
- **SF Symbols** - Beautiful system icons
- **Community** - Open source Swift/SwiftUI resources

---

⭐ **Star this repository if you found it helpful!** ⭐

*Built with ❤️ using SwiftUI*
