import 'package:kisgeri24/data/models/sector.dart';
import 'package:kisgeri24/data/models/route.dart';
@GenerateNiceMocks([MockSpec<SectorRepository>()])
import 'package:kisgeri24/data/repositories/sector_repository.dart';
import 'package:kisgeri24/services/sector_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import "package:test/test.dart";

import 'sector_service_test.mocks.dart';

late SectorService underTest;
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
  test('Test sector name fetch when no sector can be fetched from DB',
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
  test('Test sector name fetch when a single sector can be fetched from DB',
      () async {
    List<Sector> sectorFromDb = [
      new Sector('testSectorName', List.empty(), List.empty())
    ];
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
  test('Test sector name fetch when a single sector can be fetched from DB',
      () async {
    List<Sector> sectorFromDb = [
      new Sector('testSectorName-1', List.empty(), List.empty()),
      new Sector('testSectorName-2', List.empty(), List.empty())
    ];
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
  test('Test getSectorsWithRoutes when no Sector can be fetched from the DB',
      () async {
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(List.empty()));

    List<Sector> result = await underTest.getSectorsWithRoutes();

    expect(result != null, true);
    expect(result.length, 0);
  });
}

void testGetSectorsWithRoutesSingleSector() {
  configure();
  test(
      'Test getSectorsWithRoutes when a single Sector can be fetched from the DB',
      () async {
    List<Sector> sectorsFromDb = [
      new Sector('testSectorName', List.empty(), List.empty())
    ];
    when(mockSectorRepository.fetchAll())
        .thenAnswer((_) async => Future.value(List.empty()));

    List<Sector> result = await underTest.getSectorsWithRoutes();

    expect(result != null, true);
    expect(result.length, sectorsFromDb.length);
    expect(result[0], sectorsFromDb[0]);
  });
}

void testGetSectorsWithRoutesMultipleSector() {
  configure();
  test('Test sector name fetch when a single sector can be fetched from DB',
      () async {
    List<Sector> sectorFromDb = [
      new Sector('testSectorName-1', List.empty(), createRoute()),
      new Sector('testSectorName-2', List.empty(), createRoute(quantity: 2))
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
    underTest = SectorService(mockSectorRepository);
  });
}

List<Route> createRoute({int quantity = 1}) {
  List<Route> routes = [];
  for (int i = 0; i < quantity; i++) {
    routes.add(new Route(
      length: quantity + 10,
      key: quantity + 11,
      difficulty: quantity,
      diffchanger: quantity % 2 == 0 ? '+' : '-',
      name: 'route-$i',
      points: quantity * 100,
    ));
  }
  return routes;
}
