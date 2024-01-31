enum RouteEquipment {
  bolted("N"),
  clean("C");

  final String shorthand;

  const RouteEquipment(this.shorthand);

  RouteEquipment fromString(String equipment) {
    switch (equipment) {
      case "N":
        return RouteEquipment.bolted;
      case "C":
        return RouteEquipment.clean;
      default:
        throw Exception("Unknown route equipment: $equipment");
    }
  }
}
