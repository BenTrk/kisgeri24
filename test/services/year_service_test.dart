@GenerateNiceMocks(
    [MockSpec<YearRepository>(), MockSpec<YearToYearDtoConverter>()])
import "package:kisgeri24/data/converter/year_year_dto_converter.dart";
import "package:kisgeri24/data/dto/year_dto.dart";
import "package:kisgeri24/data/exception/not_found_exception.dart";
import "package:kisgeri24/data/models/year.dart";
import "package:kisgeri24/data/repositories/year_repository.dart";
import "package:kisgeri24/services/year_service.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";

import "year_service_test.mocks.dart";

final String yearId_1 = "1111";
final int year_1 = 2020;
final String tenantId_1 = "some-tenant-for-1111";
final String yearId_2 = "2222";
final int year_2 = 2021;
final String tenantId_2 = "some-tenant-for-2222";

late MockYearRepository mockYearRepository;
late MockYearToYearDtoConverter mockYearToYearDtoConverter;
late YearService underTest;

void main() {
  mockYearRepository = MockYearRepository();
  mockYearToYearDtoConverter = MockYearToYearDtoConverter();
  underTest = YearService(mockYearRepository, mockYearToYearDtoConverter);

  testFetchAll();
  testGetYearByTenantId();
}

void testFetchAll() {
  group("Test fetchAll", () {
    test(
        "Test to check if the correct number of years return when no filter happens upon empty tenantId value check.",
        () async {
      Year firstYear = Year(yearId_1, year_1, tenantId_1);
      Year secondYear = Year(yearId_2, year_2, tenantId_2);
      when(mockYearToYearDtoConverter.convert(firstYear)).thenReturn(
          YearDto(firstYear.id, firstYear.year, firstYear.tenantId));
      when(mockYearToYearDtoConverter.convert(secondYear)).thenReturn(
          YearDto(secondYear.id, secondYear.year, secondYear.tenantId));
      when(mockYearRepository.fetchAll()).thenAnswer(
          (_) async => Future.value(List.of([firstYear, secondYear])));

      List<YearDto> result = await underTest.listYears();

      expect(result.length, 2);
    });
    test(
        "Test to check if the correct number of years return when filter happens upon ab empty tenantId value check.",
        () async {
      Year firstYear = Year(yearId_1, year_1, "");
      Year secondYear = Year(yearId_2, year_2, tenantId_2);
      when(mockYearToYearDtoConverter.convert(secondYear)).thenReturn(
          YearDto(secondYear.id, secondYear.year, secondYear.tenantId));
      when(mockYearRepository.fetchAll()).thenAnswer(
          (_) async => Future.value(List.of([firstYear, secondYear])));

      List<YearDto> result = await underTest.listYears();

      expect(result.length, 1);
    });
  });
}

void testGetYearByTenantId() {
  group("Test getYearByTenantId", () {
    test(
        "Test to check if the correct year return when the tenantId is the expected.",
        () async {
      Year year = Year(yearId_1, year_2, tenantId_1);
      when(mockYearRepository.getByTenant(tenantId_1))
          .thenAnswer((_) async => Future.value(year));

      Year result = await underTest.getYearByTenantId(tenantId_1);

      expect(result, year);
    });
    test(
        "Test to check if the Exception comes when no year can be found for the tenantId.",
        () async {
      when(mockYearRepository.getByTenant(tenantId_2))
          .thenAnswer((_) async => Future.value(null));

      expect(
          () => underTest.getYearByTenantId(tenantId_2),
          throwsA(isA<NotFoundException>().having((e) => e.message, "message",
              "No year found for tenant: $tenantId_2")));
    });
  });
}
