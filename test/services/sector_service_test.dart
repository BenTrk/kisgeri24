@GenerateNiceMocks([MockSpec<SectorToSectorDtoConverter>()])
import "package:kisgeri24/data/converter/sector_sector_dto_converter.dart";
import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/sector.dart";
@GenerateNiceMocks([MockSpec<SectorRepository>()])
import "package:kisgeri24/data/repositories/sector_repository.dart";
import "package:kisgeri24/services/sector_service.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";

import "sector_service_test.mocks.dart";
import "../test_utils/test_utils.dart";

late SectorService underTest;
late SectorToSectorDtoConverter mockSectorToSectorDtoConverter;
late MockSectorRepository mockSectorRepository;

void main() {
  testGetSectorNamesWhenNoSectorComingBackFromDatabase();
  testGetSectorNamesWhenSingleSectorComingBackFromDatabase();
  testGetSectorNamesWhenMultipleSectorComingBackFromDatabase();

  testGetSectorsWithRoutesNoSector();
  testGetSectorsWithRoutesNoSector();
}

void testGetSectorNamesWhenNoSectorComingBackFromDatabase() {
  configure();
  test("Test sector name fetch when no sector can be fetched from DB",
      () async {
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(List.empty()));

    List<String> result = await underTest.getSectorNames();

    expect(result != null, true);
    expect(result.length, 0);
  });
}

void testGetSectorNamesWhenSingleSectorComingBackFromDatabase() {
  configure();
  test("Test sector name fetch when a single sector can be fetched from DB",
      () async {
    List<Sector> sectorFromDb = [
      new Sector("testSectorName", testOrdinal, List.empty(), List.empty())
    ];
    when(mockSectorToSectorDtoConverter.convert(sectorFromDb[0]))
        .thenReturn(SectorDto(sectorFromDb[0].name, testOrdinal, List.empty()));
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(sectorFromDb));

    List<String> result = await underTest.getSectorNames();

    expect(result != null, true);
    expect(result.length, sectorFromDb.length);
    expect(result[0], sectorFromDb[0].name);
  });
}

void testGetSectorNamesWhenMultipleSectorComingBackFromDatabase() {
  configure();
  test("Test sector name fetch when a single sector can be fetched from DB",
      () async {
    List<Sector> sectorFromDb = [
      new Sector("testSectorName-1", testOrdinal, List.empty(), List.empty()),
      new Sector(
          "testSectorName-2", testOrdinal + 1, List.empty(), List.empty())
    ];
    when(mockSectorToSectorDtoConverter.convert(sectorFromDb[0]))
        .thenReturn(SectorDto(sectorFromDb[0].name, testOrdinal, List.empty()));
    when(mockSectorToSectorDtoConverter.convert(sectorFromDb[1])).thenReturn(
        SectorDto(sectorFromDb[1].name, testOrdinal + 1, List.empty()));
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(sectorFromDb));

    List<String> result = await underTest.getSectorNames();

    expect(result != null, true);
    expect(result.length, sectorFromDb.length);
    expect(result, sectorFromDb.map((sector) => sector.name).toList());
  });
}

void testGetSectorsWithRoutesNoSector() {
  configure();
  test("Test getSectorsWithRoutes when no Sector can be fetched from the DB",
      () async {
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(List.empty()));

    List<SectorDto> result = await underTest.getSectorsWithRoutes();

    expect(result != null, true);
    expect(result.length, 0);
  });
}

void testGetSectorsWithRoutesSingleSector() {
  configure();
  test(
      "Test getSectorsWithRoutes when a single Sector can be fetched from the DB",
      () async {
    List<Sector> sectorsFromDb = [
      new Sector("testSectorName", testOrdinal, List.empty(), List.empty())
    ];
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(List.empty()));

    List<SectorDto> result = await underTest.getSectorsWithRoutes();

    expect(result != null, true);
    expect(result.length, sectorsFromDb.length);
    expect(result[0], sectorsFromDb[0]);
  });
}

void testGetSectorsWithRoutesMultipleSector() {
  configure();
  test("Test sector name fetch when a single sector can be fetched from DB",
      () async {
    List<Sector> sectorFromDb = [
      new Sector("testSectorName-1", testOrdinal, List.empty(),
          TestUtils.createRoute()),
      new Sector("testSectorName-2", testOrdinal + 1, List.empty(),
          TestUtils.createRoute(quantity: 2))
    ];
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(sectorFromDb));

    List<String> result = await underTest.getSectorNames();

    expect(result != null, true);
    expect(result.length, sectorFromDb.length);
    expect(result, sectorFromDb.map((sector) => sector.name).toList());
  });
}

void configure() {
  setUp(() {
    mockSectorRepository = MockSectorRepository();
    mockSectorToSectorDtoConverter = MockSectorToSectorDtoConverter();
    underTest =
        SectorService(mockSectorRepository, mockSectorToSectorDtoConverter);
  });
}
