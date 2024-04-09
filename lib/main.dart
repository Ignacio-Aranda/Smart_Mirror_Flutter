import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main () {
  runApp(MyApp());
} 


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Reloj(),
    );
  }
}

class Reloj extends StatefulWidget{
  @override
  _EstadoReloj createState()=> _EstadoReloj();
}

class _EstadoReloj extends State<Reloj>
{
  String _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${(DateTime.now().second)}";
  String cityName = ""; //City from where you want to see the weather
  String apiKey = ""; //API Key from weatherapi.com
  String weatherData = ""; // String where the weather will be written
  

  @override
  void initState(){
    Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime()); // Start a timer to update time every second
    super.initState();
    fetchWeatherData();
  }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            RotatedBox(
              quarterTurns: 1,
            child: Text(_timeString, style: TextStyle(color: Colors.white, fontSize: 80, fontWeight:FontWeight.bold))),
            Spacer(),
            RotatedBox(
              quarterTurns: 1,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '\nCiudad: $cityName',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '\n$weatherData',
              style: TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
            ),
            ),
          ],
        ),
      ),
    );
  }

  void _getCurrentTime()  {
    String segundos = "";
    String minutos = "";
    String horas = "";
    setState(() {
      if(DateTime.now().second<10){
        segundos = "0" + DateTime.now().second.toString();
      }else{
        segundos = DateTime.now().second.toString();
      }
      if(DateTime.now().minute<10){
        minutos = "0" + DateTime.now().minute.toString();
      }else{
        minutos = DateTime.now().minute.toString();
      }
      if(DateTime.now().hour<10){
        horas = "0" + DateTime.now().hour.toString();
      }else{
        horas = DateTime.now().hour.toString();
      }
      _timeString = "${horas} : ${minutos} : ${segundos}";
    });
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$cityName&aqi=no'));
    if (response.statusCode == 200) {
      setState(() {
        // Update weather data
        var jsonWeather = json.decode(response.body);
        var description = jsonWeather['current']['condition']['text'];
        var temp = jsonWeather['current']['temp_c'];
        var humidity = jsonWeather['current']['humidity'];
        weatherData = '$description\n$temp°C\nHumedad: $humidity%';
      });
    } else {
      weatherData = "Failed to load weather data. Did you inicialize apiKey and cityName?";
      throw Exception('Failed to load weather data. Did you inicialize apiKey and cityName?');
    }
  }

}