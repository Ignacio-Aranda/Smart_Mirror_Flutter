## SMART MIRROR USING FLUTTER

This code is a Flutter application that displays the current time, current weather information for a specific city, and the city itself on the screen. Here's a detailed explanation of the code:

### Imports: 
#### flutter/material.dart for Flutter widgets
#### dart:async for working with timers
#### dart:convert for converting JSON data from HTTP responses.

### Classes
#### MyApp class: Defines the main application, which is a StatelessWidget widget. It sets the application theme and sets Reloj() as the home page.
#### Reloj class: This is a StatefulWidget representing the main screen of the application.
#### _EstadoReloj class: This is the state class for the Reloj widget. It contains the logic for fetching the current time and weather data, as well as building the user interface.

### Variables:
#### _timeString: A string representing the current time.
#### cityName: The name of the city for which weather information is desired.
#### apiKey: The API key used to access weather data from weatherapi.com.
#### weatherData: A string to store the retrieved weather data.

### Methods:
#### main() function: Initializes the Flutter application by calling runApp() and passing an instance of MyApp.
#### initState(): This method is automatically called when the widget is inserted into the widget tree. It initializes a timer to update the time every second and calls fetchWeatherData() to get the weather data.
#### build(): Builds the user interface of the application. It displays the time, city, and weather data.
#### _getCurrentTime(): Updates _timeString with the current time. This method is called every second via the timer to keep the displayed time updated.
#### fetchWeatherData(): Makes an HTTP request to fetch the current weather data for the specified city. It updates weatherData with the information obtained from the HTTP response. If the request fails, it displays an error message.
