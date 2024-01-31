import 'package:kisgeri24/data/exception/not_found_exception.dart';
import 'package:kisgeri24/data/models/year.dart';
import 'package:kisgeri24/data/repositories/year_repository.dart';
import 'package:kisgeri24/logging.dart';

class YearService {
  final YearRepository repository;

  YearService(this.repository);

  Future<List<Year>> listYears() async {
    logger.d('Collecting years..');
    List<Year> years = await repository.fetchAll();
    years = years
        .where((element) => element.tenantId != '')
        .toList(growable: false);
    logger.d(
        'The following years are about to return: ${years.map((e) => e.year)}');
    return years;
  }

  Future<Year> getYearByTenantId(String tenantId) async {
    logger.d('Collecting year for tenant: $tenantId..');
    Year? year = await repository.getByTenant(tenantId);
    if (year == null) {
      NotFoundException notFound =
          NotFoundException('No year found for tenant: $tenantId');
      logger.w(notFound.message, error: notFound);
      throw notFound;
    }
    logger.d('The following year is about to return: ${year.year}');
    return year;
  }
}
