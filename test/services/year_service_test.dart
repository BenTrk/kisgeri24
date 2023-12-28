@GenerateNiceMocks([MockSpec<YearRepository>()])
import 'package:kisgeri24/data/repositories/year_repository.dart';
import 'package:kisgeri24/services/year_service.dart';
import 'package:kisgeri24/data/models/year.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import "package:test/test.dart";

import 'year_service_test.mocks.dart';

late MockYearRepository mockYearRepository;
late YearService underTest;

void main() {
  mockYearRepository = MockYearRepository();
  underTest = YearService(mockYearRepository);

  testFetchAll();
}

void testFetchAll() {
  group("Test fetchAll", () {
    test(
        "Test to check if the correct number of years return when no filter happens upon empty tenantId value check.",
        () async {
      Year firstYear = Year('1111', 2020, 'some-tenant-for-1111');
      Year secondYear = Year('2222', 2021, 'some-tenant-for-2222');
      when(mockYearRepository.fetchAll()).thenAnswer(
          (_) async => Future.value(List.of([firstYear, secondYear])));

      List<Year> result = await underTest.listYears();

      expect(result.length, 2);
    });
    test(
        "Test to check if the correct number of years return when filter happens upon ab empty tenantId value check.",
        () async {
      Year firstYear = Year('1111', 2020, '');
      Year secondYear = Year('2222', 2021, 'some-tenant-for-2222');
      when(mockYearRepository.fetchAll()).thenAnswer(
          (_) async => Future.value(List.of([firstYear, secondYear])));

      List<Year> result = await underTest.listYears();

      expect(result.length, 1);
    });
  });
}
