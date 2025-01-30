import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather_services.dart';
import '../models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherServices('5232974aa06d2666aa615f9baaac9ce5');
  Weather? _weather;
  bool _isLoading = true;
  String _currentTime = "";
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _updateTime();
  }

  _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateTime() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateFormat('EEEE, dd MMMM yyyy - HH:mm:ss').format(DateTime.now());
      });
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'weather_assets/sunny.json';
    
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'weather_assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'weather_assets/rain.json';
      case 'thunderstorm':
        return 'weather_assets/thunder.json';
      case 'clear':
        return 'weather_assets/sunny.json';
      default:
        return 'weather_assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: _isDarkMode ? Colors.black : null,
          gradient: _isDarkMode
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade900, Colors.blue.shade400],
                ),
        ),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _currentTime,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  _weather?.cityName ?? "Unknown City",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Lottie.asset(
                                  getWeatherAnimation(_weather?.mainCondition),
                                  width: 200,
                                  height: 200,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '${_weather?.temperature.round()}°C',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _weather?.mainCondition ?? "",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: IconButton(
                        icon: Icon(
                          _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                          color: Colors.white,
                        ),
                        onPressed: _toggleTheme,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchWeather,
        child: Icon(Icons.refresh, color: Colors.white),
        backgroundColor: _isDarkMode ? Colors.black : Colors.blue.shade700,
      ),
    );
  }
}