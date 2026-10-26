import 'package:flutter/material.dart';

class Planet {
  final String name;
  final String description;
  final String image;
  final String gravity;
  final String temperature;
  final Color themeColor;

  Planet({
    required this.name,
    required this.description,
    required this.image,
    required this.gravity,
    required this.temperature,
    required this.themeColor,
  });
}