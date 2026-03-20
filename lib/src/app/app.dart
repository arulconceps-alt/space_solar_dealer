import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:space_solar_dealer/src/app/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // FIX 1: Global background color
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF1C1B20)),

      routerConfig: Routes().router,

      // FIX 2: Background inside ResponsiveFramework
      builder: (context, child) => Container(
        color: const Color(0xFF1C1B20),
        child: ResponsiveBreakpoints(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 375, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1920, name: DESKTOP),
            Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}
