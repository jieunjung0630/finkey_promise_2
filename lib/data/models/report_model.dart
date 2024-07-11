import '../../domain/entities/report.dart';

class ReportModel extends Report {
  ReportModel({required String summary}) : super(summary: summary);

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(summary: json['summary']);
  }
}
