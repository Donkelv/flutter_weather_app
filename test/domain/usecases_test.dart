import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/core/errors/failure.dart';
import 'package:flutter_weather_app/data/datasources/weather_remote_data_source.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
import 'package:flutter_weather_app/domain/usecases/get_current_weather.dart';
import 'package:mockito/mockito.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {
  
}

void main() {
  late GetCurrentWeather useCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = GetCurrentWeather(mockWeatherRepository);
  });

  group('GetCurrentWeather', () {
    final currentWeather = CurrentForecastWeatherModel(
      lat: 33.44,
      lon: -94.04,
      timezone: "America/Chicago",
      timezoneOffset: -18000,
      current: Current(),
      minutely: <Minutely>[],
      hourly: <Hourly>[],
      daily: <Daily>[],
      alerts: <Alerts>[],
    );

    test('should return current weather from the repository', () async {
      when(mockWeatherRepository.getCurrentWeatherForecast())
          .thenAnswer((_) async => Right(currentWeather));

      final result = await useCase();

      expect(result, Right(currentWeather));
      verify(mockWeatherRepository.getCurrentWeatherForecast()).called(1);
      verifyNoMoreInteractions(mockWeatherRepository);
    });

    test('should return a failure when repository call fails', () async {
      final failure = Failure(message: 'Failed to get current weather');
      when(mockWeatherRepository.getCurrentWeatherForecast())
          .thenAnswer((_) async => Left(failure));

      final result = await useCase();

      expect(result, Left(failure));
      verify(mockWeatherRepository.getCurrentWeatherForecast()).called(1);
      verifyNoMoreInteractions(mockWeatherRepository);
    });
  });
}
