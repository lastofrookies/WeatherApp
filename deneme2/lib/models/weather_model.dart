class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
  });

  //ad sıcaklık nem rüzgar
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'],
      mainCondition: json['current']['condition']['text'],
      humidity: json['current']['humidity'],
      windSpeed: json['current']['wind_kph'],
    );
  }
}
