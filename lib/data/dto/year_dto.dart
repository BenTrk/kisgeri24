class YearDto {
  String id;

  int year;

  String tenantId;

  int? compStart;

  int? compEnd;

  YearDto(this.id, this.year, this.tenantId);

  YearDto.all(this.id, this.year, this.tenantId, this.compStart, this.compEnd);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          year == other.year &&
          tenantId == other.tenantId &&
          compStart == other.compStart &&
          compEnd == other.compEnd;

  @override
  int get hashCode =>
      id.hashCode ^
      year.hashCode ^
      tenantId.hashCode ^
      compStart.hashCode ^
      compEnd.hashCode;

  @override
  String toString() {
    return "YearDto{id: $id, year: $year, tenantId: $tenantId, compStart: $compStart, compEnd: $compEnd}";
  }
}
