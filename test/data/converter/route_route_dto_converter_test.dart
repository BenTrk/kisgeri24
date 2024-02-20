import "package:kisgeri24/data/converter/route_route_dto_converter.dart";
import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/dto/route_equipment.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:test/test.dart";

import "../../test_utils/test_utils.dart";

late RouteToRouteDtoConverter underTest;

void main() {
  testConvert();
}

void testConvert() {
  test('Convert for bolted route', () {
    underTest = RouteToRouteDtoConverter();
    Route entity = TestUtils.createRoute(quantity: 1).first;
    entity.equipment = "N";

    RouteDto expected = new RouteDto(
      entity.name,
      entity.ordinal,
      entity.difficulty.toString() + entity.diffchanger,
      entity.points,
      RouteEquipment.bolted,
    );

    expect(underTest.convert(entity) == expected, true);
  });
  test('Convert for clean/trad route', () {
    underTest = RouteToRouteDtoConverter();
    Route entity = TestUtils.createRoute(quantity: 1).first;
    entity.equipment = "C";
    RouteDto expected = new RouteDto(
      entity.name,
      entity.ordinal,
      entity.difficulty.toString() + entity.diffchanger,
      entity.points,
      RouteEquipment.clean,
    );

    expect(underTest.convert(entity) == expected, true);
  });
  test('Convert for top-rope route', () {
    underTest = RouteToRouteDtoConverter();
    Route entity = TestUtils.createRoute(quantity: 1).first;
    entity.equipment = "T";
    RouteDto expected = new RouteDto(
      entity.name,
      entity.ordinal,
      entity.difficulty.toString() + entity.diffchanger,
      entity.points,
      RouteEquipment.topRope,
    );

    expect(underTest.convert(entity) == expected, true);
  });
  test(
      'Conversion attempt from a Route where the equipment type is not filled properly shall fail.',
      () {
    underTest = RouteToRouteDtoConverter();
    Route entity = TestUtils.createRoute(quantity: 1).first;
    entity.equipment = "";

    expect(
      () => underTest.convert(entity),
      throwsA(predicate((e) {
        if (e is Exception) {
          return e
              .toString()
              .contains("Unknown route equipment: ${entity.equipment}");
        }
        return false;
      })),
    );
  });
}
