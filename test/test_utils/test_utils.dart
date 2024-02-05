import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/dto/route_equipment.dart";
import 'package:kisgeri24/data/models/user.dart';
import 'package:kisgeri24/data/models/wall.dart';
import 'package:kisgeri24/data/dto/user_dto.dart';
import "package:kisgeri24/data/models/year.dart";

final Year testYear = Year.all(
  "Some Year ID",
  2024,
  "Some Tenant ID",
  1234567890,
  1234567891,
);

final UserDto testUserAsDto = UserDto(
  testUser.email,
  testUser.firstClimberName,
  testUser.secondClimberName,
  testUser.userID,
  testUser.teamName,
  testUser.category,
  testUser.appIdentifier,
  testUser.startTime,
  testUser.tenantId,
  testUser.yearId,
  testUser.enabled,
);

final User testUser = User(
  email: "someUser@email.com",
  category: "24H",
  firstClimberName: "First Test Climber",
  secondClimberName: "Second Test Climber",
  teamName: "Awesome Test Team",
  tenantId: "Some More Awesome Tenant ID",
  userID: "Even More Awesome User ID",
);

final int testOrdinal = 123;

class TestUtils {
  static List<RouteDto> createRouteDto({int quantity = 1}) {
    List<RouteDto> routes = [];
    for (int i = 0; i < quantity; i++) {
      routes.add(new RouteDto(
        "route-$i",
        i,
        "6b",
        30,
        RouteEquipment.values[i % RouteEquipment.values.length],
      ));
    }
    return routes;
  }

  static List<Route> createRoute({int quantity = 1}) {
    List<Route> routes = [];
    for (int i = 0; i < quantity; i++) {
      routes.add(new Route(
        length: quantity + 10,
        key: quantity + 11,
        difficulty: quantity,
        diffchanger: quantity % 2 == 0 ? "+" : "-",
        name: "route-$i",
        ordinal: i,
        points: quantity * 100,
      ));
    }
    return routes;
  }

  static List<Wall> createWall({int quantity = 1}) {
    List<Wall> walls = [];
    for (int i = 0; i < quantity; i++) {
      walls.add(new Wall(
        name: "wall-$i",
        ordinal: i,
        routes: createRoute(quantity: 1),
      ));
    }
    return walls;
  }
}
