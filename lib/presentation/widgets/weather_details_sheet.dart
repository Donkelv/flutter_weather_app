import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_app/domain/entities/current_forecast_weather_model.dart';
import 'package:flutter_weather_app/utils/image_const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class WeatherDetailsSheet extends StatelessWidget {
  final Daily daily;
  const WeatherDetailsSheet({Key? key, required this.daily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 23.0.w, top: 15.0.h, bottom: 15.0.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0.h,
                ),
                Text(
                  "${daily.temp!.day}°",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.merriweather(fontSize: 30.0.sp),
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                Text(
                  "${daily.summary}",
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15.0.sp),
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                
                Row(
                  children: [
                    const Icon(Icons.wind_power),
                    Expanded(
                      child: Text(
                        " Pressure: ${daily.pressure}",
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15.0.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Row(
                  children: [
                    const Icon(Icons.thermostat),
                    Expanded(
                      child: Text(
                        " Feels Like: ${daily.feelsLike?.day}°",
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15.0.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Row(
                  children: [
                    const Icon(Icons.water),
                    Expanded(
                      child: Text(
                        " Humidity: ${daily.humidity}",
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15.0.sp),
                      ),
                    ),
                  ],
                ),
              ],
          
            ),
          ),
          SizedBox(
         
            height: 150.0.h,
            width: 150.0.w,
            child: RiveAnimation.asset(
              ImageConst.windmillAnimation,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
