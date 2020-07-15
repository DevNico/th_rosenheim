import 'dart:convert';

import 'package:flutter/material.dart';

import '../logger.dart';
import '../model/canteen.dart';
import '../utils/date_utils.dart';
import '../utils/json_util.dart';
import 'base_api.dart';

class EatApi extends BaseApi {
  static final EatApi _instance = EatApi._();

  EatApi._()
      : super(
          baseUrl: 'https://tum-dev.github.io/eat-api/stubistro-rosenheim/',
          cacheDbName: 'eat_cache',
          defaultMaxAge: Duration(days: 1),
          defaultMaxStale: Duration(days: 7),
        );

  factory EatApi() {
    return _instance;
  }

  Future<CanteenWeek> getCanteenWeek({
    @required int year,
    @required int week,
  }) async {
    final now = DateTime.now();
    week = week ?? now.weekOfYear;

    final url = '${year ?? now.year}/${week < 10 ? '0$week' : week}.json';

    try {
      final response = await dio.get(url);
      final json = await parseJsonInBackground(utf8.decode(response.data));
      return CanteenWeek.fromJson(json);
    } on Exception catch (_) {
      logger.e('Error getting CanteenWeek from EatApi.\n$url');
      return null;
    }
  }
}
