import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/networking/dio_client.dart';
import 'package:flutter_academy_day1/screens/login_screen.dart';

void main() {
  DioClient.instance.initialise();
  runApp(
    MaterialApp(
      home: const StartScreen(),
      theme: ThemeData(useMaterial3: true),
    ),
  );
}
