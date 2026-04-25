import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:space_solar_dealer/src/app/flavor_config.dart';
import 'package:space_solar_dealer/src/common/constants/constansts.dart';
import 'package:space_solar_dealer/src/common/repos/api_exception.dart';
import 'package:space_solar_dealer/src/common/repos/prefences_repository.dart';

class ApiRepository {
  late final Logger log;
  final Dio _dio;
  final PreferencesRepository prefRepo;
  final FlavorConfig _flavorConfig;

  ApiRepository(this._dio, this.prefRepo) : _flavorConfig = GetIt.I<FlavorConfig>() {
    log = Logger(level: _flavorConfig.logLevel);

    _dio.options.baseUrl = _flavorConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);

    // Initial Token Setup
    final String? authToken = prefRepo.getPreference(Constants.store.AUTH_TOKEN);
    if (authToken != null) {
      _dio.options.headers["Authorization"] = "Bearer $authToken";
    }

    // Add Interceptors for a "smooth" experience
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = prefRepo.getPreference(Constants.store.AUTH_TOKEN);

          if (token != null && token.toString().isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          log.w("TOKEN => $token"); // 👈 MUST PRINT TOKEN

          return handler.next(options);
        },

        onResponse: (response, handler) {
          log.i("✅ RESPONSE ${response.statusCode}");
          log.i(response.data);
          return handler.next(response);
        },

        onError: (error, handler) {
          log.e("❌ ERROR ${error.response?.statusCode}");
          log.e(error.response?.data);
          return handler.next(error);
        },
      ),
    );
  }

  void updateToken(String? token) {
    if (token == null) {
      _dio.options.headers.remove("Authorization");
    } else {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }
  }

  // Unified Request Handler
  Future<Map<String, dynamic>> _performRequest(
      String url, {
        required String method,
        Map<String, dynamic>? data,
        bool includeRequester = true,
      }) async {
    try {
      if (_flavorConfig.useMockApi) {
        await Future.delayed(const Duration(milliseconds: 500));
        return {"success": true, "message": "Mocked response", "data": {}};
      }

      final response = await _dio.request(
        url,
        data: data,
        options: Options(
          method: method,
          extra: {'includeRequester': includeRequester},
        ),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Public Methods
  Future<Map<String, dynamic>> postRequest({
    required String url,
    required Map<String, dynamic> data,
    bool includeRequester = true,
  }) => _performRequest(url, method: 'POST', data: data, includeRequester: includeRequester);

  Future<Map<String, dynamic>> patchRequest({
    required String url,
    required Map<String, dynamic> data,
    bool includeRequester = true,
  }) => _performRequest(url, method: 'PATCH', data: data, includeRequester: includeRequester);

  Future<dynamic> getRequest(String url) => _performRequest(url, method: 'GET');

  dynamic _handleResponse(Response response) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data is String ? jsonDecode(response.data) : response.data;
    }
    throw Exception("HTTP error: ${response.statusCode}");
  }

  Exception _handleError(DioException error) {
    String errorMessage = "Something went wrong";

    if (error.type == DioExceptionType.badResponse && error.response?.data != null) {
      final data = error.response!.data;
      final responseMap = data is String ? jsonDecode(data) : data;

      if (responseMap is Map) {
        errorMessage = responseMap['message']?.toString() ??
            responseMap['error']?.toString() ??
            errorMessage;
      }
    } else if (error.type == DioExceptionType.connectionError) {
      errorMessage = "No Internet Connection";
    }

    return ApiException(errorMessage);
  }
}