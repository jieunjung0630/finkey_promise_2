import '../entities/user_input.dart';
import '../entities/report.dart';
import '../repositories/report_repository.dart';
import '../../data/repositories/report_repository_impl.dart';
import '../../core/errors/exceptions.dart';

class GetReportUseCase {
  final ReportRepository repository = ReportRepositoryImpl();

  Future<Report> execute(UserInput userInput) async {
    try {
      return await repository.getReport(userInput);
    } catch (e) {
      throw e;
    }
  }
}
