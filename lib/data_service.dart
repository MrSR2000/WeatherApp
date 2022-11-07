import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': '98e8dfcf4ea2319b693eb4c58b2a6018',
      'units': 'metric',
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    //print(response.body);
    final json = jsonDecode(response.body);
    print(json);
    return WeatherResponse.fromJson(json);
  }
}
