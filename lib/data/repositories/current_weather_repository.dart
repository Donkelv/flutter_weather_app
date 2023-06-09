import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/domain/repositories/get_current_weather_forecast.dart';
import 'package:flutter_weather_app/presentation/state/weather_state.dart';



class WeatherRepositoryNotifier extends StateNotifier<WeatherState> {
  WeatherRepositoryNotifier({
    
    required BaseWeatherRepository baseWeatherRepository,
  })  : _baseWeatherRepository = baseWeatherRepository,
        super(const WeatherInitial());

 
  final BaseWeatherRepository _baseWeatherRepository;

  Future<void> fetchWeatherData() async {
    state = const WeatherState.loading();
    final response = await _baseWeatherRepository.getCurrentWeatherForecast(
        );
    response.fold(
      (l) => state = WeatherState.error(l.message),
      (r) => state = WeatherState.loaded(weather: r),
    );
  }
}
