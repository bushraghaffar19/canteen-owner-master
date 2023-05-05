import 'package:flutter/material.dart';

class HomeDataModel {
  final String text;
  final String? boldedText;
  final Widget? route;
  final String? trailingText;
  final bool isPopup;

  HomeDataModel({
    required this.text,
    this.boldedText,
    this.route,
    this.trailingText,
    this.isPopup = false,
  });
}
