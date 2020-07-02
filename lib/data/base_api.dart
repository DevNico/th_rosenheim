import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

abstract class BaseApi {
  Dio dio;

  BaseApi({
    @required String baseUrl,
    @required String cacheDbName,
    @required Duration defaultMaxAge,
    @required Duration defaultMaxStale,
  }) {
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.bytes,
    );
    dio = Dio(baseOptions);

    final cacheManager = DioCacheManager(CacheConfig(
      baseUrl: baseUrl,
      defaultMaxAge: defaultMaxAge,
      defaultMaxStale: defaultMaxStale,
      databaseName: cacheDbName,
    ));
    dio.interceptors.add(cacheManager.interceptor);
  }
}
