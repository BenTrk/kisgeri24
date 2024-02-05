import 'package:kisgeri24/data/models/wall.dart';
import "package:test/test.dart";

import "../../test_utils/test_utils.dart";

const String TEST_WALL_NAME = 'testWallName';

void main() {
  testWallEquality();
  testWallInequality();
  testWallInequalityWithNull();
  testWallInequalityWithDifferentType();
  testWallWhenHasSubRoute();
  testWallWhenHasNoSubRoute();
}

void testWallEquality() {
  test('Wall equality', () {
    Wall wall1 = new Wall(
        name: TEST_WALL_NAME, ordinal: testOrdinal, routes: List.empty());
    Wall wall2 = new Wall(
        name: TEST_WALL_NAME, ordinal: testOrdinal, routes: List.empty());

    expect(wall1 == wall2, true);
  });
}

void testWallInequality() {
  test('Wall inequality', () {
    Wall wall1 = new Wall(
        name: TEST_WALL_NAME, ordinal: testOrdinal, routes: List.empty());
    Wall wall2 = new Wall(
        name: 'testWallName2', ordinal: testOrdinal + 1, routes: List.empty());

    expect(wall1 == wall2, false);
  });
}

void testWallInequalityWithNull() {
  test('Wall inequality with null', () {
    Wall wall1 = new Wall(
        name: TEST_WALL_NAME, ordinal: testOrdinal, routes: List.empty());
    Wall? wall2 = null;

    expect(wall1 == wall2, false);
  });
}

void testWallInequalityWithDifferentType() {
  test('Wall inequality with different type', () {
    Wall wall1 = new Wall(
        name: TEST_WALL_NAME, ordinal: testOrdinal, routes: List.empty());
    String wall2 = TEST_WALL_NAME;

    expect(wall1 == wall2, false);
  });
}

void testWallWhenHasSubRoute() {
  test('Wall when has route', () {
    Map<String, dynamic> value = {
      'ordinal': 1,
      'route': {
        'ordinal': 1,
        'points': 123,
      }
    };

    Wall wall = Wall.fromSnapshot(TEST_WALL_NAME, value);

    expect(wall.name, TEST_WALL_NAME);
    expect(wall.routes.length, 1);
  });
}

void testWallWhenHasNoSubRoute() {
  test('Wall when has no route', () {
    Wall wall = Wall.fromSnapshot(TEST_WALL_NAME, {});

    expect(wall.name, TEST_WALL_NAME);
    expect(wall.routes.length, 0);
  });
}
