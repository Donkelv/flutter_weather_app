///[To Do] Implement http calls to the weather repository
///
///
///
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
import 'package:flutter_weather_app/core/errors/failure.dart';
import 'package:flutter_weather_app/domain/repositories/get_current_weather_forecast.dart';
import 'package:flutter_weather_app/utils/api_const.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepository implements BaseWeatherRepository {
  @override
  Future<Either<Failure, CurrentForecastWeatherModel>>
      getCurrentWeatherForecast() async {
    final Position position = await _getCurrentLocation();
    String url =
        "$baseUrl?lat=${position.latitude}&lon=${position.longitude}&units=metric&exclude=minutely,hourly&appid=$apiKey";
    debugPrint(url);
    try {
      final response = await dio.Dio().get(url);
      if (kDebugMode) {
        print(response);
      }

      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
        Map<String, dynamic> content = response.data;
        if (kDebugMode) {
          print(content);
        }
        CurrentForecastWeatherModel weatherModel =
            CurrentForecastWeatherModel.fromJson(content);
        return Right(weatherModel);
      } else {
        return Left(Failure(
            message: "Failed to fetch weather data, please try again later"));
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return Left(
          Failure(message: "An error occurred, please try again later"));
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Failure(message: 'Location services are disabled');
    }

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw Failure(message: 'Location permissions are permanently denied');
    }

    if (permission == LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Failure(message: 'Location permissions are denied');
      }
    }
    final position = await geolocator.Geolocator.getCurrentPosition();
    return position;
  }
}

