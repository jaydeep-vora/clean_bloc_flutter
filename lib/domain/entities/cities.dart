
class City {
  String? city;
  String? growthFrom2000To2013;
  double? latitude;
  double? longitude;
  String? population;
  String? rank;
  String? state;

  static City fromJson(Map<String, dynamic> json) {
    var cityObject = City();
    cityObject.city = json['city'];
    cityObject.growthFrom2000To2013 = json['growth_from_2000_to_2013'];
    cityObject.latitude = json['latitude'];
    cityObject.longitude = json['longitude'];
    cityObject.population = json['population'];
    cityObject.rank = json['rank'];
    cityObject.state = json['state'];
    return cityObject;
  }
}