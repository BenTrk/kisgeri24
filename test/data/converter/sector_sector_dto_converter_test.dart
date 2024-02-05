import "dart:convert";

@GenerateNiceMocks([MockSpec<RouteToRouteDtoConverter>()])
import "package:kisgeri24/data/converter/route_route_dto_converter.dart";
import "package:kisgeri24/data/converter/sector_sector_dto_converter.dart";
import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/dto/route_equipment.dart";
import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/sector.dart";
import "package:kisgeri24/data/models/wall.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";

import "../../test_utils/test_utils.dart";
import "sector_sector_dto_converter_test.mocks.dart";

final String testSectorName = "testSectorName";

late Converter<Route, RouteDto> mockRouteConverter;
late SectorToSectorDtoConverter underTest;

void main() {
  mockRouteConverter = MockRouteToRouteDtoConverter();
  underTest = SectorToSectorDtoConverter(mockRouteConverter);

  testConvertIfWallsAndRoutesAreEmpty();
  testConvertIfWallsAreEmptyButRoutesAreNotEmpty();
  testConvertIfWallsNotEmpty();
}

void testConvertIfWallsAndRoutesAreEmpty() {
  test(
      "Test convert if walls and routes are empty, then result walls should also be empty",
      () {
    final Sector sector =
        new Sector(testSectorName, testOrdinal, List.empty(), List.empty());
    final SectorDto result = underTest.convert(sector);

    expect(result != null, true);
    expect(result.name, sector.name);
    expect(result.walls.length, 1);
    expect(result.walls[0].name, sector.name);
    expect(result.walls[0].routes.length, 0);
  });
}

void testConvertIfWallsAreEmptyButRoutesAreNotEmpty() {
  test(
      "Test convert if walls are empty but routes are not, then result walls should also be empty",
      () {
    final List<Route> routes = TestUtils.createRoute(quantity: 1);
    routes[0].ordinal = testOrdinal;
    final Sector sector =
        new Sector(testSectorName, testOrdinal, List.empty(), routes);
    when(mockRouteConverter.convert(routes[0])).thenReturn(RouteDto(
        routes[0].name,
        testOrdinal,
        routes[0].difficulty.toString() + routes[0].diffchanger,
        routes[0].points,
        RouteEquipment.bolted));

    final SectorDto result = underTest.convert(sector);

    expect(result != null, true);
    expect(result.name, sector.name);
    expect(result.walls.length, 1);
    expect(result.walls[0].name, sector.name);
    expect(result.walls[0].routes.length, 1);
    expect(result.walls[0].routes[0].name, routes[0].name);
    expect(result.walls[0].routes[0].ordinal, routes[0].ordinal);
  });
}

void testConvertIfWallsNotEmpty() {
  test(
      "Test convert if walls are not empty, then result walls should also be not empty",
      () {
    final int wallQuantity = 3;
    final List<Wall> walls = TestUtils.createWall(quantity: wallQuantity);
    final Sector sector =
        new Sector(testSectorName, testOrdinal, walls, List.empty());
    final List<Route> routes = TestUtils.createRoute(quantity: wallQuantity);
    routes[0].ordinal = testOrdinal;
    for (int i = 0; i < walls.length; i++) {
      walls[i].routes = [routes[i]];
      when(mockRouteConverter.convert(routes[i])).thenReturn(RouteDto(
          routes[i].name,
          routes[i].ordinal,
          routes[i].difficulty.toString() + routes[i].diffchanger,
          routes[i].points,
          RouteEquipment.bolted));
    }

    final SectorDto result = underTest.convert(sector);

    expect(result != null, true);
    expect(result.name, sector.name);
    expect(result.walls.length, wallQuantity);

    expect(result.walls[0].name, walls[0].name);
    expect(result.walls[0].routes.length, 1);
    expect(result.walls[0].routes[0].name, routes[0].name);
    expect(result.walls[0].routes[0].ordinal, routes[0].ordinal);

    expect(result.walls[1].name, walls[1].name);
    expect(result.walls[1].routes.length, 1);
    expect(result.walls[1].routes[0].name, routes[1].name);
    expect(result.walls[1].routes[0].ordinal, routes[1].ordinal);

    expect(result.walls[2].name, walls[2].name);
    expect(result.walls[2].routes.length, 1);
    expect(result.walls[2].routes[0].name, routes[2].name);
    expect(result.walls[2].routes[0].ordinal, routes[2].ordinal);
  });
}
