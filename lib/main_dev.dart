import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/main_prod.dart';


void main() {
  runApp(
    const ProviderScope(
      
      child:   MyApp(),
    ),
  );
}
