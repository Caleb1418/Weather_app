import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_final/weather.dart';

class WeatherService {
  Future<Weather> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'Key': '1e362cf3a17508d383682b7b7cd44f8c',
        'q': place,
      };
      final uri =
          Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Cant get weather");
      }
    } catch (e) {
      rethrow;
    }
  }
}
