import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static Future<List<WeatherModel>> getData(double lat, double lon) async {
    List<WeatherModel> data = [];
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=57fa9e4b78664067f293d97602aa3d74"));

    if (response.statusCode == 200) {
      data.add(weatherModelFromJson(response.body));
    }

    return data;
  }
}
