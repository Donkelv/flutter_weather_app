import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/core/errors/failure.dart';
import 'package:flutter_weather_app/data/datasources/weather_remote_data_source.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
import 'package:flutter_weather_app/domain/usecases/get_current_weather.dart';
import 'package:mockito/mockito.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {
  @override
  Future<Either<Failure, CurrentForecastWeatherModel>>
      getCurrentWeatherForecast() async {
    // Mock implementation to return a successful result
    final weatherModel = CurrentForecastWeatherModel(
       lat: 37.7749,
      lon: -122.4194,
      timezone: 'America/Los_Angeles',
      timezoneOffset: -25200,
      current: Current(
        dt: 1654197600,
        sunrise: 1654173200,
        sunset: 1654228860,
        temp: 18.5,
        feelsLike: 17.2,
        pressure: 1015,
        humidity: 72,
        dewPoint: 13.4,
        uvi: 5.4,
        clouds: 40,
        visibility: 10000,
        windSpeed: 4.5,
        windDeg: 320,
        windGust: 7.2,
        weather: [
          Weather(
            id: 801,
            main: 'Clouds',
            description: 'Few clouds',
            icon: '02d',
          ),
        ],
      ),
      minutely: null,
      hourly: null,
      daily: null,
      alerts: null,
        );
    return Right(weatherModel);
  }

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
