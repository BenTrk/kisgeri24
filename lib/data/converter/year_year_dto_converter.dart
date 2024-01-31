import "dart:convert";

import "package:kisgeri24/data/dto/year_dto.dart";
import "package:kisgeri24/data/models/year.dart";
import "package:kisgeri24/logging.dart";

class YearToYearDtoConverter extends Converter<Year, YearDto> {
  @override
  YearDto convert(Year input) {
    logger.d("Converting Year [$input] to its corresponding DTO");
    return YearDto(input.id, input.year, input.tenantId);
  }
}
