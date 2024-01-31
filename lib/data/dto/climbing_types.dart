enum ClimbingType {
  lead("L"),
  topRope("T"),
  clean("C");

  final String shorthand;

  const ClimbingType(this.shorthand);

  ClimbingType fromString(String type) {
    switch (type) {
      case "L":
        return ClimbingType.lead;
      case "T":
        return ClimbingType.topRope;
      case "C":
        return ClimbingType.clean;
      default:
        throw Exception("Unknown climbing type: $type");
    }
  }
}
