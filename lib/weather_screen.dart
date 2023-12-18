import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/api_key.dart';
import 'package:weatherapp/weather_forecast_card.dart';
import 'addition_info_items.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  IconData mode = Icons.light_mode;
  bool isText = true;
  final cityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  String cityName = "Rajkot";

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=${cityName.substring(0, 1).toUpperCase() + cityName.substring(1, cityName.length)}&APPID=$api_key'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw "City Name Does Not Exist/Error Occurred While Fetching API";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      theme: (mode == Icons.dark_mode)
          ? ThemeData.light(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Weather APP",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (mode == Icons.light_mode) {
                setState(() {
                  mode = Icons.dark_mode;
                });
              } else {
                setState(() {
                  mode = Icons.light_mode;
                });
              }
            },
            icon: Icon(mode),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  cityName = "Bharuch";
                });
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
            future: getCurrentWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              final data = snapshot.data!;
              final currentTemp =
                  (data['list'][0]['main']['temp'] as double?) ?? 0.0;
              final currentCondition =
                  (data['list'][0]['weather'][0]['main'] as String?) ??
                      "Clouds";
              final humidity =
                  (data['list'][0]['main']['humidity'] ?? 0).toString();
              final pressure =
                  (data['list'][0]['main']['pressure'] ?? 0).toString();
              final windSpeed =
                  (data['list'][0]['wind']['speed'] ?? 0.0).toString();
              final temp1 = (data['list'][1]['main']['temp'] as double?) ?? 0.0;
              final temp2 = (data['list'][2]['main']['temp'] as double?) ?? 0.0;
              final temp3 = (data['list'][3]['main']['temp'] as double?) ?? 0.0;
              final temp4 = (data['list'][4]['main']['temp'] as double?) ?? 0.0;
              final temp5 = (data['list'][5]['main']['temp'] as double?) ?? 0.0;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.location_pin,
                            size: 28,
                          ),
                        ),
                        SizedBox(
                          width: 130, // Adjust the width as needed
                          child: TextField(
                            controller: cityNameController,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: cityName.substring(0, 1).toUpperCase() +
                                  cityName.substring(1, cityName.length),
                              focusColor: Color.fromRGBO(0, 0, 0, 100),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cityName = cityNameController.text;
                              cityNameController.text = "";
                            });
                          },
                          icon: Icon(Icons.search),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    "${(currentTemp - 273.15).toStringAsFixed(2)}°C",
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    currentCondition == "Clouds" ||
                                            currentCondition == "Rain"
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 75,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    currentCondition,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Weather Forecast",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Forecastcard(
                              time: "00:00", ic: Icons.cloud, Temp: temp1),
                          Forecastcard(
                              time: "03:00",
                              ic: Icons.cloudy_snowing,
                              Temp: temp2),
                          Forecastcard(
                              time: "06:00",
                              ic: Icons.sunny_snowing,
                              Temp: temp3),
                          Forecastcard(
                              time: "09:00", ic: Icons.sunny, Temp: temp4),
                          Forecastcard(
                              time: "12:00", ic: Icons.cloud, Temp: temp5),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoItems(
                          i: Icons.water_drop,
                          t1: 'Humidity',
                          t2: humidity+"%",
                        ),
                        AdditionalInfoItems(
                          i: Icons.air,
                          t1: "Wind Speed",
                          t2: windSpeed+" mi/h",
                        ),
                        AdditionalInfoItems(
                          i: Icons.beach_access,
                          t1: "Pressure",
                          t2: pressure+" hPa",
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access; // Replace with appropriate rain icon
      // Add more cases for other weather conditions
      default:
        return Icons.cloud;
    }
  }
}
