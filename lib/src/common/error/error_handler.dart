import 'package:dio/dio.dart';
import 'api_error.dart';

class ErrorHandler {
  static ApiError handle(Object error) {
    // ✅ Dio errors
    if (error is DioException) {
      final response = error.response;

      // Backend error response
      if (response != null && response.data != null) {
        final data = response.data;

        final message = data["message"] ?? "Something went wrong";

        return ApiError(
          message,
          statusCode: response.statusCode,
        );
      }

      // Network issues
      if (error.type == DioExceptionType.connectionError) {
        return ApiError("No Internet Connection");
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return ApiError("Connection timeout. Please try again.");
      }

      return ApiError("Something went wrong");
    }

    // Unknown error
    return ApiError("Unexpected error occurred");
  }
}