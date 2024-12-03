// lib/animation/lottie_animations.dart
import 'package:lottie/lottie.dart';

class LottieAnimations {
  // Hava durumu koşuluna göre doğru animasyonu döndüren fonksiyon
  static String getAnimation(String condition) {
    switch (condition) {
      case 'Sunny':
        return 'assets/animations/sunny.json';
      case 'Night':
        return 'assets/animations/night.json';
      case 'Clouds':
        return 'assets/animations/partlycloud.json';
      case 'Rain':
        return 'assets/animations/stormrainy.json';
      case 'Wind':
        return 'assets/animations/windy.json';
      default:
        return 'assets/animations/sunny.json'; // Varsayılan animasyon
    }
  }
}

