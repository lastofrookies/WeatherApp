import 'package:flutter/material.dart';
import 'pages/weather_page.dart';

//çağırmaları burada yap

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:WeatherPage(),

    );
  }
}