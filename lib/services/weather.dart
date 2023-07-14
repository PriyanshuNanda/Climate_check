import 'package:climate/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const apiKey='960117323989562ba4f4e779af332c75';
const openWeatherURL='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
  Future<dynamic> getCityLocation(String cityName)async {
    http.Response response = await http.get(Uri.parse(
        '$openWeatherURL?q=$cityName&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      String data = response.body;
      var jData = jsonDecode(data);
      return jData;
    } else {
      throw '${response.statusCode}';
    }
  }
  Future<dynamic> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    http.Response response = await http.get(Uri.parse(
        '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'));
    // print(location.longitude);
    // print(location.latitude);
    if (response.statusCode == 200) {
      String data = response.body;
      var jData = jsonDecode(data);
      return jData;
    } else {
      throw '${response.statusCode}';
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
