import '../entities/user_input.dart';
import '../entities/report.dart';

abstract class ReportRepository {
  Future<Report> getReport(UserInput userInput);
}
