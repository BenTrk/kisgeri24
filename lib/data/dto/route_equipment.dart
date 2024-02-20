enum RouteEquipment {
  bolted("N"),
  topRope("T"),
  clean("C");

  final String shorthand;

  const RouteEquipment(this.shorthand);

  static RouteEquipment fromString(String equipment) {
    switch (equipment) {
      case "N":
        return RouteEquipment.bolted;
      case "C":
        return RouteEquipment.clean;
      case "T":
        return RouteEquipment.topRope;
      default:
        throw Exception("Unknown route equipment: $equipment");
    }
  }
}
