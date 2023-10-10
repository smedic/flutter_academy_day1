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
      if (response.statusCode == 200) {
        if (response.data == null || response.data == 'null') {
          return {};
        }
        return response.data;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(String path, {Object? data}) async {
    try {
      final Response response = await _dio.post(path, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw Exception('Something went wrong');
    } catch (e) {
      rethrow;
    }
  }
}
