import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_academy_day1/networking/paths.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  DioClient._();

  static final instance = DioClient._();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        'api': '1.0.0',
      },
      validateStatus: (statusCode) =>
          statusCode == null ? false : statusCode >= 200 && statusCode < 400,
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
    ),
  );

  void initialise() {
    _dio.interceptors.add(
      PrettyDioLogger(),
    );
  }

  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await _dio.get(path, queryParameters: queryParameters);
      if (response.data == null || response.data == 'null') {
        return {};
      }
      return response.data;
    } on DioException {
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

  Future<dynamic> delete(String path) async {
    try {
      final Response response = await _dio.delete(path);
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String path, {
    data,
  }) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }
}
