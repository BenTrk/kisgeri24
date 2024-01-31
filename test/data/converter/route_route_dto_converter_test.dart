import "package:kisgeri24/data/converter/route_route_dto_converter.dart";
import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/dto/route_equipment.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:test/test.dart";

late RouteToRouteDtoConverter underTest;

void main() {
  testConvert();
}

void testConvert() {
  test('Convert', () {
    underTest = RouteToRouteDtoConverter();
    Route entity = new Route(
      name: 'routeName',
      id: "routeId",
      points: 123,
      length: 30,
      key: 1,
      difficulty: 6,
      diffchanger: "+",
    );
    RouteDto expected = new RouteDto(
      entity.name,
      entity.difficulty.toString() + entity.diffchanger,
      entity.points,
      RouteEquipment
          .bolted, // this needs to be updated once the issue #101 is resolved
    );

    expect(underTest.convert(entity) == expected, true);
  });
}
