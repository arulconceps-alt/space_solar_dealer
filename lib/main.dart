
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'src/app/app.dart';

Future<void> main() async {
  debugPaintBaselinesEnabled = false;
  runApp(App() as Widget);
}
