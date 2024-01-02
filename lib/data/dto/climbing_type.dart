enum ClimbingType {
  lead("L"),
  topRope("T");

  final String shorthand;

  const ClimbingType(this.shorthand);

  static ClimbingType fromString(String type) {
    switch (type) {
      case "L":
        return ClimbingType.lead;
      case "T":
        return ClimbingType.topRope;
      default:
        throw Exception("Unknown climbing type: $type");
    }
  }
}
