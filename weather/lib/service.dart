import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Service {
  String baseurl = 'http://api.weatherapi.com/v1';
  String apikey = '420f937a9d6e411a81492101222612';
  Future<Weatherofday?> getweather({required String cityname}) async {
    Weatherofday? day1;
    try {
      Uri url =
          Uri.parse('$baseurl/forecast.json?key=$apikey&q=$cityname&days=3');
      http.Response response = await http.get(url);

      Map<String, dynamic> data = jsonDecode(response.body);

      day1 = Weatherofday.fromjsonday1(data);
      return day1;
    } catch (e) {
      print(e);
    }
  }
}

class  Weatherofday {
  String date;
  String weatherstate;
  double temp;
  double maxtemp;
  double mintemp;

  Weatherofday(
      {required this.date,
      required this.weatherstate,
      required this.temp,
      required this.maxtemp,
      required this.mintemp});

  factory Weatherofday.fromjsonday1(dynamic data) {
    var d1 = data['forecast']['forecastday'][0]['day'];

    return Weatherofday(
        date: data['location']['localtime'],
        weatherstate: d1['condition']['text'],
        temp: d1['avgtemp_c'],
        maxtemp: d1['maxtemp_c'],
        mintemp: d1['mintemp_c']);
  }

  String ImagePath() {
    if (weatherstate == 'Sunny' || weatherstate == 'Clear')
      return "images/clear.png";
    if (weatherstate == 'Partly cloudy' || weatherstate == 'Overcast')
      return "images/cloudy.png";
    else if (weatherstate == 'Rainy' ||
        weatherstate == 'Moderate rain' ||
        weatherstate == 'Patchy rain possible')
      return "images/rainy.png";
    else
      return "images/snow.png";
  }

  MaterialColor ThemeColor() {
    if (weatherstate == 'Sunny' || weatherstate == 'Clear')
      return Colors.orange;
    if (weatherstate == 'Partly cloudy' || weatherstate == 'Overcast')
      return Colors.blueGrey;
    else if (weatherstate == 'Rainy' ||
        weatherstate == 'Moderate rain' ||
        weatherstate == 'Patchy rain possible')
      return Colors.blue;
    else
      return Colors.cyan;
  }
}
