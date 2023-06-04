///[To Do] Implement freezed weather state
///

import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_state.freezed.dart';

extension WeatherStateGetters on WeatherState {
  bool get isLoading => this is WeatherLoading;
  bool get isError => this is WeatherError;
  bool get isLoaded => this is WeatherLoaded;
  CurrentForecastWeatherModel? get data => (this as WeatherLoaded).weather;
}

@freezed
abstract class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = WeatherInitial;
  const factory WeatherState.loading() = WeatherLoading;
  const factory WeatherState.loaded({CurrentForecastWeatherModel? weather}) =
      WeatherLoaded;
  const factory WeatherState.error(String message) = WeatherError;
}
