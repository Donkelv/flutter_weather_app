import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/presentation/providers/weather_provider.dart';
import 'package:flutter_weather_app/presentation/widgets/data_widget.dart';
import 'package:flutter_weather_app/utils/image_const.dart';
import 'package:rive/rive.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.watch(fetchWeatherDataProvider.notifier).fetchWeatherData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(fetchWeatherDataProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: weatherState.when(
          initial: () => RiveAnimation.asset(ImageConst.riveLoaderAnimation),
          loading: () => Center(
              child: RiveAnimation.asset(ImageConst.riveLoaderAnimation)),
          loaded: (loaded) => const WeatherDataWidget(),
          error: (error) => ErrorWidget(error),
        ),
      ),
    );
  }
}
