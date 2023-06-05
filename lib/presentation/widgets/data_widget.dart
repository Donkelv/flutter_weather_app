import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
import 'package:flutter_weather_app/presentation/providers/weather_provider.dart';
import 'package:flutter_weather_app/presentation/state/weather_state.dart';
import 'package:flutter_weather_app/presentation/widgets/weather_details_sheet.dart';
import 'package:flutter_weather_app/utils/custom_stacked_bottom_sheet.dart';
import 'package:flutter_weather_app/utils/image_const.dart';
import 'package:flutter_weather_app/utils/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as rive;

import '../providers/dark_mode_status_provider.dart';

class WeatherDataWidget extends ConsumerWidget {
  const WeatherDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    CurrentForecastWeatherModel? weatherData =
        ref.watch(fetchWeatherDataProvider).data;
    final isDarkMode = ref.watch(darkModeProvider.notifier);
    final isDarkModeValue = ref.watch(darkModeProvider);
    return SafeArea(
      top: true,
      bottom: false,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Align(
          alignment: Alignment.center,
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            color: Colors.black,
            onRefresh: () {
              return Future.delayed(Duration.zero, () {
                ref.watch(fetchWeatherDataProvider.notifier).fetchWeatherData();
              });
            },
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => isDarkMode.state = !isDarkMode.state,
                      icon: Icon(isDarkModeValue == true
                          ? Icons.light_mode
                          : Icons.dark_mode),
                    ),
                  ],
                ),
                SizedBox(
                    height: 100.0.h,
                    width: 100.0.w,
                    child: rive.RiveAnimation.asset(
                      ImageConst.riveLoaderAnimation,
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                  height: 60.0.h,
                ),
                Text(
                  weatherData!.timezone!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0.sp),
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Text(
                  "${weatherData.current!.temp!.floor().toString()}°",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(fontSize: 100.0.sp),
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Text(
                  StringExtensions(
                          weatherData.current!.weather![0].description!)
                      .capitalize(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0.sp,
                  ),
                ),
                SizedBox(
                  height: 15.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Min: ${weatherData.daily![0].temp!.min} °",
                        style: GoogleFonts.merriweather(fontSize: 15.0.sp)),
                    SizedBox(
                      width: 10.0.w,
                    ),
                    Text("Max: ${weatherData.daily![0].temp!.max} °",
                        style: GoogleFonts.merriweather(fontSize: 15.0.sp)),
                  ],
                ),
                SizedBox(
                  height: 30.0.h,
                ),
                DailyWeatherBox(size: size, weatherData: weatherData, isDarkMode: isDarkModeValue,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DailyWeatherBox extends StatelessWidget {
  const DailyWeatherBox({
    super.key,
    required this.size,
    required this.weatherData,
    required this.isDarkMode,
  });

  final Size size;
  final CurrentForecastWeatherModel? weatherData;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0.w),
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black12.withOpacity(0.5),
                Colors.black12.withOpacity(0.3),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weatherData!.daily![0].summary!,
                  style: TextStyle(fontSize: 15.0.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  height: 10.0.h,
                  thickness: 2.0.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 100.0.h,
                  child: ListView.builder(
                    itemCount: weatherData!.daily!.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CustomDailyWeatherWidget(
                        weatherData: weatherData,
                        index: index,
                        onTap: () {
                          customShowStackedBottomSheet(
                            isDarkMode: isDarkMode,
                              child: WeatherDetailsSheet(
                                daily: weatherData!.daily![index],
                                
                              ),
                              context: context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDailyWeatherWidget extends StatelessWidget {
  const CustomDailyWeatherWidget({
    super.key,
    required this.weatherData,
    required this.index,
    this.onTap,
  });

  final CurrentForecastWeatherModel? weatherData;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0.w),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                index == 0 ? "Now" : "${DateTime.now().day + index}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0.sp, color: Colors.white),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              const Icon(
                Icons.cloud,
                color: Colors.white,
              ),
              SizedBox(
                height: 10.0.h,
              ),
              Text(
                "${weatherData!.daily![index].temp!.day!.floor()} °",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0.sp, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
