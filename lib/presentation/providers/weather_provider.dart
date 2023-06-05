import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/data/datasources/weather_remote_data_source.dart';
import 'package:flutter_weather_app/data/repositories/current_weather_repository.dart';
import 'package:flutter_weather_app/domain/repositories/get_current_weather_forecast.dart';
import 'package:flutter_weather_app/presentation/state/weather_state.dart';


final fetchWeatherDataProvider = StateNotifierProvider<WeatherRepositoryNotifier, WeatherState>((ref) {
  return  WeatherRepositoryNotifier(ref: ref, baseWeatherRepository: ref.watch(weatherRepoProvider));
});



final weatherRepoProvider = Provider<BaseWeatherRepository>((ref) {
  return WeatherRepository();
});