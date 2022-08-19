import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_final/weather_service.dart';

import 'weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();

  String currentWeather = "";
  double tempC = 0;
  double tempF = 0;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    weather = await weatherService.getWeatherData("Canada");

    setState(() {
      currentWeather = weather.condition;
      tempF = weather.temperatureF;
      tempC = weather.temperatureC;
    });
    print(weather.temperatureC);
    print(weather.temperatureF);
    print(weather.condition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentWeather),
            Text(tempC.toString()),
            Text(tempF.toString()),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather app'),
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signed In as',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                user.email!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.arrow_back_ios_new, size: 32),
                label: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
              )
            ],
          ),
        ));
  }
}
