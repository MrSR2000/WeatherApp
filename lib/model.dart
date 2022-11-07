/* 
dummy of api response
{
  "coord": {
    "lon": 10.99,
    "lat": 44.34
  },
  "weather": [
    {
      "id": 501,
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
    "temp_min": 297.56,
    "temp_max": 300.05,
    "pressure": 1015,
    "humidity": 64,
    "sea_level": 1015,
    "grnd_level": 933
  },
  "visibility": 10000,
  "wind": {
    "speed": 0.62,
    "deg": 349,
    "gust": 1.18
  },
  "rain": {
    "1h": 3.16
  },
  "clouds": {
    "all": 100
  },
  "dt": 1661870592,
  "sys": {
    "type": 2,
    "id": 2075663,
    "country": "IT",
    "sunrise": 1661834187,
    "sunset": 1661882248
  },
  "timezone": 7200,
  "id": 3163858,
  "name": "Zocca",
  "cod": 200
} 
*/

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];

    return WeatherInfo(description: description, icon: icon);
  }
}

class TempInfo {
  final double temp;

  TempInfo({required this.temp});

  factory TempInfo.fromJson(Map<String, dynamic> json) {
    final temp = json['temp'];
    return TempInfo(temp: temp);
  }
}

class WeatherResponse {
  final String locationName;
  final TempInfo tempinfo;
  final WeatherInfo weatherinfo;

  WeatherResponse(
      {required this.locationName,
      required this.tempinfo,
      required this.weatherinfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final locationName = json['name'];
    final tempinfoJson = json['main'];
    final tempinfo = TempInfo.fromJson(tempinfoJson);
    final weatherinfoJson = json['weather'][0];
    final weatherinfo = WeatherInfo.fromJson(weatherinfoJson);
    return WeatherResponse(
        locationName: locationName,
        tempinfo: tempinfo,
        weatherinfo: weatherinfo);
  }
}
