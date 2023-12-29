import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/logging.dart';

class Event extends Entity {
  String id;

  String yearId;

  String name;

  int startTime;

  int endTime;

  String? details;

  Event(this.id, this.yearId, this.name, this.startTime, this.endTime,
      this.details) {
    if (yearId.isEmpty) {
      throw ArgumentError('Year has to be specified for an event!');
    }
    if (name.isEmpty) {
      throw ArgumentError('The name of the event cannot be empty!');
    }
    if (startTime == 0) {
      throw ArgumentError('The event\'s start time has to be given!');
    }
  }

  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    logger.d('Creating Event instance based on the input JSON: $parsedJson');
    return Event(
        parsedJson['id'] ?? '',
        parsedJson['yearId'] ?? '',
        parsedJson['name'] ?? '',
        parsedJson['startTime'],
        parsedJson['endTime'],
        parsedJson['details'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'yearId': yearId,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'details': details
    };
  }

  bool equals(Event? event) =>
      event != null &&
      event.toJson().entries.every((entry) =>
          toJson().containsKey(entry.key) &&
          toJson()[entry.key] == entry.value);

  @override
  String toString() {
    return 'Event{id: $id, yearId: $yearId, name: $name, startTime: $startTime, endTime: $endTime, details: $details}';
  }

  static Event createWithExtraIdField(Map<String, dynamic> data, String id) {
    Event event = Event.fromJson(data);
    event.id = id;
    return event;
  }
}
