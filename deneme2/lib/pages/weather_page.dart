import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'package:geolocator/geolocator.dart';
import '../pages/search_screen.dart'; // Yeni oluşturulan ekranı dahil ediyoruz.

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}


//apikey
class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('468ce14648cd41d983582816241111');
  Weather? _weather;

  _fetchWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final weather = await _weatherService.getWeatherByLocation(
          position.latitude, position.longitude);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error: $e");
    }
  }



  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

//arka plan resimleri
  String _getBackgroundImage(String condition) {
    switch (condition) {
      case 'Sunny':
        return 'assets/images/sunny.jpeg';
      case 'Night':
        return 'assets/images/night.jpeg';
      case 'Clouds':
        return 'assets/images/partycloud.jpeg';
      case 'Rain':
        return 'assets/images/rainy.jpeg';
      case 'Wind':
        return 'assets/images/windy.jpeg';
      default:
        return 'assets/images/sunny.jpeg';
    }
  }
//en üstteki app var
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //nitelikleri

        backgroundColor: Colors.blueGrey,
        //decoration gelmiyorr
        title: const Text('Hava Durumu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final searchedCity = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
              if (searchedCity != null) {
                _fetchWeatherByCity(searchedCity);
              }
            },
          ),
        ],
      ),
      body: _weather != null
          ? Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                _getBackgroundImage(_weather!.mainCondition)),
            fit: BoxFit.cover,
          ),
        ),                                                                   //bu yorum satırları ne işe yarıyor?

        child: Center(
          child: Container(
            //xml kısım
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(15),
            ),



            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _weather!.cityName,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 1),
                Text(
                  "${_weather!.temperature}°C",
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 5),
                Text(
                  _weather!.mainCondition,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),


                const SizedBox(height: 10),
                Text(
                  "Humidity: ${_weather!.humidity}% | Wind Speed: ${_weather!.windSpeed} kph",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }





  _fetchWeatherByCity(String city) async {
    try {
      final weather = await _weatherService.getWeatherByCity(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}
