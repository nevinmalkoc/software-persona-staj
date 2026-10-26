import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const AeroSpaceApp());

class AeroSpaceApp extends StatelessWidget {
  const AeroSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AeroSpace Katalog',
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: HomeScreen(),
    );
  }
}