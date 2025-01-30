# Weather App by (MUHAMMAD AMIRUL ASYRAF BIN MOHD KAMAL 2115565)

## Overview
This Weather App is a Flutter application that provides real-time weather information based on the user's current location. It fetches weather data from the **OpenWeather API** and displays it with a visually appealing UI. The app also includes additional features such as a **dark/light mode toggle**, **animated weather illustrations** using Lottie, and an **automatic time display update**.

---

## Features

### 🌍 **Real-Time Weather Updates**
- Fetches weather data based on the user's **current location**.
- Uses **OpenWeather API** to retrieve **temperature, city name, and weather conditions**.

### 🎨 **Dark/Light Mode Toggle**
- Allows users to switch between **dark mode** and **light mode**.
- Uses a button with sun/moon icons to toggle the theme.

### 🕰 **Live Time Updates**
- Displays the **current time and date**.
- Automatically updates every **second** using a **Timer**.

### 🎥 **Lottie Weather Animations**
- Uses **Lottie animations** to visually represent different weather conditions:
  - ☀️ **Sunny** → `sunny.json`
  - ☁️ **Cloudy, Mist, Fog, Haze** → `cloud.json`
  - 🌧 **Rain, Drizzle, Shower Rain** → `rain.json`
  - ⛈ **Thunderstorm** → `thunder.json`

### 🔄 **Refresh Button**
- Allows users to manually **refresh** the weather data by pressing a **floating action button**.

---

## App Flow

### 1️⃣ **Startup & Initialization**
- The app starts in `main.dart`, which loads `WeatherPage` as the **home screen**.
- `WeatherPage` initializes necessary services and starts fetching weather data.

### 2️⃣ **Fetching User Location**
- The `WeatherServices` class retrieves the **current location** using the **Geolocator package**.
- Reverse geocoding is performed using the **geocoding package** to determine the **city name**.

### 3️⃣ **Retrieving Weather Data**
- `WeatherServices.getWeather(cityName)` sends a **GET request** to OpenWeather API.
- The response JSON is parsed into a **Weather model**, extracting:
  - `cityName`: Name of the city.
  - `temperature`: Temperature in Celsius.
  - `mainCondition`: Main weather condition (e.g., 'Clear', 'Clouds').

### 4️⃣ **Updating UI**
- The **Lottie animation** updates based on `mainCondition`.
- The **temperature** and **city name** are displayed.
- The **dark/light mode toggle** updates the background accordingly.

### 5️⃣ **Live Time Update**
- The `_updateTime` function updates the displayed time **every second**.
- Uses **Intl package** to format the date and time.

### 6️⃣ **Theme Switching**
- Clicking the **sun/moon icon** toggles between **dark mode** and **light mode**.
- The UI **background color and gradient** change based on the selected theme.

### 7️⃣ **Refreshing Weather Data**
- Clicking the **refresh button** triggers `_fetchWeather` to reload data.
- Displays a **loading indicator** while fetching new weather data.

---

## Project Structure
```
📂 weather_app
 ├── 📂 lib
 │   ├── 📂 models
 │   │   ├── weather_models.dart  # Defines Weather model
 │   ├── 📂 pages
 │   │   ├── weather_page.dart    # Main weather display UI
 │   ├── 📂 services
 │   │   ├── weather_services.dart  # API calls & location retrieval
 │   ├── main.dart                 # Entry point of the app
 ├── 
 │  📂 weather_assets
 │   │   ├── sunny.json
 │   │   ├── cloud.json
 │   │   ├── rain.json
 │   │   ├── thunder.json
 ├── pubspec.yaml  # Dependencies and assets
```

---

## Dependencies
Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.4
  geolocator: ^9.0.2
  geocoding: ^2.0.5
  intl: ^0.18.0
  lottie: ^2.0.0
```

---

## API Configuration
To use the **OpenWeather API**, add your API key in `weather_services.dart`:

```dart
final _weatherService = WeatherServices('YOUR_API_KEY');
```
Replace `'YOUR_API_KEY'` with your actual OpenWeather API key.

---

## Screenshots
### 🌞 **Light Mode**
![weather_screen](https://github.com/user-attachments/assets/82820159-cf18-4c49-8eda-cbd84804d98d)



### 🌙 **Dark Mode**
![dark_mode](https://github.com/user-attachments/assets/a77f7dc8-5ba6-4cc0-9b19-354956c7656c)


---

## Conclusion
This Weather App is a simple yet effective demonstration of **Flutter's UI capabilities**, **state management**, and **API integration**. Features like **real-time weather updates**, **animations**, and **dark mode** make it a polished and user-friendly experience.

Happy Coding! 🚀
