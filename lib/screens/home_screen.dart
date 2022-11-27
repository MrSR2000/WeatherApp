import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app/data_service.dart';
import '../model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home-screen';

  final String title = 'Weather App';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _locationTextController = TextEditingController();
  final _dataService = DataService();
  String? _locationValue;
  SharedPreferences? prefs;
  bool _savedLocation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForLocationValue();
  }

  checkForLocationValue() async {
    prefs = await SharedPreferences.getInstance();
    print('the location value is "${_locationValue}" guu');

    if (_locationValue == null || _locationValue == '') {
      _savedLocation = false;
    } else {
      _savedLocation = true;
    }
    setState(() {
      _locationValue = prefs!.getString('locationValue');
    });
  }

  WeatherResponse? _response;

  setLocationValue() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('locationValue', _locationTextController.text);
    // print(pref.getString('locationValue'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: [
                  Text(
                    '${_response?.tempinfo.temp}°c',
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    '${_response?.weatherinfo.description}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            _savedLocation
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(_locationTextController.text))
                : SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _locationTextController,
                      decoration: const InputDecoration(labelText: 'Location'),
                      textAlign: TextAlign.center,
                    ),
                  ),
            const SizedBox(height: 15),
            _savedLocation
                ? ElevatedButton(
                    onPressed: updateLocation,
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: _search,
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void _search() async {
    setLocationValue();
    final response =
        await _dataService.getWeather(_locationTextController.text);
    setState(() {
      _response = response;
      _savedLocation = true;
    });
  }

  void updateLocation() {
    setState(() {
      _savedLocation = false;
    });
  }
}
