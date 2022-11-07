import 'dart:ffi';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForLocationValue;
  }

  checkForLocationValue() async {
    String location = await getLocationValue() ?? 'kathmandu';

    setState(() {
      _locationTextController.text = location;
    });
  }

  WeatherResponse? _response;

  getLocationValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String location = pref.getString('locationValue')!;
    return location;
  }

  setLocationValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('locationValue', _locationTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                width: 150,
                child: TextField(
                  controller: _locationTextController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _search,
              child: const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
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
    });
  }
}
