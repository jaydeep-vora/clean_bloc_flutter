
import 'package:clean_bloc/core/constants.dart';
import 'package:clean_bloc/core/utils/utilities.dart';
import 'package:clean_bloc/domain/entities/cities.dart';
import 'package:clean_bloc/domain/entities/weather_details.dart';
import 'package:http/http.dart' as http;

class WeatherDetailsAPI {
  
  Future<WheatherDetails?> getDetails(City city) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + "?lat=${city.latitude}&lon=${city.longitude}&appid=${ApiConstants.weatheAPIKey}");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        printLog(response.body);
        // List<WheatherDetails> _model = userModelFromJson(response.body);
        // return _model;
        return WheatherDetails();
      }
    } catch (e) {
      printLog(e.toString());
    }
    return null;
  }
}