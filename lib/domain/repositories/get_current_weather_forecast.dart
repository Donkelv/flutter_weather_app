import 'package:flutter_weather_app/core/errors/failure.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';

abstract class BaseWeatherRepository {
  Future<Either<Failure, CurrentForecastWeatherModel>> getCurrentWeatherForecast();
}
