class UserDto {
  String email;

  String firstClimberName;

  String secondClimberName;

  String userID;

  String teamName;

  String category;

  String appIdentifier;

  int startTime;

  String tenantId;

  String yearId;

  bool enabled;

  UserDto(
    this.email,
    this.firstClimberName,
    this.secondClimberName,
    this.userID,
    this.teamName,
    this.category,
    this.appIdentifier,
    this.startTime,
    this.tenantId,
    this.yearId,
    this.enabled,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDto &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          firstClimberName == other.firstClimberName &&
          secondClimberName == other.secondClimberName &&
          userID == other.userID &&
          teamName == other.teamName &&
          category == other.category &&
          appIdentifier == other.appIdentifier &&
          startTime == other.startTime &&
          tenantId == other.tenantId &&
          yearId == other.yearId &&
          enabled == other.enabled;

  @override
  int get hashCode =>
      email.hashCode ^
      firstClimberName.hashCode ^
      secondClimberName.hashCode ^
      userID.hashCode ^
      teamName.hashCode ^
      category.hashCode ^
      appIdentifier.hashCode ^
      startTime.hashCode ^
      tenantId.hashCode ^
      yearId.hashCode ^
      enabled.hashCode;

  @override
  String toString() {
    return "UserDto{email: $email, firstClimberName: $firstClimberName, secondClimberName: $secondClimberName, userID: $userID, teamName: $teamName, category: $category, appIdentifier: $appIdentifier, startTime: $startTime, tenantId: $tenantId, yearId: $yearId, enabled: $enabled}";
  }
}
