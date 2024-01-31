import "package:kisgeri24/data/converter/sector_sector_dto_converter.dart";
@GenerateNiceMocks([MockSpec<RouteToRouteDtoConverter>()])
import "package:kisgeri24/data/converter/route_route_dto_converter.dart";
import "package:kisgeri24/data/dto/route_equipment.dart";
import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/dto/wall_dto.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/sector.dart";
import "package:kisgeri24/data/models/wall.dart";

import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";

import "sector_sector_dto_converter_test.mocks.dart";

import "../../test_utils/test_utils.dart";

import "dart:convert";

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
    Sector sector = new Sector(testSectorName, List.empty(), List.empty());
    SectorDto result = underTest.convert(sector);

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
    List<Route> routes = TestUtils.createRoute(quantity: 1);
    Sector sector = new Sector(testSectorName, List.empty(), routes);
    when(mockRouteConverter.convert(routes[0])).thenReturn(RouteDto(
        routes[0].name,
        routes[0].difficulty.toString() + routes[0].diffchanger,
        routes[0].points,
        RouteEquipment.bolted));

    SectorDto result = underTest.convert(sector);

    expect(result != null, true);
    expect(result.name, sector.name);
    expect(result.walls.length, 1);
    expect(result.walls[0].name, sector.name);
    expect(result.walls[0].routes.length, 1);
    expect(result.walls[0].routes[0].name, routes[0].name);
  });
}

void testConvertIfWallsNotEmpty() {
  test(
      "Test convert if walls are not empty, then result walls should also be not empty",
      () {
    List<Wall> walls = TestUtils.createWall(quantity: 1);
    Sector sector = new Sector(testSectorName, walls, List.empty());
    List<Route> routes = TestUtils.createRoute(quantity: 1);
    when(mockRouteConverter.convert(routes[0])).thenReturn(RouteDto(
        routes[0].name,
        routes[0].difficulty.toString() + routes[0].diffchanger,
        routes[0].points,
        RouteEquipment.bolted));

    SectorDto result = underTest.convert(sector);

    expect(result != null, true);
    expect(result.name, sector.name);
    expect(result.walls.length, 1);
    expect(result.walls[0].name, walls[0].name);
    expect(result.walls[0].routes.length, 1);
    expect(result.walls[0].routes[0].name, routes[0].name);
  });
}
