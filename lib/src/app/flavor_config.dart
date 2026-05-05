import 'package:logger/logger.dart';

enum Flavor {
  dev,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String appName;
  final String baseUrl;
  final bool useMockApi;
  final Level logLevel;
  final bool showBanner;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String appName,
    required String baseUrl,
    bool useMockApi = false,
    Level logLevel = Level.debug,
    bool showBanner = false,
  }) {
    _instance = FlavorConfig._internal(
      flavor,
      appName,
      baseUrl,
      useMockApi,
      logLevel,
      showBanner,
    );
    return _instance!;
  }

  FlavorConfig._internal(
    this.flavor,
    this.appName,
    this.baseUrl,
    this.useMockApi,
    this.logLevel,
    this.showBanner,
  );

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance?.flavor == Flavor.prod;
  static bool isDevelopment() => _instance?.flavor == Flavor.dev;
}
