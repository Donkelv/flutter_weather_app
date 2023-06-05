import 'package:flutter/material.dart';
import 'package:flutter_weather_app/utils/image_const.dart';
import 'package:rive/rive.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 300.0,
              width: 300.0,
              child: RiveAnimation.asset(
                ImageConst.errorLoaderAnimation,
                fit: BoxFit.contain,
              )),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
