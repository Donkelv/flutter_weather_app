import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
import 'package:flutter_weather_app/presentation/providers/weather_provider.dart';
import 'package:flutter_weather_app/presentation/state/weather_state.dart';

class WeatherDataWidget extends ConsumerWidget {
  const WeatherDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CurrentForecastWeatherModel? weatherData = ref.watch(fetchWeatherDataProvider).data;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
      ],
    );
  }
}
