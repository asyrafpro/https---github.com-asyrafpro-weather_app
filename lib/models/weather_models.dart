class Weather {
 final String cityName;
 final double temperature;
 final String mainCondition;

 Weather({required this.cityName,required this.temperature, required this.mainCondition});

 // ignore: empty_constructor_bodies
 factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    cityName: json['name'],
    temperature: (json['main']['temp'] as num).toDouble(),
    mainCondition: json['weather'][0]['main'],
  );
}