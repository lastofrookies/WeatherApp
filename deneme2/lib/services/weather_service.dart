import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;




class WeatherService {
  static const BASE_URL = 'http://api.weatherapi.com/v1';
  final String apiKey;

  WeatherService(this.apiKey);


  Future<Weather> getWeatherByLocation(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/current.json?key=$apiKey&q=$latitude,$longitude'),
    );

    if (response.statusCode == 200) {
      print("API Response: ${response.body}");
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }



  // şehir ismine göre hava
  Future<Weather> getWeatherByCity(String city) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/current.json?key=$apiKey&q=$city'),
    );

    if (response.statusCode == 200) {
      print("API Response: ${response.body}");
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Hata  $city');
    }
  }


  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("konum izni reddedildi");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
