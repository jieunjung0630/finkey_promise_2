import '../models/report_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../core/errors/exceptions.dart';

class ReportLocalDataSource {
  Future<ReportModel> getReportFromJson(String key) async {
    try {
      final String response = await rootBundle.loadString('assets/reports.json');
      final data = json.decode(response);
      if (data[key] != null) {
        return ReportModel.fromJson(data[key]);
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
