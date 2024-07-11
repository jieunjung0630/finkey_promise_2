import '../../domain/entities/user_input.dart';
import '../../domain/entities/report.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasources/report_local_datasource.dart';
import '../../core/utils/zodiac_mapper.dart';
import '../../core/errors/exceptions.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportLocalDataSource dataSource = ReportLocalDataSource();

  @override
  Future<Report> getReport(UserInput userInput) async {
    try {
      final zodiacSign = ZodiacMapper.getZodiacSign(userInput.birthday);
      final key = '${userInput.mbti}-${userInput.bloodType}-$zodiacSign';
      final reportModel = await dataSource.getReportFromJson(key);
      return Report(summary: reportModel.summary);
    } catch (e) {
      if (e is CacheException) {
        throw CacheException();
      } else {
        throw ServerException();
      }
    }
  }
}
