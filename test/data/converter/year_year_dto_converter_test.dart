import "package:kisgeri24/data/converter/year_year_dto_converter.dart";
import "package:kisgeri24/data/dto/year_dto.dart";
import "package:kisgeri24/data/models/year.dart";

import "../../test_utils/test_utils.dart";

import "package:test/test.dart";

late YearToYearDtoConverter underTest;

void main() {
  underTest = YearToYearDtoConverter();

  testConvert();
}

void testConvert() {
  test("Test convert from Year to YearDto", () {
    Year year = testYear;
    YearDto result = underTest.convert(year);

    expect(result != null, true);
    expect(result.id, year.id);
    expect(result.year, year.year);
    expect(result.tenantId, year.tenantId);
  });
}
