
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final SharedPreference _singleton = SharedPreference._internal();
  factory SharedPreference() => _singleton;
  SharedPreference._internal();
  static SharedPreference get shared => _singleton;

  void saveUserLocation(String user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('location', user);
  }

  Future<String?> getUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    String? userLocation = prefs.getString('location');
    return userLocation;
  }
}