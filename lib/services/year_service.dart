import "dart:convert";

import "package:kisgeri24/data/dto/year_dto.dart";
import "package:kisgeri24/data/exception/not_found_exception.dart";
import "package:kisgeri24/data/models/year.dart";
import "package:kisgeri24/data/repositories/year_repository.dart";
import "package:kisgeri24/logging.dart";

class YearService {
  final YearRepository repository;
  final Converter<Year, YearDto> yearConverter;

  YearService(this.repository, this.yearConverter);

  Future<List<YearDto>> listYears() async {
    logger.d("Collecting years..");
    List<Year> yearEntities = await repository.fetchAll();
    yearEntities = yearEntities
        .where((element) => element.tenantId != "")
        .toList(growable: false);

    List<YearDto> dtos = yearEntities
        .map((e) => yearConverter.convert(e))
        .toList(growable: false);

    logger.d(
        "The following years are about to return: ${dtos.map((e) => e.year)}");
    return dtos;
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
