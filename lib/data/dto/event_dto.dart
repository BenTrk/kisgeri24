class EventDto {
  String id;

  String yearId;

  String name;

  int startTime;

  int endTime;

  String? details;

  EventDto(
    this.id,
    this.yearId,
    this.name,
    this.startTime,
    this.endTime,
  );

  EventDto.all(
    this.id,
    this.yearId,
    this.name,
    this.startTime,
    this.endTime,
    this.details,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          yearId == other.yearId &&
          name == other.name &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          details == other.details;

  @override
  int get hashCode =>
      id.hashCode ^
      yearId.hashCode ^
      name.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      details.hashCode;

  @override
  String toString() {
    return "EventDto{id: $id, yearId: $yearId, name: $name, startTime: $startTime, endTime: $endTime, details: $details}";
  }
}
