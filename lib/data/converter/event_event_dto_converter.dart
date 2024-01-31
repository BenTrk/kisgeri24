import "dart:convert";

import "package:kisgeri24/data/dto/event_dto.dart";
import "package:kisgeri24/data/models/event.dart";
import "package:kisgeri24/logging.dart";

class EventToEventDtoConverter extends Converter<Event, EventDto> {
  @override
  EventDto convert(Event input) {
    logger.d("Converting Event [$input] to its corresponding DTO");
    return EventDto.all(
      input.id,
      input.yearId,
      input.name,
      input.startTime,
      input.endTime,
      input.details,
    );
  }
}
