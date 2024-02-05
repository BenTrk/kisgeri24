import 'package:kisgeri24/data/models/sector.dart';
import "package:test/test.dart";

import "../../test_utils/test_utils.dart";

const String TEST_SECTOR_NAME = 'testSectorName';

void main() {
  testSectorEquality();
  testSectorInequality();
  testSectorInequalityWithNull();
  testSectorInequalityWithDifferentType();
  testSectorWhenHasSubWall();
  testSectorWhenHasNoSubWall();
}

void testSectorEquality() {
  test('Sector equality', () {
    Sector sector1 =
        new Sector(TEST_SECTOR_NAME, testOrdinal, List.empty(), List.empty());
    Sector sector2 =
        new Sector(TEST_SECTOR_NAME, testOrdinal, List.empty(), List.empty());

    expect(sector1 == sector2, true);
  });
}

void testSectorInequality() {
  test('Sector inequality', () {
    Sector sector1 =
        new Sector(TEST_SECTOR_NAME, testOrdinal, List.empty(), List.empty());
    Sector sector2 = new Sector(
        'testSectorName2', testOrdinal + 1, List.empty(), List.empty());

    expect(sector1 == sector2, false);
  });
}

void testSectorInequalityWithNull() {
  test('Sector inequality with null', () {
    Sector sector1 =
        new Sector(TEST_SECTOR_NAME, testOrdinal, List.empty(), List.empty());
    Sector? sector2 = null;

    expect(sector1 == sector2, false);
  });
}

void testSectorInequalityWithDifferentType() {
  test('Sector inequality with different type', () {
    Sector sector1 =
        new Sector(TEST_SECTOR_NAME, testOrdinal, List.empty(), List.empty());
    String sector2 = TEST_SECTOR_NAME;

    expect(sector1 == sector2, false);
  });
}

void testSectorWhenHasSubWall() {
  test('Sector when has sub wall', () {
    Map<String, dynamic> value = {
      'wall': {
        'ordinal': 1,
        'route': {
          'ordinal': 1,
          'points': 123,
        }
      }
    };

    Sector sector = Sector.fromSnapshot(TEST_SECTOR_NAME, value);

    expect(sector.name, TEST_SECTOR_NAME);
    expect(sector.walls!.length, 1);
    expect(sector.routes!.length, 0);
  });
}

void testSectorWhenHasNoSubWall() {
  test('Sector when has no sub wall', () {
    Map<String, dynamic> value = {
      'route': {
        'ordinal': 1,
        'points': 123,
      }
    };

    Sector sector = Sector.fromSnapshot(TEST_SECTOR_NAME, value);

    expect(sector.name, TEST_SECTOR_NAME);
    expect(sector.walls!.length, 0);
    expect(sector.routes!.length, 1);
  });
}
