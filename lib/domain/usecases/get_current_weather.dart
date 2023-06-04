import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failure.dart';
import 'package:flutter_weather_app/data/datasources/weather_remote_data_source.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';

class GetCurrentWeather {
  final WeatherRepository weatherRepository;

  GetCurrentWeather(this.weatherRepository);

  Future<Either<Failure, CurrentForecastWeatherModel>> call() async {
    try {
      return await weatherRepository.getCurrentWeatherForecast();
    } catch (e) {
      throw Failure(message: 'Failed to get current weather');
    }
  }
}
