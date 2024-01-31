@GenerateNiceMocks([MockSpec<RouteToRouteDtoConverter>()])
import "package:kisgeri24/data/converter/route_route_dto_converter.dart";
import "package:kisgeri24/data/converter/wall_wall_dto_converter.dart";
import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/wall.dart";
import "package:kisgeri24/data/dto/wall_dto.dart";
import "package:kisgeri24/data/dto/user_dto.dart";
import "package:kisgeri24/data/models/user.dart";

import "../../test_utils/test_utils.dart";

import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";

import "dart:convert";

import "wall_wall_dto_converter_test.mocks.dart";

late Converter<Route, RouteDto> mockRouteConverter;
late WallToWallDtoConverter underTest;

void main() {
  mockRouteConverter = MockRouteToRouteDtoConverter();
  underTest = WallToWallDtoConverter(mockRouteConverter);

  testConvert();
}

void testConvert() {
  test("Test convert from Wall to WallDto", () {
    Wall wall = TestUtils.createWall(quantity: 1)[0];
    RouteDto route = TestUtils.createRouteDto(quantity: 1)[0];
    when(mockRouteConverter.convert(wall.routes[0])).thenReturn(route);
    WallDto result = underTest.convert(wall);

    expect(result != null, true);
    expect(result.name, wall.name);
    expect(result.routes.length, wall.routes.length);
  });
}
