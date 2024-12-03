// lib/animation/lottie_animations.dart
import 'package:lottie/lottie.dart';

class LottieAnimations {
  static String getAnimation(String condition) {
    switch (condition) {
      case 'sunny':
        return 'assets/animations/sunny.json';
      case 'storm':
        return 'assets/animations/storm.json';
      case 'rainy':
        return 'assets/animations/rainy.json';
      case 'windy':
        return 'assets/animations/windy.json';
      case 'partlyCloud':
        return 'assets/animations/partycloud.json';
      case 'night':
        return 'assets/animations/night.json';
      default:
        return 'assets/animations/sunny.json'; // Varsayılan animasyon
    }
  }
}
