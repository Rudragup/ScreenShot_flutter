import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  late final Dio _dio;
  static final DioClient _instance = DioClient._internal();

  /// Explicit singleton accessor for better testability
  static DioClient get instance => _instance;

  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        preserveHeaderCase: true,
        persistentConnection: true,
        contentType: 'application/json',
        baseUrl: '',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
        headers: {'Accept': 'application/json'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    _dio.transformer = BackgroundTransformer()
      ..jsonDecodeCallback = (text) => compute(jsonDecode, text);
    // _dio.interceptors.add(ConnectivityInterceptor());
    // _dio.interceptors.add(AuthInterceptor(_dio));
    // _dio.interceptors.add(_errorInterceptor());
    // _dio.interceptors.add(_cacheInterceptor());
    // _dio.interceptors.add(_retryInterceptor());
    // _dio.interceptors.add(
    //   PrettyDioLogger(
    //     request: true,
    //     logPrint: print,
    //     enabled: kDebugMode,
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     error: true,
    //     compact: true,
    //     maxWidth: 90,
    //   ),
    // );
  }

  Dio get dio => _dio;

  // Future<void> init() async {
  //   final packageInfo = await PackageInfo.fromPlatform();
  //   _dio.options.headers.addAll({
  //     'User-Agent': '${packageInfo.appName}/${packageInfo.version}',
  //     'X-Platform': Platform.operatingSystem,
  //     'X-Version': packageInfo.version,
  //   });
  //   _dio.options.headers['Connection'] = 'keep-alive';
  // }

  // Interceptor _errorInterceptor() {
  //   return InterceptorsWrapper(
  //     onError: (error, handler) {
  //       if (kDebugMode) {
  //         print(
  //           '----------------------------------------------------------------',
  //         );
  //         print('DioError Interceptor: ${error.type}');
  //         print('Message: ${error.message}');
  //         print('Error Object: ${error.error}');
  //         print('Error Type: ${error.error.runtimeType}');
  //         print('Stack Trace: \n${error.stackTrace}');
  //         print(
  //           '----------------------------------------------------------------',
  //         );
  //       }
  //       if (error.response?.statusCode == 401) {
  //         if (kDebugMode) {
  //           print('Unauthorized! Token expired or invalid.');
  //         }
  //       }
  //       handler.next(error);
  //     },
  //   );
  // }

  // Interceptor _retryInterceptor() {
  //   return RetryInterceptor(
  //     dio: _dio,
  //     logPrint: print,
  //     retries: 3,
  //     retryDelays: const [
  //       Duration(seconds: 1),
  //       Duration(seconds: 2),
  //       Duration(seconds: 3),
  //     ],
  //   );
  // }

  // Interceptor _cacheInterceptor() {
  //   final options = CacheOptions(
  //     store: MemCacheStore(),
  //     policy: CachePolicy.request,
  //     priority: CachePriority.low,
  //     maxStale: const Duration(days: 1),
  //   );
  //   return DioCacheInterceptor(options: options);
  // }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

// class ConnectivityService {
//   bool isConnected = true;

//   ConnectivityService() {
//     Connectivity().onConnectivityChanged.listen((result) {
//       isConnected = !result.contains(ConnectivityResult.none);
//     });
//   }
// }

// final connectivityService = ConnectivityService();

// class ConnectivityInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     if (!connectivityService.isConnected) {
//       handler.reject(
//         DioException(
//           requestOptions: options,
//           type: DioExceptionType.connectionError,
//         ),
//       );
//       return;
//     }
//     handler.next(options);
//   }
// }

// class AuthInterceptor extends QueuedInterceptorsWrapper {
//   final Dio dio;
//   bool _isRefreshing = false;
//   bool _refreshFailed = false; // 🔥 NEW
//   final List<Function()> _retryQueue = [];

//   AuthInterceptor(this.dio);

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     if (kDebugMode) {
//       print("🚀 Requesting: ${options.uri}");
//     }
//     if (TokenManager.token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer ${TokenManager.token}';
//     } else {
//       if (kDebugMode) {
//         print("⚠️ No Token Present for this request");
//       }
//     }
//     handler.next(options);
//   }

//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     if (_refreshFailed) {
//       handler.reject(err);
//       return;
//     }

//     if (err.response?.statusCode == 401) {
//       if (_isRefreshing) {
//         _retryQueue.add(() async {
//           final response = await dio.fetch(err.requestOptions);
//           handler.resolve(response);
//         });
//         return;
//       }

//       _isRefreshing = true;

//       try {
//         final newToken = await _refreshToken();
//         await TokenManager.update(newToken);

//         err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

//         final response = await dio.fetch(err.requestOptions);

//         for (final retry in _retryQueue) {
//           retry();
//         }
//         _retryQueue.clear();

//         handler.resolve(response);
//       } catch (_) {
//         _refreshFailed = true; // 🔥 block future retries
//         await TokenManager.clear();
//         handler.reject(err);
//       } finally {
//         _isRefreshing = false;
//       }
//     } else {
//       handler.next(err);
//     }
//   }

//   Future<String> _refreshToken() async {
//     final refreshDio = Dio();
//     final response = await refreshDio.post(
//       '${ApiRoutes.localHost}refreshToken',
//       options: Options(validateStatus: (s) => s != null && s < 500),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Refresh token expired');
//     }

//     return response.data['accessToken'].toString();
//   }
// }

// final noCacheOptions = Options(
//   extra: const CacheOptions(policy: CachePolicy.noCache, store: null).toExtra(),
// );
