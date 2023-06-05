# Flutter Weather App

Flutter Weather App is a mobile application that displays the current weather conditions and a 8-day forecast for a user's location. It utilizes an API to fetch weather data and presents it in a visually appealing and user-friendly manner.

## Features

- Display the current temperature, weather description, and an icon representing the weather condition.
- Implement location detection to automatically fetch weather data for the user's current location.
- Display a 8-day forecast with temperature highs and lows for each day.
- Implement pull-to-refresh functionality to update the weather data.
- Handle errors gracefully and display appropriate error messages if the API request fails or location permission is denied.
- Implement unit tests to ensure the accuracy of the weather data parsing and other critical functions.
- Utilize appropriate state management techniques Riverpod to manage the app's state effectively.
- Create a visually appealing UI design that follows Flutter's design guidelines and provides a seamless user experience.
- Optimize app performance and ensure smooth scrolling and transitions between screens.
- Implement proper error handling and use appropriate loading indicators during data fetching.
- Bonus Points (Optional):
  - Implement dark mode functionality to switch between light and dark themes.
  - Integrate an animation library (e.g., Rive, Flare) to add visually appealing animations to the UI.



## Getting Started 🚀

This project contains 2 flavors:

- development
- production


To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run -t lib/main_dev.dart 

# Production
$ flutter run -t lib/main_prod.dart 

```


## Folder Structure

The folder structure of the Flutter Weather App project is organized as follows:

- lib
  - core
    - errors
      - failure.dart: Defines the Failure class for representing errors and failures.
  - data
    - datasources
      - weather_remote_data_source.dart: Implements the remote data source for fetching weather data from the API.
    - repositories
      - current_weather_repository.dart: Implements the repository for fetching the current weather forecast.
  - domain
    - entities
      - current_forecast_weather_model.dart: Defines the entity class for the current weather forecast.
    - repositories
      - get_current_weather_forecast.dart: Defines the repository interface for fetching the current weather forecast.
    - usecases
      - get_current_weather.dart: Implements the use case for getting the current weather forecast.
  - presentation
    - pages
      - weather_page.dart: Implements the main WeatherPage widget for displaying the weather information.
    - state
      - weather_state.freezed.dart: Defines the freezed union classes for the different states of the weather page.
    - providers
      - weather_provider.dart: Implements the Riverpod state provider for managing the weather state.
  - utils
    - constants.dart: Contains the constant values used in the app.
  - main.dart: The entry point of the Flutter Weather App.



## Testing

The Flutter Weather App includes unit tests for critical functions and logic. To run the tests, follow these steps:

1. Open the terminal in your Flutter IDE.

2. Run `flutter test` command to execute all the unit tests.

## Contributing

Contributions are welcome! If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.
