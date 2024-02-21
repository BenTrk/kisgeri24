@GenerateNiceMocks([MockSpec<SectorToSectorDtoConverter>()])
import "package:kisgeri24/data/converter/sector_sector_dto_converter.dart";
import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/dto/route_equipment.dart";
import "package:kisgeri24/data/dto/wall_dto.dart";
import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/sector.dart";
import "package:kisgeri24/data/models/wall.dart";
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

  testGetSectorsMultipleSectorsOrdered();
  testGetSectorsSingleSectorMultipleWallsOrdered();
  testGetSectorsSingleSectorMultipleRoutesOrdered();
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

void testGetSectorsMultipleSectorsOrdered() {
  configure();
  test(
      "Test getSectorsWithRoutes when ordered is true and multiple sectors are there",
      () async {
    List<Sector> sectorFromDb = [
      new Sector("testSectorName-1", testOrdinal, List.empty(),
          TestUtils.createRoute()),
      new Sector("testSectorName-2", testOrdinal + 1, List.empty(),
          TestUtils.createRoute(quantity: 2))
    ];
    when(mockSectorToSectorDtoConverter.convert(sectorFromDb[0]))
        .thenReturn(SectorDto(sectorFromDb[0].name, testOrdinal, List.empty()));
    when(mockSectorToSectorDtoConverter.convert(sectorFromDb[1])).thenReturn(
        SectorDto(sectorFromDb[1].name, testOrdinal + 1, List.empty()));
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(sectorFromDb));

    List<SectorDto> result =
        await underTest.getSectorsWithRoutes(ordered: true);

    expect(result != null, true);
    expect(result.length, sectorFromDb.length);
    expect(result[0].name, sectorFromDb[0].name);
    expect(result[1].name, sectorFromDb[1].name);
  });
}

void testGetSectorsSingleSectorMultipleRoutesOrdered() {
  configure();
  test(
      "Test getSectorsWithRoutes when ordered is true and a single sector is there with one wall and multiple routes",
      () async {
    List<Sector> sectorFromDb = [
      new Sector(
        "testSectorName-1",
        testOrdinal,
        TestUtils.createWall(quantity: 1, routeQuantity: 2),
        List.empty(),
      ),
    ];
    when(mockSectorToSectorDtoConverter.convert(sectorFromDb[0]))
        .thenReturn(SectorDto(sectorFromDb[0].name, testOrdinal, [
      WallDto(
        sectorFromDb[0].walls![0].name,
        sectorFromDb[0].walls![0].ordinal,
        [
          RouteDto(
            sectorFromDb[0].walls![0].routes[0].name,
            sectorFromDb[0].walls![0].routes[0].ordinal,
            sectorFromDb[0].walls![0].routes[0].difficulty.toString(),
            sectorFromDb[0].walls![0].routes[0].points,
            RouteEquipment.fromString(
                sectorFromDb[0].walls![0].routes[0].equipment),
          ),
          RouteDto(
            sectorFromDb[0].walls![0].routes[1].name,
            sectorFromDb[0].walls![0].routes[1].ordinal,
            sectorFromDb[0].walls![0].routes[1].difficulty.toString(),
            sectorFromDb[0].walls![0].routes[1].points,
            RouteEquipment.fromString(
                sectorFromDb[0].walls![0].routes[1].equipment),
          ),
        ],
      )
    ]));
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(sectorFromDb));

    List<SectorDto> result =
        await underTest.getSectorsWithRoutes(ordered: true);

    expect(result != null, true);
    expect(result[0].walls[0].routes[0].name,
        sectorFromDb[0].walls![0].routes[0].name);
    expect(result[0].walls[0].routes[1].name,
        sectorFromDb[0].walls![0].routes[1].name);
  });
}

void testGetSectorsSingleSectorMultipleWallsOrdered() {
  configure();
  test(
      "Test getSectorsWithRoutes when ordered is true and a single sector is there with multiple walls and no routes",
      () async {
    List<Sector> sectorFromDb = [
      new Sector(
        "testSectorName-1",
        testOrdinal,
        TestUtils.createWall(quantity: 2, routeQuantity: 0),
        List.empty(),
      ),
    ];
    when(mockSectorToSectorDtoConverter.convert(sectorFromDb[0]))
        .thenReturn(SectorDto(sectorFromDb[0].name, testOrdinal, [
      WallDto(
        sectorFromDb[0].walls![0].name,
        sectorFromDb[0].walls![0].ordinal,
        List.empty(),
      ),
      WallDto(
        sectorFromDb[0].walls![1].name,
        sectorFromDb[0].walls![1].ordinal,
        List.empty(),
      )
    ]));
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(sectorFromDb));

    List<SectorDto> result =
        await underTest.getSectorsWithRoutes(ordered: true);

    expect(result != null, true);
    expect(result[0].walls[0].name, sectorFromDb[0].walls![0].name);
    expect(result[0].walls[1].name, sectorFromDb[0].walls![1].name);
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
