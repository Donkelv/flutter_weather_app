

import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failure.dart';
import 'package:flutter_weather_app/data/repositories/current_weather_repository.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
import 'package:flutter_weather_app/domain/repositories/get_current_weather_forecast.dart';
import 'package:flutter_weather_app/presentation/state/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockWeatherRepository extends Mock implements BaseWeatherRepository {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late ProviderContainer container;
  late WeatherRepositoryNotifier weatherRepositoryNotifier;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    container = ProviderContainer();
    weatherRepositoryNotifier = WeatherRepositoryNotifier(
      baseWeatherRepository: mockWeatherRepository,
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('WeatherRepositoryNotifier', () {
    test(
        'should update state to loaded when weather data is fetched successfully',
        () async {
      // Arrange
      final mockWeather =
          CurrentForecastWeatherModel(/* Initialize with desired values */);
      when(() => mockWeatherRepository.getCurrentWeatherForecast())
          .thenAnswer((_) async => Right(mockWeather));

      // Act
      await weatherRepositoryNotifier.fetchWeatherData();

      // Assert
      expect(weatherRepositoryNotifier.state, isA<WeatherLoaded>());
      expect((weatherRepositoryNotifier.state as WeatherLoaded).weather,
          mockWeather);
    });

    test('should update state to error when weather data fetch fails',
        () async {
      // Arrange
      final failureMessage = 'Failed to fetch weather data';
      when(() => mockWeatherRepository.getCurrentWeatherForecast())
          .thenAnswer((_) async => Left(Failure(message: failureMessage)));

      // Act
      await weatherRepositoryNotifier.fetchWeatherData();

      // Assert
      expect(weatherRepositoryNotifier.state, isA<WeatherError>());
      expect((weatherRepositoryNotifier.state as WeatherError).message,
          failureMessage);
    });
  });
}
