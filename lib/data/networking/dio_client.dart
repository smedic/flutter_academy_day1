import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_academy_day1/data/networking/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late Dio _dio;

  DioClient._() {
    initialise();
  }

  static final instance = DioClient._();

  void initialise() {
    _dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: {
            HttpHeaders.userAgentHeader: 'dio',
            'api': '1.0.0',
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          validateStatus: (status) =>
              status == null ? false : status >= 200 && status < 400),
    );
    _dio.interceptors.add(PrettyDioLogger(requestBody: true));
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      if (response.data == null || response.data == 'null') {
        return {};
      }
      return response.data as Map<String, dynamic>;
    } on DioException catch (ex) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(String path, {Object? data}) async {
    try {
      final Response response = await _dio.post(path, data: data);
      return response.data;
    } on DioException {
      rethrow;
    }
  }
}
