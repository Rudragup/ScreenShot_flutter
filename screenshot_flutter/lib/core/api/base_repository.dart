import 'package:dio/dio.dart';

/// ===============================
/// API RESULT WRAPPER
/// ===============================

sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final ApiError error;
  const ApiFailure(this.error);
}

extension ApiResultX<T> on ApiResult<T> {
  void when({
    required void Function(T data) success,
    required void Function(ApiError error) failure,
  }) {
    if (this is ApiSuccess<T>) {
      success((this as ApiSuccess<T>).data);
    } else if (this is ApiFailure<T>) {
      failure((this as ApiFailure<T>).error);
    }
  }
}

/// ===============================
/// API ERROR MODEL
/// ===============================

enum ApiErrorType {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  validation,
  server,
  unknown,
  cancelled,
  success,
}

class ApiError {
  final ApiErrorType type;
  final String message;
  final int? statusCode;

  /// 👇 COMPLETE RAW BACKEND RESPONSE
  final dynamic raw;

  const ApiError({
    required this.type,
    required this.message,
    this.statusCode,
    this.raw,
  });
}

/// ===============================
/// BASE REPOSITORY
/// ===============================

abstract class BaseRepository {
  final Dio dio;

  BaseRepository(this.dio);

  Future<ApiResult<T>> safeApiCall<T>({
    required Future<Response<dynamic>> Function() apiCall,
    required T Function(dynamic json) parser,
  }) async {
    try {
      final response = await apiCall();
      final statusCode = response.statusCode ?? 0;
      final body = response.data;

      // ✅ HANDLE: success/status == false EVEN WITH 200
      if (statusCode >= 200 && statusCode < 300) {
        final isBusinessFailure =
            body is Map<String, dynamic> &&
            (body['success'] == false ||
                body['success'] == 'false' ||
                body['status'] == false ||
                body['status'] == 'false');

        if (isBusinessFailure) {
          return ApiFailure(
            ApiError(
              type: _inferBusinessErrorType(body, statusCode),
              message: _extractMessage(body),
              statusCode: statusCode,
              raw: body,
            ),
          );
        }

        // ✅ REAL SUCCESS
        return ApiSuccess(parser(body));
      }

      // ❌ HTTP ERROR
      return ApiFailure(
        ApiError(
          type: _mapStatus(statusCode),
          message: _extractMessage(body),
          statusCode: statusCode,
          raw: body,
        ),
      );
    } on DioException catch (e) {
      return ApiFailure(_mapDioError(e));
    } catch (e) {
      return ApiFailure(
        ApiError(type: ApiErrorType.unknown, message: e.toString()),
      );
    }
  }

  ApiErrorType _inferBusinessErrorType(
    Map<String, dynamic> body,
    int statusCode,
  ) {
    // If backend gives explicit code later, you can extend this
    if (statusCode == 200) {
      return ApiErrorType.validation;
    }
    return _mapStatus(statusCode);
  }

  /// -------------------------------
  /// STATUS → ERROR TYPE
  /// -------------------------------
  ApiErrorType _mapStatus(int code) {
    switch (code) {
      case 401:
        return ApiErrorType.unauthorized;
      case 403:
        return ApiErrorType.forbidden;
      case 404:
        return ApiErrorType.notFound;
      case 408:
        return ApiErrorType.timeout;
      case 422:
        return ApiErrorType.validation;
      default:
        if (code >= 500) return ApiErrorType.server;
        return ApiErrorType.unknown;
    }
  }

  /// -------------------------------
  /// DIO ERROR MAPPING
  /// -------------------------------
  ApiError _mapDioError(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return const ApiError(
        type: ApiErrorType.network,
        message: 'No internet connection',
      );
    }

    if (e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const ApiError(
        type: ApiErrorType.timeout,
        message: 'Request timed out',
      );
    }

    return const ApiError(
      type: ApiErrorType.unknown,
      message: 'Something went wrong',
    );
  }

  /// -------------------------------
  /// BACKEND MESSAGE EXTRACTION
  /// -------------------------------
  String _extractMessage(dynamic body) {
    if (body is Map<String, dynamic>) {
      return body['message']?.toString() ??
          body['error']?.toString() ??
          body['msg']?.toString() ??
          'Request failed';
    }
    return 'Request failed';
  }
}
