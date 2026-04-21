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

  void updateToken(String? token) {
    if (token == null) {
      _dio.options.headers.remove("Authorization");
    } else {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }
  }
  ApiRepository(this._dio, this.prefRepo) : _flavorConfig = GetIt.I<FlavorConfig>() {
    log = Logger(level: _flavorConfig.logLevel);
    final String? authToken = prefRepo.getPreference(Constants.store.AUTH_TOKEN);
    if (authToken != null) {
      _dio.options.headers["Authorization"] = "Bearer $authToken";
    }
  }

  String buildRequest({required Map<String, dynamic> data}) {
    try {
      final Map<String, dynamic> requestJson = {
        "requester": {
          "name": Constants.app.APP_NAME,
          "version": "1.0",
          "timestamp": DateTime.now().toUtc().toIso8601String(),
          "requestedby": prefRepo.getPreference(Constants.store.USER_ID),
        },
      };

      data.forEach((key, value) {
        log.d("ApiRepository::buildRequest::$key - $value");
        requestJson[key] = value;
      });

      log.d("ApiRepository::buildRequest::Final JSON: $requestJson");
      return json.encode(requestJson);
    } catch (error) {
      log.e("ApiRepository::buildRequest::Error: $error");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postRequest({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      log.d("ApiRepository::postRequest::URL: $url, Data: $data");

      // --- [MOCK LOGIC] ---
      if (_flavorConfig.useMockApi) {
        log.d("ApiRepository::postRequest::MOCK MODE ENABLED. Simulating success.");
        await Future.delayed(const Duration(milliseconds: 500));
        return {"success": true, "message": "Mocked response", "data": {}};
      }

      String? authToken = prefRepo.getPreference(Constants.store.AUTH_TOKEN);
      log.d("ApiRepository::postRequest::AuthToken: $authToken");

      if (authToken != null) {
        _dio.options.headers['Authorization'] = 'Bearer $authToken';
      }

      final fullUrl = _flavorConfig.baseUrl + url;
      final requestBodyString = buildRequest(data: data);

      log.d(
        "ApiRepository::postRequest::Posting to $fullUrl with body: $requestBodyString",
      );

      final response = await _dio.post(fullUrl, data: json.decode(requestBodyString));

      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (dioError) {
      log.e("ApiRepository::postRequest::DioException: ${dioError.message}");
      throw _handleError(dioError);
    }
  }

  Future<Map<String, dynamic>> patchRequest({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      log.d("ApiRepository::patchRequest::URL: $url, Data: $data");

      String? authToken = prefRepo.getPreference(Constants.store.AUTH_TOKEN);
      log.d("ApiRepository::patchRequest::AuthToken: $authToken");

      if (authToken != null) {
        _dio.options.headers['Authorization'] = 'Bearer $authToken';
      }

      final fullUrl = _flavorConfig.baseUrl + url;
      final requestBodyString = buildRequest(data: data);

      log.d(
        "ApiRepository::patchRequest::Patching to $fullUrl with body: $requestBodyString",
      );

      final response = await _dio.patch(
        fullUrl,
        data: json.decode(requestBodyString),
      );

      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (dioError) {
      log.e("ApiRepository::patchRequest::DioException: ${dioError.message}");
      throw _handleError(dioError);
    }
  }

  Future<dynamic> getRequest(String url) async {
    try {
      log.d('comes to URL $url');

      // --- [MOCK LOGIC] ---
      if (_flavorConfig.useMockApi) {
        log.d("ApiRepository::getRequest::MOCK MODE ENABLED. Simulating success.");
        await Future.delayed(const Duration(milliseconds: 500));
        return {"success": true, "message": "Mocked response", "data": []};
      }

      final fullUrl = _flavorConfig.baseUrl + url;
      final response = await _dio.get(fullUrl);
      log.d('hhhhh $response');
      log.d('handler :: ${_handleResponse(response)}');
      return _handleResponse(response);
    } on DioException catch (dioError) {
      log.e("ApiRepository::getRequest::DioException: ${dioError.message}");
      throw _handleError(dioError);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final data = response.data;
      if (data is Map) {
        return data;
      } else if (data is String) {
        try {
          return jsonDecode(data);
        } catch (error) {
          log.e("ApiRepository::_handleResponse::JSON decode error: $error");
          throw Exception("Failed to decode response JSON: $error");
        }
      } else {
        return data;
      }
    } else {
      log.e(
        "ApiRepository::_handleResponse::HTTP error ${response.statusCode} - ${response.statusMessage}",
      );
      throw Exception(
        "HTTP error: ${response.statusCode} - ${response.statusMessage}",
      );
    }
  }

  Exception _handleError(DioException error) {
    log.e("ApiRepository::_handleError::Error message: ${error.message}");

    String errorMessage;

    switch (error.type) {
      case DioExceptionType.connectionError:
        errorMessage = "Connection error.";
        break;

      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timed out.";
        break;

      case DioExceptionType.receiveTimeout:
        errorMessage = "Receive timeout.";
        break;

      case DioExceptionType.sendTimeout:
        errorMessage = "Send timeout.";
        break;

      case DioExceptionType.cancel:
        errorMessage = "Request cancelled.";
        break;

      case DioExceptionType.badResponse:
        try {
          final response = error.response;

          if (response != null && response.data != null) {
            var data = response.data;

            /// 🔥 HANDLE STRING RESPONSE
            if (data is String) {
              data = jsonDecode(data);
            }

            /// 🔥 HANDLE MAP RESPONSE
            if (data is Map<String, dynamic>) {
              errorMessage =
                  data["message"] ??
                      data["error"] ??
                      "Something went wrong";
            } else {
              errorMessage = "Server error (${response.statusCode})";
            }
          } else {
            errorMessage = "Server error";
          }
        } catch (e) {
          errorMessage = "Unexpected server error";
        }
        break;

      case DioExceptionType.unknown:
      default:
        errorMessage = "Unknown error: ${error.message}";
    }

    return ApiException(errorMessage);
  }
}
