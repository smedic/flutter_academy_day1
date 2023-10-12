import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_academy_day1/data/networking/paths.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late Dio _dio;

  DioClient._() {
    initialiseDio();
  }

  static final instance = DioClient._();

  void initialiseDio() {
    _dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 30),
          headers: {
            HttpHeaders.userAgentHeader: 'dio',
            'api': '1.0.0',
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          validateStatus: (status) =>
              status == null ? false : status >= 200 && status < 400),
    );
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response result = await _dio.get(
        path,
        options: options,
        queryParameters: queryParameters,
      );
      if (result.data == null || result.data == 'null') {
        return {};
      }
      return result.data as Map<String, dynamic>;
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
